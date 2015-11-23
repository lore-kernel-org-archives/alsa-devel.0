From: libin.yang@linux.intel.com
Subject: [RFC V2 PATCH 4/5] ALSA: hda - add in_use flag in
	hda_pcm
Date: Mon, 23 Nov 2015 22:09:33 +0800
Message-ID: <1448287774-146673-6-git-send-email-libin.yang@linux.intel.com>
References: <1448287774-146673-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C50A2265463
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 15:12:27 +0100 (CET)
In-Reply-To: <1448287774-146673-1-git-send-email-libin.yang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, Libin Yang <libin.yang@linux.intel.com>, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

Add in_use flag in struct hda_pcm for HD Audio dynamic PCM assignment.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/hda_codec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 373fcad..ee97401 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -167,6 +167,7 @@ enum {
 /* for PCM creation */
 struct hda_pcm {
 	char *name;
+	bool in_use;
 	struct hda_pcm_stream stream[2];
 	unsigned int pcm_type;	/* HDA_PCM_TYPE_XXX */
 	int device;		/* device number to assign */
-- 
1.9.1
