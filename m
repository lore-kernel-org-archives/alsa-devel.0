From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Add Freescale SGTL5000 codec
 support
Date: Wed, 16 Feb 2011 15:01:18 -0800
Message-ID: <20110216230117.GA6551@opensource.wolfsonmicro.com>
References: <1297810576-2575-1-git-send-email-zhaoming.zeng@freescale.com>
	<AANLkTi=xvpWqnChvyJvDVjCK8dH3rfd75e0c43x8a1JP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E6567103870
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 00:00:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTi=xvpWqnChvyJvDVjCK8dH3rfd75e0c43x8a1JP@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur.tabi@gmail.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, zengzm.kernel@gmail.com, zhaoming.zeng@freescale.com, linuxzsc@gmail.com, arnaud.patard@rtp-net.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 16, 2011 at 04:20:37PM -0600, Timur Tabi wrote:

> > +static int sgtl5000_suspend(struct snd_soc_codec *codec, pm_message_t =
state)
> > +{
> > + =A0 =A0 =A0 sgtl5000_set_bias_level(codec, SND_SOC_BIAS_OFF);
> > +
> > + =A0 =A0 =A0 return 0;
> > +}

> #ifdef CONFIG_PM ?

Should be CONFIG_SUSPEND.

> > + =A0 =A0 =A0 memcpy((void *)(&sgtl5000_regs[0] + (SGTL5000_DAP_REG_OFF=
SET >> 1)),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sgtl5000_dap_regs,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x3a);

> I don't think you need the "(void *)"

You never need to cast to void in C.  C++ requires this but not C.
