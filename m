From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re:
 =?iso-8859-1?q?No_sound_captured_with_SGTL5000_on_i?=
 =?iso-8859-1?q?=2EMX6_in_I=B2S_master_mode?=
Date: Thu, 18 Sep 2014 19:26:11 +0200
Message-ID: <20140918172611.GA17048@panicking>
References: <CAL8zT=hSCpBZpqVGQ5uBdXJe25hqoNkmiPh_Ge3RCrGALkaoZg@mail.gmail.com>
 <CAOMZO5CReW7-8L7zx=z1TshwJSzcfGThCjws7fTfbZJKCnCZLg@mail.gmail.com>
 <CAOf5uwmrsuXSCpUXhf3pTCRt0=4pprwfiP5MDDukE=WRzOk2WA@mail.gmail.com>
 <CAL8zT=jw4QQSzoq_8d0j-SXYEWzsNgz279dhDzjTHHr-jutP=Q@mail.gmail.com>
 <CAOf5uw=R0oHGDyFhueepoftfDb_d4vccO_751apBLg7S3gzGjg@mail.gmail.com>
 <CAL8zT=gcYkCRE9TU+2w+qBDtM+gYKqr-0KRDy7UxQXJ0P3LutQ@mail.gmail.com>
 <CAL8zT=igU9F=MZ0dQSgqgkq-T=PV-jbXAZeYAaMDs1ot_1MjCg@mail.gmail.com>
 <20140918170524.GA6080@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id A0CB9261ABB
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 19:26:19 +0200 (CEST)
Received: by mail-wi0-f170.google.com with SMTP id em10so7127394wid.1
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 10:26:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140918170524.GA6080@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Shengjiu Wang <shengjiu.wang@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Jean-Michel Hautbois <jean-michel.hautbois@vodalys.com>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawn.guo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Thu, Sep 18, 2014 at 10:05:24AM -0700, Nicolin Chen wrote:
> On Thu, Sep 18, 2014 at 06:09:50PM +0200, Jean-Michel Hautbois wrote:
> > Well, audmux is not getting clock, this is normal I think, the clock I
> > was mentionning is the MCLK of SGTL5000 and this one is linked to
> > FPGA, but found after all.
> > I now had a further look into sound/soc/fsl/fsl_ssi.c and I see this :
> > 
> >     sprop = of_get_property(np, "fsl,mode", NULL);
> >     if (sprop) {
> >         if (!strcmp(sprop, "ac97-slave"))
> >             ssi_private->dai_fmt = SND_SOC_DAIFMT_AC97;
> >         else if (!strcmp(sprop, "i2s-slave"))
> >             ssi_private->dai_fmt = SND_SOC_DAIFMT_I2S |
> >                 SND_SOC_DAIFMT_CBM_CFM;
> >     }
> > 
> > I may have missed something, but it seems that i2s-master is not
> > parsed, and does not set dai_fmt ?
> 
> Actually this is kind of obsolete property because initially the SSI
> driver only supported i2s-slave. We've put an i2s-slave check here is
> to limit the driver by excluding other modes.
> 
> But now, the driver has the capability to derive clock from CCM and
> output it for external CODEC. So this one could be dropped in fact
> rather than adding a new i2s-master case IMO.
> 
> > arecord -v -V stereo -f cd -D hw:0,0 somefile.wav
> > Recording WAVE 'somefile.wav' : Signed 16 bit Little Endian, Rate
> > 44100 Hz, Stereo
> 
> > arecord: pcm_read:2031: read error: Input/output error
> 
> The problem here should be the AUDMUX configuration issue. The imx-
> sgtl5000.c driver only supports CODEC in master mode. So if you try
> to switch the CODEC slave mode, you shall also change not only the
> CBM_CFM to CBS_CFS but also swap the ext_port and int_port of AUDMUX
> (a little confusing approach here as the configuration of AUDMUX is
> routing the data and clocks from a source port to a destination port
> while each of side, external or internal, might be a source port --
> When using CBM_CFM, the source port should be external port; while
> using CBS_CFS, the source port should be the internal port.)
> 
> There may be another topic, however, actually the fsl-asoc-card
> driver does handle the master/slave mode supports. So if you are
> trying to add the CODEC slave mode support into imx-sgtl5000. I
> suggest you to try the fsl-asoc-card instead. Its DT binding's
> totally compatible with imx-sgtl5000's. What you need to do is
> just enable it (and disable imx-sgtl500) in the menuconfig or
> add these enable/disable into imx_v6_v7_defconfig.
> 

bug was reported by Jean-Michel. I don't know if it works because I can not
test but seems ok. Do we need this _set_dai_fmt in probe function?

code is a bit broken just because panic on probe path if pdev is null
[...]
	/*
	 * If codec-handle property is missing from SSI node, we assume
	 * that the machine driver uses new binding which does not require
	 * SSI driver to trigger machine driver's probe.
	 */
	if (!of_get_property(np, "codec-handle", NULL))
		goto done;
[...]
	ssi_private->pdev =
		platform_device_register_data(&pdev->dev, name, 0, NULL, 0);
[...]
done:
	if (ssi_private->dai_fmt)
		_fsl_ssi_set_dai_fmt(ssi_private, ssi_private->dai_fmt);


diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 87eb577..f63bc02 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -758,7 +758,8 @@ static int _fsl_ssi_set_dai_fmt(struct fsl_ssi_private *ssi_private,
 	ssi_private->dai_fmt = fmt;
 
 	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->baudclk)) {
-		dev_err(&ssi_private->pdev->dev, "baudclk is missing which is necessary for master mode\n");
+		pr_err("baudclk is missing which is necessary"
+			" for master mode\n");
 		return -EINVAL;
 	}
 

Michael

> Nicolin
