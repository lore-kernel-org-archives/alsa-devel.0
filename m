From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ASoC: OMAP: Fix DSP DAI format in McBSP
 DAI driver
Date: Wed, 22 Oct 2008 13:59:37 +0300
Message-ID: <20081022135937.c3df238f.jarkko.nikula@nokia.com>
References: <1224505799-16686-1-git-send-email-jarkko.nikula@nokia.com>
	<dfeb90390810220256t41015140l57cb3fb584e24da0@mail.gmail.com>
	<20081022131225.b162289e.jarkko.nikula@nokia.com>
	<20081022102935.GC7640@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id EB28A24536
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 13:00:24 +0200 (CEST)
In-Reply-To: <20081022102935.GC7640@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: ext Arun KS <getarunks@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Oct 2008 11:29:36 +0100
"ext Mark Brown" <broonie@sirena.org.uk> wrote:

> On Wed, Oct 22, 2008 at 01:12:25PM +0300, Jarkko Nikula wrote:
> 
> > > This is modifying what machine driver has chosen. AM I missing something?
> 
> > Since as a McBSP sense, the normal polarities in DSP format (or
> > according to AIC33 DSP mode...) were different than in I2S. Idea is to
> > keep codec and cpu configuration in sync in the machine driver, i.e.
> > same bit clock and frame sync polarity configuration
> 
> Hrm - this suggests that one or more of your codec drivers may be
> getting this wrong.  I would expect that the inversion of bit and frame
> clocks should be with respect to the normal behaviour of the mode, not
> with respect to I2S mode.

Yep, that was the idea. As I told before I made this patch according
to DSP mode of AIC33 which seems to be somewhat near DSP_B but not the
the same e.g. what WM9713 is using. So at least have to do some changes
into AIC33 driver to not claim to support DSP_A.

Can you Arun test does the following fix on top of my original patch
work on OSK? My codec is Tektronix TDS2024 connected into Beagle
so cannot hear is it playing correctly :-)


Jarkko

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 853b33a..4e86d52 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -265,7 +265,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		regs->srgr2	|= FPER(wlen * 2 - 1);
-		regs->srgr1	|= FWID(0);
+		regs->srgr1	|= FWID(wlen * 2 - 2);
 		break;
 	}
 
@@ -307,8 +307,6 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		/* 0-bit data delay */
 		regs->rcr2      |= RDATDLY(0);
 		regs->xcr2      |= XDATDLY(0);
-		/* Invert bit clock and FS polarity configuration for DSP_A */
-		temp_fmt ^= SND_SOC_DAIFMT_IB_IF;
 		break;
 	default:
 		/* Unsupported data format */
