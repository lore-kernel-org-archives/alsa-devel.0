From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/10] ALSA: axd: add basic files for
 sending/receiving axd cmds
Date: Wed, 26 Aug 2015 20:16:42 +0100
Message-ID: <20150826191642.GG28760@sirena.org.uk>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-7-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3582254623393558283=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BF566260532
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 21:16:54 +0200 (CEST)
In-Reply-To: <1440419959-14315-7-git-send-email-qais.yousef@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3582254623393558283==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="df+09Je9rNq3P+GE"
Content-Disposition: inline


--df+09Je9rNq3P+GE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2015 at 01:39:15PM +0100, Qais Yousef wrote:

> +int axd_cmd_set_pc(struct axd_cmd *cmd, unsigned int thread, unsigned lo=
ng pc)
> +{
> +	if (thread >=3D THREAD_COUNT)
> +		return -1;

Return sensible error codes please.

> +unsigned long  axd_cmd_get_datain_address(struct axd_cmd *cmd)
> +{
> +	struct axd_dev *axd =3D container_of(cmd, struct axd_dev, cmd);
> +
> +	return (unsigned long) axd->buf_base_m;
> +}

What's going on with these casts?

> +static inline void axd_set_flag(unsigned int *flag, unsigned int value)
> +{
> +	*flag =3D value;
> +	smp_wmb();	/* guarantee smp ordering */
> +}
> +
> +static inline unsigned int axd_get_flag(unsigned int *flag)
> +{
> +	smp_rmb();	/* guarantee smp ordering */
> +	return *flag;
> +}

Please use a normal locking construct rather than hand rolling
something, or alternatively introduce new generic operations.  The fact
that you're hand rolling these things that have no driver specific
content is really worrying in terms of their safety.

> +/*
> + * axd_pipe->enabled_flg for output pipes is overloaded to mean two thin=
gs:
> + *
> + * - PIPE_STARTED: indicates that pipe was opened but no buffers were pa=
ssed.
> + *   When stopping the pipes, we know that we don't need to discard anyt=
hing if
> + *   the discard_flg is set in cmd struct. Which allows us to terminate =
easily
> + *   and quickly.
> + *
> + * - PIPE_RUNNING: indicates that pipe has processed some buffers, so we=
 should
> + *   discard if user terminates early (and discard_flg is set in cmd str=
uct).
> + */
> +#define PIPE_STARTED	1
> +#define PIPE_RUNNING	2

Why is the case with in place buffers not a simple zero iteration loop?

> +#ifdef AXD_DEBUG_DIAG
> +static unsigned int inSentCount[AXD_MAX_PIPES];
> +static unsigned int inRecvCount[AXD_MAX_PIPES];
> +static unsigned int outSentCount[AXD_MAX_PIPES];
> +static unsigned int outRecvCount[AXD_MAX_PIPES];
> +static unsigned int primeupCount[AXD_MAX_PIPES];
> +static unsigned int read_size[AXD_MAX_PIPES];
> +static unsigned int write_size[AXD_MAX_PIPES];
> +static unsigned int recv_size[AXD_MAX_PIPES];

No static globals and please follow the kernel coding style.

> +static inline void axd_datain_kick(struct axd_pipe *axd_pipe)
> +{
> +	unsigned long flags;
> +	struct axd_memory_map __iomem *message =3D axd_pipe->cmd->message;
> +	unsigned int pipe =3D axd_pipe->id;
> +	unsigned int temp;
> +
> +#ifdef AXD_DEBUG_DIAG
> +	inSentCount[pipe]++;
> +#endif

Define accessor macros for these and then define them to noops when not
debugging rather than having #defines in the code.

> +static irqreturn_t axd_irq(int irq, void *data)
> +{
> +	struct axd_cmd *cmd =3D data;
> +	unsigned int int_status;
> +	unsigned long flags;
> +	int i, ret;
> +
> +	/*
> +	 * int_status is ioremapped() which means it could page fault. When axd
> +	 * is running on the same core as the host, holding lock2 would disable
> +	 * exception handling in that core which means a page fault would stuff
> +	 * host thread executing the driver. We do a double read here to ensure
> +	 * that we stall until the memory access is done before lock2 is
> +	 * acquired, hence ensuring that any page fault is handled outside lock2
> +	 * region.
> +	*/
> +	int_status =3D ioread32(&cmd->message->int_status);
> +	int_status =3D ioread32(&cmd->message->int_status);

Eew.

> +
> +	axd_platform_irq_ack();

When would this ever be called anywhere else?  Just inline it (and it's
better practice to only ack things we handle...).

> +	flags =3D axd_platform_lock();
> +	int_status =3D ioread32(&cmd->message->int_status);
> +	iowrite32(0, &cmd->message->int_status);
> +
> +	if (!int_status)
> +		goto out;

This should cause us to return IRQ_NONE.

> +	if (int_status & AXD_INT_ERROR) {
> +		struct axd_dev *axd =3D container_of(cmd, struct axd_dev, cmd);
> +		int error =3D ioread32(&cmd->message->error);
> +
> +		pr_debug("<---- Received error interrupt\n");
> +		switch (error) {
> +		default:
> +		case 0:
> +			break;

We just ignore these?

> +		case 2:
> +			dev_warn(axd->dev, "Failed to set last configuration command\n");
> +			break;

Does the configuration command notice?

> +	/*
> +	 * if we could lock the semaphore, then we're guaranteed that the
> +	 * current rd_idx is valid and ready to be used. So no need to verify
> +	 * that the status of the descriptor at rd_idx is valid.
> +	 */
> +	spin_lock(&desc_ctrl->rd_lock);

It really feels like this locking is all complicated and fragile.  I'm
not entirely sure the optimisation is worth it - are we really sending
compressed audio at such a high rate that it's worth having concurrency
handling that's hard to think about?

> +void axd_cmd_free_irq(struct axd_cmd *cmd, unsigned int irqnum)
> +{
> +	flush_workqueue(cmd->in_workq);

_sync()

> +	destroy_workqueue(cmd->in_workq);
> +	flush_workqueue(cmd->out_workq);
> +	destroy_workqueue(cmd->out_workq);
> +	free_irq(irqnum, cmd);

We're freeing the interrupts after we destroy the workqueue which means
we could try to schedule new work after destruction.

> +	/*
> +	 * Based on the defined axd_pipe->buf_size and number of input pipes
> +	 * supported by the firmware, we calculate the number of descriptors we
> +	 * need to use using this formula:
> +	 *
> +	 *	axd_pipe->buf_size * num_desc =3D total_size / num_inputs
> +	 */
> +	num_desc =3D total_size / (cmd->num_inputs * axd_pipe->buf_size);

I'm not sure that was an especially tricky line of code to follow...  am
I missing something here?

I've stopped reviewing here mostly because it's the end of my day and
this patch is 72K which is enormous for something that's not just lots
of defines or whatever and actually needs reading in considerable detail
given all the tricky concurrency stuff you're doing.  Please split this
code up into multiple patches for ease of review.  For example all the
queue management and allocation seems rather separate to the interrupt
handling. =20

It also feels like there's room for pruning the code, perhaps sharing
more of it between input and output paths and removing some layers of
abstraction. =20

--df+09Je9rNq3P+GE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3hCZAAoJECTWi3JdVIfQPLIH/2g4wIYQFOM/onn07F6iUkw8
25OYUqRIMXCG5ZP6Fs6rfbgqbbQO34OlMYZV69DO218KtZYcuZj1urAqWBlUsH2M
+THv0VK7/YVIPsFHmUY9ci2jaI3TQSZ315ODlfUJF+qVu445ZpAOazvPsmW9bFSC
9v7plAnGpReNKO/JBSc/irLQcIkwTurBHwTirAsXMH5QtMNW2EjtxSMLJGyWnp2p
hoidHm/b6vcV53NwU/yS01MxZUVgHRrmgYRZo5R4XbdwrDh5ZNRDGpOFor82TQOj
a0tKrI5sdf1uIRc5SE9YkQYLrLbrrTRDx0/m3FDfNjhRnyxmBTI6VkgHFlm2jVQ=
=QAZ8
-----END PGP SIGNATURE-----

--df+09Je9rNq3P+GE--

--===============3582254623393558283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3582254623393558283==--
