From: mengdong.lin@intel.com
Subject: [PATCH v3] ALSA: hda - set GET bit when adding a
	vendor verb to the codec regmap
Date: Tue, 14 Apr 2015 11:25:36 +0800
Message-ID: <1428981936-24976-1-git-send-email-mengdong.lin@intel.com>
References: <2f716e6b90b7416eb34d35ed1954c7761bfd2050.1428918546.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 466432617BB
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 05:15:12 +0200 (CEST)
In-Reply-To: <2f716e6b90b7416eb34d35ed1954c7761bfd2050.1428918546.git.mengdong.lin@intel.com>
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
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Some HD-A codecs may add their own vendor 'set' verb to the regmap, thru func
snd_hdac_add_vendor_verb(). This patch sets the GET bit (bit 11)  when adding
the verb so that its peer vendor 'get' verb is actually added. This can avoid
I/O error when writing the 'set' verb thru remap, since HD-A regmap internally
looks up a writable vendor verb with GET bit set at first.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index 1eb4320..9e933c3 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -368,7 +368,7 @@ int snd_hdac_regmap_add_vendor_verb(struct hdac_device *codec,
 
 	if (!p)
 		return -ENOMEM;
-	*p = verb;
+	*p = verb | 0x800; /* set GET bit */
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_regmap_add_vendor_verb);
-- 
1.9.1
