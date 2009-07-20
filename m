From: John Bonesio <bones@secretlab.ca>
Subject: AC97 on pcm030 board with WM9712 codec
Date: Mon, 20 Jul 2009 16:29:11 -0700
Message-ID: <1248132551.6532.267.camel@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id E18622414B
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jul 2009 01:29:28 +0200 (CEST)
Received: by wf-out-1314.google.com with SMTP id 24so813900wfg.23
	for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2009 16:29:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I've been working with Grant Likely exploring an existing issue with
resetting the AC97 system on the pcm030 board. The easiest way to
produce the problem is by power cycling the board and seeing if the AC97
and wm9712 codec show up in /sys/bus/ac97.

I wanted to share with you folks to make sure there's not something else
going on that I should be looking at, and if the results I'm seeing seem
to make sense.

A bit of background for those not familiar with this area of the code:

When the board powers up, a reset() message is sent to the wm9712 codec
driver which then calls the AC97 driver to perform a cold reset. The
AC97 driver performs the cold reset by yanking the reset line on the
AC97 link. The AC97 driver also calls warm_reset() after the cold reset
is complete. Earlier the warm_reset() call was added in the AC97
cold_reset() routine to attempt to solve this bug, but it appears to not
completely solve the issue. After the reset the wm9712 driver attempts
to read a register. If the register value is verified the driver assumes
the reset was a success, otherwise it flags an error.

The code for the routines we're using is included here for reference.

------- code snippets -------
static int wm9712_reset(struct snd_soc_codec *codec, int try_warm)
{
	if (try_warm && soc_ac97_ops.warm_reset) {
		soc_ac97_ops.warm_reset(codec->ac97);
		if (ac97_read(codec, 0) == wm9712_reg[0])
			return 1;
	}

	soc_ac97_ops.reset(codec->ac97);
	if (ac97_read(codec, 0) != wm9712_reg[0])
		goto err;
	return 0;

err:
	printk(KERN_ERR "WM9712 AC97 reset failed\n");
	return -EIO;
}

static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
{
	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;

	/* Do a cold reset */
	out_8(&regs->op1, MPC52xx_PSC_OP_RES);
	udelay(10);
	out_8(&regs->op0, MPC52xx_PSC_OP_RES);
	udelay(50);

	psc_ac97_warm_reset(ac97);
}

static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
{
	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;

	out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_AWR);
	udelay(3);
	out_be32(&regs->sicr, psc_dma->sicr);
}
------- end code snippets -------

I've explored the following possibilities:
1. SDATAOUT or SYNC lines were non-zero during reset, putting the codec
chip into a test mode.
2. Perhaps the cold_reset is not necessary and the warm_reset is all
that is needed
3. The delay between the cold reset and the warm reset was not long
enough.

Possibility #1

I added some test code to force the pcm030 board to use gpio instead of
the ac97 to perform the reset. This way the SDATAOUT and the SYNC
signals can be forced to 0 while resetting. What I discovered is that
this didn't seem to make a difference. I don't know if these signals
might contain uninitialized values on power up. Should I still consider
this as a potential problem, or is this pretty much a non-issue?

Possibility #2

I tried taking out the cold reset code in the AC97 driver in hopes that
perhaps the hardware would come up in a good state on its own. This
didn't work at all. I put the cold reset code back in.

Possibility #3

I stumbled upon this when I added a printk to make sure I correctly
understood the flow of control. With the printk in place, the problem
would go away. So instead I increased the length of time in the udelay()
call right before the call to warm_reset(). I've empirically found that
delaying 1ms (udelay(50) -> udelay(1000)) seems to avoid the problem.
I'm not sure why this delay is necessary, or if it makes sense for the
hardware to need this much time to come out of the cold reset.

Thanks for your help.

Cheers,
- John
