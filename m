From: Simon Brenner <simon.brenner@mobotix.com>
Subject: SGTL5000: fix max Mic Volume in SGTL5000_CHIP_MIC_CTRL
Date: Thu, 19 Jul 2012 16:00:54 +0200
Message-ID: <50081316.4010807@mobotix.com>
Reply-To: simon.brenner@mobotix.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smail.mobotix.com (smail.mobotix.com [213.183.84.167])
 by alsa0.perex.cz (Postfix) with ESMTP id DB00F2652BA
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2012 16:00:52 +0200 (CEST)
Received: from [192.168.24.20] ([192.168.24.20] verified)
 by mobotix.com (CommuniGate Pro SMTP 5.4.4)
 with ESMTP id 14633961 for alsa-devel@alsa-project.org;
 Thu, 19 Jul 2012 16:00:54 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I have noticed a wrong value for the "max" field of the macro
SOC_SINGLE_TLV() in the Linux kernel file
<kernel_root>/sound/soc/codecs/sgtl5000.c (approx. line 402,
sgtl5000_snd_controls[]):

SOC_SINGLE_TLV("Mic Volume", SGTL5000_CHIP_MIC_CTRL, 0, 4, 0,
                   mic_gain_tlv)

The value "4" should be a "3" (see datasheet "Low Power Stereo Codec
with Headphone Amp" by Freescale, page 40).

Regards,
-Simon.
