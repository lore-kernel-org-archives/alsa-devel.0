From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] alsa-utils: speaker-test: fix infinite loop
Date: Fri, 15 Oct 2010 12:35:31 +0200
Message-ID: <4CB82E73.2080403@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070605020506060102030305"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id CE4501037FC
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 12:35:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070605020506060102030305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm using speaker-test in an Ubuntu-specific bug triaging 
script/application ("ubuntu-bug audio"), and without showing the 
terminal that speaker-test outputs. So when the stream cannot be opened 
for one reason or another, my application hangs indefinitely and the 
user cannot report the bug.

Looking at the code, seems like Takashi removed all error loops except 
this one four years ago, so there shouldn't be any controversy in 
removing this one as well.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------070605020506060102030305
Content-Type: text/x-patch;
 name="0001-speaker-test-Don-t-retry-after-fatal-errors.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-speaker-test-Don-t-retry-after-fatal-errors.patch"

>From f51771c4064ec5f18ec46aeec2d5fe294a4a372c Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 15 Oct 2010 12:30:44 +0200
Subject: [PATCH] speaker-test: Don't retry after fatal errors

Fixup commit 9b1a2566: Remove error loop

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 speaker-test/speaker-test.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/speaker-test/speaker-test.c b/speaker-test/speaker-test.c
index 458a8d7..3029110 100644
--- a/speaker-test/speaker-test.c
+++ b/speaker-test/speaker-test.c
@@ -993,9 +993,9 @@ int main(int argc, char *argv[]) {
 
   }
 
-  while ((err = snd_pcm_open(&handle, device, SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
+  if ((err = snd_pcm_open(&handle, device, SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
     printf(_("Playback open error: %d,%s\n"), err,snd_strerror(err));
-    sleep(1);
+    exit(EXIT_FAILURE);
   }
 
   if ((err = set_hwparams(handle, hwparams, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
-- 
1.7.1


--------------070605020506060102030305
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------070605020506060102030305--
