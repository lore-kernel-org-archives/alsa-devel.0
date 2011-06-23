From: Patrick Lai <plai@codeaurora.org>
Subject: Mixer control for signed gain value
Date: Wed, 22 Jun 2011 23:32:19 -0700
Message-ID: <4E02DDF3.2070509@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id C9A452452B
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 08:32:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hi,

The CODEC I am working with takes byte-long gain value in two's 
complement form.
In soc-core.c, the closest functions I see are
  snd_soc_info_volsw_s8
snd_soc_get_volsw_s8
snd_soc_set_volsw_s8

These functions are coded to work with two integer values. For my
purpose, I suppose that I can always set 2nd integer input as zero.
However, would I still be able to set volume like
amixer sset "Codec Gain" 100 as percentage. If yes, how will amixer
know to put upper 8 bits of 16 bit gain in 2nd integer value element?

Thanks
Patrick


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
