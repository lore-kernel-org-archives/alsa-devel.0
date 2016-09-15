From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] Revert "ASoC: core: mark SND_SOC_BYTES_EXT as
	deprecated"
Date: Thu, 15 Sep 2016 22:45:49 +0900
Message-ID: <1473947149-6663-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 596E9261A5E
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2016 15:45:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

SND_SOC_BYTES_TLV brings confusions to user land because it doesn't follow
to a protocol of ctl and tlv operation. At least, this macro and related
kernel APIs include two misunderstandings:
 - 'struct snd_ctl_elem_info.count' can also represent the length of TLV
   packet paylaod, snd_soc_bytes_info_ext() performs in this way.
 - 'struct snd_ctl_tlv.tlv' can include arbitrary data regardless of TLV
   packet structure, snd_soc_bytes_tlv_callback() performs in this way.

In a policy of kernel land development, it's quite worse to break protocols
for applications. Therefore, developers are discouraged to use these kernel
APIs.

In the first place, SND_SOC_BYTES_TLV was added to satisfy a request of
developers who need to add control elements which transfer data larger than
the size which 'struct snd_ctl_elem_value' can represent; e.g. over 512
bytes. However, as long as the size is less than the size; e.g. 512 bytes,
SND_SOC_BYTES_EXT is still available. Although there is actually the
limitation of maximum data size, it's better to use this API for stable
application interface till better alternative ways are implemented in
future.

For these reasons, this commit reverts the previous commit which lead
developers to the worse behaviour.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/soc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6144882..18f7d21 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -311,9 +311,6 @@
 		{.base = xbase, .num_regs = xregs,	      \
 		 .mask = xmask }) }
 
-/*
- * SND_SOC_BYTES_EXT is deprecated, please USE SND_SOC_BYTES_TLV instead
- */
 #define SND_SOC_BYTES_EXT(xname, xcount, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_bytes_info_ext, \
-- 
2.7.4
