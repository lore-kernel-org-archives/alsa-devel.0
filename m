From: Dan Carpenter <error27@gmail.com>
Subject: [patch] riptide: clean up while loop
Date: Wed, 3 Mar 2010 10:13:49 +0300
Message-ID: <20100303071349.GG5086@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A0EA1038AF
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 08:13:58 +0100 (CET)
Received: by bwz7 with SMTP id 7so985217bwz.4
	for <alsa-devel@alsa-project.org>; Tue, 02 Mar 2010 23:13:58 -0800 (PST)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If getpaths() returned an odd number this would be a buffer under-run and an 
endless loop.  It turns out that getpaths() can only return even numbers, but 
let's make it easy for people auditing code.  With the new code you don't 
need to look at getpaths().

This silences a smatch warning.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index e66ef2b..a5924af 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1974,9 +1974,9 @@ snd_riptide_proc_read(struct snd_info_entry *entry,
 	}
 	snd_iprintf(buffer, "Paths:\n");
 	i = getpaths(cif, p);
-	while (i--) {
-		snd_iprintf(buffer, "%x->%x ", p[i - 1], p[i]);
-		i--;
+	while (i >= 2) {
+		i -= 2;
+		snd_iprintf(buffer, "%x->%x ", p[i], p[i + 1]);
 	}
 	snd_iprintf(buffer, "\n");
 }
