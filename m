From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] Asoc: sti: add CPU DAI driver for
	playback
Date: Fri, 24 Apr 2015 19:15:28 +0100
Message-ID: <20150424181528.GF22845@sirena.org.uk>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
 <1429018531-29025-4-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3601159539406706945=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BFB7D2605CE
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 20:15:38 +0200 (CEST)
In-Reply-To: <1429018531-29025-4-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3601159539406706945==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9pf9GnNAm/pV3ee7"
Content-Disposition: inline


--9pf9GnNAm/pV3ee7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2015 at 03:35:27PM +0200, Arnaud Pouliquen wrote:

> +const struct snd_pcm_hardware uni_player_pcm_hw =3D {
> +	.info		=3D (
> +	SNDRV_PCM_INFO_INTERLEAVED |
> +	SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +	SNDRV_PCM_INFO_PAUSE),
> +	.formats	=3D (SNDRV_PCM_FMTBIT_S32_LE |
> +	SNDRV_PCM_FMTBIT_S16_LE),

Please use the normal kernel coding style, standard indentation and no
brackets.

> +	.rates		=3D SNDRV_PCM_RATE_CONTINUOUS,
> +	.rate_min	=3D UNIPERIF_MIN_RATE,
> +	.rate_max	=3D UNIPERIF_MAX_RATE,
> +
> +	.channels_min	=3D UNIPERIF_MIN_CHANNELS,
> +	.channels_max	=3D UNIPERIF_MAX_CHANNELS,
> +
> +	.periods_min	=3D UNIPERIF_PERIODS_MIN,
> +	.periods_max	=3D UNIPERIF_PERIODS_MAX,
> +
> +	.period_bytes_min =3D UNIPERIF_PERIODS_BYTES_MIN,
> +	.period_bytes_max =3D UNIPERIF_PERIODS_BYTES_MAX,
> +	.buffer_bytes_max =3D UNIPERIF_BUFFER_BYTES_MAX

Just use the values directly, the indirection is just making it harder
to find what's actually set.

> +static inline int reset_player(struct uniperif *player)
> +{
> +	int count =3D 10;
> +
> +	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
> +		while (GET_UNIPERIF_SOFT_RST_SOFT_RST(player) && count) {
> +			udelay(5);
> +			count--;
> +		}

Braces for the if too.  A cpu_relax() wouldn't go amiss in here either.

> +static inline int get_property_hdl(struct device *dev, struct device_nod=
e *np,
> +				   const char *prop, int idx)
> +{

This is very suspicous - why do you need this and if you need it why not
add it to the generic DT code? =20

> +static void uni_player_work(struct work_struct *work)
> +{
> +	struct uniperif *player =3D
> +		container_of(work, struct uniperif, delayed_work.work);
> +
> +	spin_lock(&player->lock);
> +	if (uni_player_suspend(player))
> +		dev_err(player->dev, "%s: failed to suspend player", __func__);
> +	spin_unlock(&player->lock);
> +}

What is this for, and why is there a spinlock which isn't IRQ safe?  If
it's sensible to do this under a spinlock it seems like it might not
need to be done in a workqueue...

There's a lot of very coarse grained spinlock usage in this driver which
I'm having a hard time understanding, at the very least the decisions
about locking need to be documented much more clearly and I suspect that
either things need to be finer grained, we should be using mutexes more
or both.

> +static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
> +{
> +	irqreturn_t ret =3D IRQ_NONE;
> +	struct uniperif *player =3D dev_id;
> +	unsigned int status;
> +	unsigned int tmp;
> +
> +	/* Get interrupt status & clear them immediately */
> +	preempt_disable();
> +	status =3D GET_UNIPERIF_ITS(player);
> +	SET_UNIPERIF_ITS_BCLR(player, status);
> +	preempt_enable();

preempt_disable()?  Why is this being done, if you're doing unusual
stuff like this the code needs to be very clear about what the locking
rules are?

> +
> +	if ((player->state =3D=3D UNIPERIF_STATE_STANDBY) ||
> +	    (player->state =3D=3D UNIPERIF_STATE_STOPPED)) {
> +		/* unexpected IRQ: do nothing */
> +		dev_warn(player->dev, "unexpected IRQ: status flag: %#x",
> +			 status);
> +		return IRQ_HANDLED;

We didn't handle it, we ignored it (after acknowledging it...).  I'd
expect this check to be before we look at the hardware if it's needed.

> +	};

Extra semicolon here.

> +	snd_pcm_stream_lock(player->substream);

Again please explain the locking if we're doing something unusual.

> +	/* Check for fifo error (under run) */
> +	if (unlikely(status & UNIPERIF_ITS_FIFO_ERROR_MASK(player))) {
> +		dev_err(player->dev, "FIFO underflow error detected");
> +
> +		/* Interrupt is just for information when underflow recovery */
> +		if (player->info->underflow_enabled) {
> +			/* Update state to underflow */
> +			player->state =3D UNIPERIF_STATE_UNDERFLOW;

Why would underflow recovery be optional?

> +	if (clk_set_rate(player->clk, rate_adjusted) < 0) {
> +		dev_err(player->dev, "Failed to clk set rate %d !\n",
> +			rate_adjusted);
> +		return -EINVAL;
> +	}

Pass back the error code you got.

> +	rate_achieved =3D clk_get_rate(player->clk);
> +	if (!rate_achieved)
> +		return -EINVAL;

That check doesn't seem right - if the clock was set to 1Hz instead of
1MHz it'll report success.  Either trust that clk_set_rate() will give
you an error if it fails or have some sort of reasonable check on the
actual set value if that's important.

> +static int snd_sti_clk_adjustment_get(struct snd_kcontrol *kcontrol,
> +				      struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct uniperif *player =3D snd_kcontrol_chip(kcontrol);
> +
> +	spin_lock(&player->lock);
> +	ucontrol->value.integer.value[0] =3D player->clk_adj;
> +	spin_unlock(&player->lock);
> +
> +	return 0;
> +}

There was some discussion of interfaces for fine tuning clock rates with
some other drivers recently, we need to think about this in some
standard fashion.  Please split this out into a separate patch.  In
general it's best to introduce unusual/new things like this and the IEC
setting in separate patches to simplify review and allow the easy bits
to get merged without being held up by complicated things like this.

> +	of_property_read_u32(pnode, "version", &info->ver);
> +
> +	of_property_read_u32(pnode, "uniperiph-id", &info->uni_num);

We can't read this stuff from the hardware?

--9pf9GnNAm/pV3ee7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOog/AAoJECTWi3JdVIfQ9XcH/igbDRYSrZ/Z2vFi5aEyAXpp
XGPRAIkMX/3pzoM/xEbuZpnhJtYxedNbKnHRGMPlaVTR6HM7MuN4ttVJPkQv4XnG
Zi3ffxxq2RpnveH8v6wouupheaktoSkrkYN049Jcvugr2oEiorR+Ze/fz7HWuX/J
r543Z7RsfD1+jR1qLl3jy6ZmVVdt7NqL/DhAyRLsmc1VprwXiDAgr9C96kR6zVRY
pGl+TfYCnkgXP8tpDmDWurYzk6E5DylRUkwDD9A1KQOCMn5BERBUMw66L6wnLy9A
+HyyaTs0KCML/jHCSHSQfYhT2l0Wr8I/d2YRU7zm/4e3iQn4hbOLJX+F95p41QE=
=VPT0
-----END PGP SIGNATURE-----

--9pf9GnNAm/pV3ee7--

--===============3601159539406706945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3601159539406706945==--
