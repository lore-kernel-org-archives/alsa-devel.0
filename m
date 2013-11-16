From: Andrey Mazo <mazo@telum.ru>
Subject: [PATCH 1/3] pcm_file: fix SEGFAULT if file option is
	missing while infile is not.
Date: Sun, 17 Nov 2013 01:11:54 +0400
Message-ID: <1384636316-26706-2-git-send-email-mazo@telum.ru>
References: <1384636316-26706-1-git-send-email-mazo@telum.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.telum.ru (mail.telum.ru [62.141.76.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AAB02610C4
 for <alsa-devel@alsa-project.org>; Sat, 16 Nov 2013 22:13:02 +0100 (CET)
In-Reply-To: <1384636316-26706-1-git-send-email-mazo@telum.ru>
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

Commit 5c5f1358123af69155267463a0b6254ad9cbecc4 requires both file and
infile options to be missing to report a failure.
In fact, only file option is mandatory and should be checked there.
Otherwise, NULL file triggers segfault in
snd_pcm_file_replace_fname() called from
snd_pcm_file_open_output_file().
infile option is optional, so don't report fatal error if it's missing.

Signed-off-by: Andrey Mazo <mazo@telum.ru>
---
 src/pcm/pcm_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index 5950401..3d14090 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -948,7 +948,7 @@ int _snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
 	err = snd_pcm_slave_conf(root, slave, &sconf, 0);
 	if (err < 0)
 		return err;
-	if ((!fname || strlen(fname) == 0) && fd < 0 && !ifname) {
+	if ((!fname || strlen(fname) == 0) && fd < 0) {
 		snd_config_delete(sconf);
 		SNDERR("file is not defined");
 		return -EINVAL;
-- 
1.8.4
