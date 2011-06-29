From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] aplay: increase channel limit to 256
Date: Wed, 29 Jun 2011 09:44:06 +0200
Message-ID: <a0a631e9393835ba8f25e49847259b71a84fcf88.1309333405.git.tim@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id C3C4E1038BE
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 09:44:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Tim Blechmann <tim@klingt.org>
List-Id: alsa-devel@alsa-project.org

aplay is limited to 32 channels, which makes it impossible to use it for
testing devices with more channels. here we increase the limit to 256,
which should be sufficient for a virtual device made of 4 64-channel
soundcards.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 aplay/aplay.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 50e01ef..07e6bc0 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -526,7 +526,7 @@ int main(int argc, char *argv[])
 			break;
 		case 'c':
 			rhwparams.channels = strtol(optarg, NULL, 0);
-			if (rhwparams.channels < 1 || rhwparams.channels > 32) {
+			if (rhwparams.channels < 1 || rhwparams.channels > 256) {
 				error(_("value %i for channels is invalid"), rhwparams.channels);
 				return 1;
 			}
@@ -1015,7 +1015,7 @@ static int test_au(int fd, void *buffer)
 	if (hwparams.rate < 2000 || hwparams.rate > 256000)
 		return -1;
 	hwparams.channels = BE_INT(ap->channels);
-	if (hwparams.channels < 1 || hwparams.channels > 128)
+	if (hwparams.channels < 1 || hwparams.channels > 256)
 		return -1;
 	if ((size_t)safe_read(fd, buffer + sizeof(AuHeader), BE_INT(ap->hdr_size) - sizeof(AuHeader)) != BE_INT(ap->hdr_size) - sizeof(AuHeader)) {
 		error(_("read error"));
-- 
1.7.4.1
