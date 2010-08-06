From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [PATCH 0/5] ASoC: Fix smdk64xx-wm8580 problems
Date: Fri,  6 Aug 2010 09:13:12 +0900
Message-ID: <1281053592-3311-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 4404E24389
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 02:24:37 +0200 (CEST)
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
Cc: Seungwhan Youn <sw.youn@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <claude.youn@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

This patch serise fix some problems in smdk64xx board when it use
I2S with wm8580.

 o ADC source clock setting is set to use MCLK, It makes that
   wm8580 cannot make BCLK and LRCLK for playback and capture.
 o When application set some sampling freq. - 8kHz, 11.025kHz,
   audio doesn't work correctly with broken sound. Because
   wm8580 always set BCLK_RATE and LRCLK_RATE as a default value
   , BCLK_RATE - 256fs and LRCLK_RATE - 64 BCLKs per LRCLK. So,
   BCLK_RATE and LRCLK_RATE setting on wm8580 is not match to
   make these sampling freq. on wm8580 master mode.

So, to solve these problems, this patch apply followings:

 o Support ADC source clock setting on wm8580.
 o Enable to select BCLK_RATE and LRCLK_RATE value on wm8580.
 o Fix smdk-wm8580 machine code to support new features of wm8580.


The following patch series contains:

[PATCH 1/5] ASoC: wm8580: Add to support ADC clock source setting
[PATCH 2/5] ASoC: S3C64XX: Add ADC source clock setting
[PATCH 3/5] ASoC: wm8580: Fix Master Mode BCLK rates names
[PATCH 4/5] ASoC: wm8580: Add to support Master Mode Rates
[PATCH 5/5] ASoC: S3C64XX: Fix to support BCLK, LRCLK rates setting

Thanks,

Claude
