From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] ALSA: make sparc/dbri.c:snd_dbri_proc()
	static
Date: Thu, 5 Jun 2008 21:29:18 +0300
Message-ID: <20080605182906.GN1469@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 41C5F24344
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 20:29:55 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch makes the needlessly global snd_dbri_proc() static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
5e6dd8dea3d11e2be46a77f8e731780f0a7b7591 diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 3d00e07..ee2e1b4 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2490,7 +2490,7 @@ static void dbri_debug_read(struct snd_info_entry *entry,
 }
 #endif
 
-void __devinit snd_dbri_proc(struct snd_card *card)
+static void __devinit snd_dbri_proc(struct snd_card *card)
 {
 	struct snd_dbri *dbri = card->private_data;
 	struct snd_info_entry *entry;
