From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] hda-emu: Include stdlib.h, needed for calloc
Date: Tue, 03 Aug 2010 10:54:11 +0200
Message-ID: <4C57D933.5070108@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060309010103090609080103"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id E19A02414D
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 10:54:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060309010103090609080103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------060309010103090609080103
Content-Type: text/x-patch;
 name="0001-Include-stdlib.h-needed-for-calloc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Include-stdlib.h-needed-for-calloc.patch"

>From 0062fa9c891f0f48f0a207f06df16e79a67215c3 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 3 Aug 2010 10:42:13 +0200
Subject: [PATCH] Include stdlib.h, needed for calloc

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-spec.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/hda-spec.c b/hda-spec.c
index 6c4f045..2ff8b21 100644
--- a/hda-spec.c
+++ b/hda-spec.c
@@ -23,6 +23,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
+#include <stdlib.h>
 #include "hda-types.h"
 #include "hda-log.h"
 
-- 
1.7.0.4


--------------060309010103090609080103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060309010103090609080103--
