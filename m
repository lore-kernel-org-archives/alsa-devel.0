From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [RFC PATCH 1/7] ALSA: hda - add mst_no_extra_pcms flag
	to hda_codec
Date: Thu, 29 Aug 2019 16:53:42 +0300
Message-ID: <20190829135348.23569-2-kai.vehmanen@linux.intel.com>
References: <20190829135348.23569-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E0DEF89881
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 15:54:10 +0200 (CEST)
In-Reply-To: <20190829135348.23569-1-kai.vehmanen@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Add a flag to hda_codec struct to control whether legacy PCM
numbering should be followed in DP-MST mode. When set, no backup
PCMs will be created and PCM count is limited to number of
converters.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 include/sound/hda_codec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 9a0393cf024c..ac18f428eda6 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -254,6 +254,7 @@ struct hda_codec {
 	unsigned int force_pin_prefix:1; /* Add location prefix */
 	unsigned int link_down_at_suspend:1; /* link down at runtime suspend */
 	unsigned int relaxed_resume:1;	/* don't resume forcibly for jack */
+	unsigned int mst_no_extra_pcms:1; /* no backup PCMs for DP-MST */
 
 #ifdef CONFIG_PM
 	unsigned long power_on_acct;
-- 
2.17.1
