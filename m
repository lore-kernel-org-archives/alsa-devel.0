From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/4] ALSA: control: add kerneldoc for
	snd_kcontrol_tlv_rw_t
Date: Tue, 30 Aug 2016 08:44:44 +0900
Message-ID: <1472514285-3769-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id F1BCA2657F6
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 01:44:56 +0200 (CEST)
In-Reply-To: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@linaro.org, omair.m.abdullah@intel.com
List-Id: alsa-devel@alsa-project.org

Currently, there's no documentation about implementation requirement of
snd_kcontrol_tlv_rw_t. This function prototype includes historical
complexities and probably puzzles driver developers.

This commit adds a kerneldoc for this feature.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/sound/control.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/sound/control.h b/include/sound/control.h
index 848940c..6c1c4234 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -30,9 +30,27 @@ struct snd_kcontrol;
 typedef int (snd_kcontrol_info_t) (struct snd_kcontrol * kcontrol, struct snd_ctl_elem_info * uinfo);
 typedef int (snd_kcontrol_get_t) (struct snd_kcontrol * kcontrol, struct snd_ctl_elem_value * ucontrol);
 typedef int (snd_kcontrol_put_t) (struct snd_kcontrol * kcontrol, struct snd_ctl_elem_value * ucontrol);
+
+/**
+ * snd_kcontrol_tlv_rw_t - a type of callback function to operate information
+ *			   for threshold level or arbitrary I/O, via TLV
+ *			   feature of ALSA control interface.
+ * @kcontrol: A pointer to an instance for control element set.
+ * @op_flag: One of SNDRV_CTL_TLV_OP_READ/WRITE/CMD.
+ * @size: The size of buffer in user space in byte unit. After operated, the
+ *	  size should be changed to size of actually operated data in byte unit,
+ * @tlv: A pointer to the buffer in user space.
+ *
+ * Originally, this function is designed to allow each driver to generate and
+ * transfer data about threshold level. Later, this function is used to operate
+ * arbitrary I/O depending on each driver.
+ *
+ * Return: Zero if successful. Negative value in error. Positive value generates
+ *	   an event with SNDRV_CTL_EVENT_MASK_TLV. This return value is received
+ *	   by applications as a result of ioctl(2).
+ */
 typedef int (snd_kcontrol_tlv_rw_t)(struct snd_kcontrol *kcontrol,
-				    int op_flag, /* SNDRV_CTL_TLV_OP_XXX */
-				    unsigned int *size,
+				    int op_flag, unsigned int *size,
 				    unsigned int __user *tlv);
 
 enum {
-- 
2.7.4
