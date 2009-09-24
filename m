From: Rick Bronson <rick@efn.org>
Subject: WM8731 using I2S on omap3 McBSP2 issues
Date: Thu, 24 Sep 2009 10:06:07 -0700
Message-ID: <E1Mqrlf-0002YF-9O@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from samwise.efn.org (efn.org [206.192.230.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A3F9103888
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Sep 2009 19:06:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

  I'm working on getting a WM8731 (in SLAVE) working using I2S on
omap3 McBSP2 (in MASTER).

Here is the hardware:

http://www.efn.org/~rick/pub/wm8731.jpg

  Here are the PADCONF's and the pins they hook to on the WM8731:

 /*Audio Interface for csb740 */\
 MUX_VAL(CP(McBSP2_FSX),  (OFF_OUT_PD | IDIS | PTU | EN | M0)) /* McBSP2_FSX -> I2S_FRM -> LRCLK -> DACLRC and ADCLRC*/\
 MUX_VAL(CP(McBSP2_CLKX), (OFF_OUT_PD | IDIS | PTU | EN | M0)) /* McBSP2_CLKX -> I2S_CLK -> I2S_BCLK -> BCLK */\
 MUX_VAL(CP(McBSP2_DR),   (OFF_IN_PD  | IEN  | PTD | DIS | M0)) /* McBSP2_DR <- I2S_RXD <- ACDDAT */\
 MUX_VAL(CP(McBSP2_DX),   (OFF_OUT_PD | IDIS | PTU | EN | M0)) /* McBSP2_DX -> I2S_TXD -> DACDAT */\
 MUX_VAL(CP(McBSP_CLKS),  (OFF_IN_PD  | IEN  | PTD | DIS | M0)) /* McBSP_CLKS <- I2S_MCLK <- CLKOUT */\

 My kernel is "2.6.29-rc3-omap1", here's what I see at bootup:

1 WM8731 Audio Codec 0.13<6>asoc: WM8731 <-> omap-mcbsp-dai-0 mapping ok
2 ALSA device list:
3  #0: omap3csb740 (WM8731)
...
4 beagle:~# aplay test48000.wav
5 Playing WAVE 'test48000.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
6 aplay: pcm_write:1269: write error: Input/output error

  I get no audio output, other than a "click" when the 8731 is
initialized upon boot.  When I look at the signals the McBSP2_DX line
just goes low for the duration of the "aplay", it does not toggle. The
other lines look fine.  The file is at
http://www.efn.org/~rick/pub/omap3csb740.c but roughly, here's what
I'm doing:

static struct snd_soc_dai_link omap3csb740_dai = {
...
 .cpu_dai = &omap_mcbsp_dai[0], /* use 1st one */

static int __init omap3csb740_soc_init(void)
...
 *(unsigned int *)omap_mcbsp_dai[0].private_data = 1; /* McBSP2 */
 *(unsigned int *)omap3csb740_dai.cpu_dai->private_data = 1; /* McBSP2 debug only? */

static int omap3csb740_hw_params(struct snd_pcm_substream *substream,
...
 ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
  SND_SOC_DAIFMT_NB_NF |  SND_SOC_DAIFMT_CBS_CFS);
 ret = snd_soc_dai_set_fmt(cpu_dai,  SND_SOC_DAIFMT_I2S |
  SND_SOC_DAIFMT_NB_NF |  SND_SOC_DAIFMT_CBS_CFS);
 ret = snd_soc_dai_set_sysclk(codec_dai, 0, 12288000,   SND_SOC_CLOCK_IN);
 ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_CLKS_EXT, 0,
   SND_SOC_CLOCK_IN);
 ret = snd_soc_dai_set_clkdiv(cpu_dai, OMAP_MCBSP_CLKGDV, 256);

  Any help is greatly appreciated.

  Rick Bronson
