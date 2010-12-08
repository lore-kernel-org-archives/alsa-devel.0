From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] Fix possible sprintf overrun in snd_pcm_hw_open
Date: Wed, 08 Dec 2010 11:16:19 +0100
Message-ID: <4CFF5AF3.5030103@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080408060601020802060106"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id D9A53243FE
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 11:16:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080408060601020802060106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I spotted this while reading code a few weeks ago, and I ran it through 
the Ubuntu security team just to be sure.
They decided it was not needing any security embargo or similar, so here 
comes the patch.


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------080408060601020802060106
Content-Type: text/x-patch;
 name="0001-Fix-possible-sprintf-overrun-in-snd_pcm_hw_open.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Fix-possible-sprintf-overrun-in-snd_pcm_hw_open.patch"

>From 3333d9bb8d8f9cc95f9dbf68d0a703a4e832a948 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 8 Dec 2010 11:06:59 +0100
Subject: [PATCH] Fix possible sprintf overrun in snd_pcm_hw_open

BugLink: http://launchpad.net/bugs/668487

Possible buffer overrun if the number of "card" and "device"
are absurdly high, especially on 64-bit platforms.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/pcm/pcm_hw.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/pcm/pcm_hw.c b/src/pcm/pcm_hw.c
index 9d243d5..ce74ad4 100644
--- a/src/pcm/pcm_hw.c
+++ b/src/pcm/pcm_hw.c
@@ -1270,7 +1270,7 @@ int snd_pcm_hw_open(snd_pcm_t **pcmp, const char *name,
 		SNDERR("invalid stream %d", stream);
 		return -EINVAL;
 	}
-	sprintf(filename, filefmt, card, device);
+	snprintf(filename, sizeof(filename), filefmt, card, device);
 
       __again:
       	if (attempt++ > 3) {
-- 
1.7.1


--------------080408060601020802060106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080408060601020802060106--
