From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: da7213 questions
Date: Wed, 13 Jul 2016 15:33:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1607131354390.10743@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pmeerw.net (ns.pmeerw.net [84.19.176.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A2BE2666EC
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2016 15:33:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: alsa-devel@alsa-project.org, support.opensource@diasemi.com
List-Id: alsa-devel@alsa-project.org

Hello,

I have a couple of questions/comments regarding the da7213 driver in 
mainline:

(1) the da7213 driver enables mclk in BIAS_SUSPEND, so essentially the 
clock is always running (since idle_bias_off is not set); at least on my 
platform, clk_set_rate() fails when the clock is already enabled

(2) da7213's srm_en variable is redundant and can be removed

(3) for 32 kHz PLL mode (DAI master), section 13.28 of the datasheet 
indicates that PLL_SRM_EN should be asserted; the da7213 drivers goesn't

(4) is only S16_LE actually supported?
#define DA7213_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
but in da7213_set_dai_fmt() we have
	/* By default only 32 BCLK per WCLK is supported */
	dai_clk_mode |= DA7213_DAI_BCLKS_PER_WCLK_32;

thanks, regards, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
