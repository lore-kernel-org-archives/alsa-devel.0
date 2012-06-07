From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH] ALSA: hda - check proper return value
Date: Thu,  7 Jun 2012 16:52:07 +0800
Message-ID: <1339059127-4133-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 85E5B2455F
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 10:56:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, fengguang.wu@intel.com
Cc: wangxingchao2011@gmail.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

snd_hda_param_read() return value -1 means error, others are responses

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/hda_proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 79d0188..99316a7 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -451,7 +451,7 @@ static void print_power_state(struct snd_info_buffer *buffer,
 	int sup = snd_hda_param_read(codec, nid, AC_PAR_POWER_STATE);
 	int pwr = snd_hda_codec_read(codec, nid, 0,
 				     AC_VERB_GET_POWER_STATE, 0);
-	if (sup)
+	if (sup != -1)
 		snd_iprintf(buffer, "  Power states: %s\n",
 			    bits_names(sup, names, ARRAY_SIZE(names)));
 
-- 
1.7.9.5
