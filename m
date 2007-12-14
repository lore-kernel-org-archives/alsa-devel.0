From: Andrew Paprocki <andrew@ishiboo.com>
Subject: [PATCH] hda-codec - Fix definition of AC_KNBCAP_DELTA
	to match spec
Date: Fri, 14 Dec 2007 12:48:00 -0400
Message-ID: <3681a8bf780ea1be9bf6.1197654480@firewall.26broadway.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 88B1F245F3
	for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2007 21:54:33 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id u77so1443258pyb.16
	for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2007 12:54:17 -0800 (PST)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

AC_KNBCAP_DELTA is incorrectly defined as (1<<8). According to the Intel
HDA spec, this is bit 7 after AC_KNBCAP_NUM_STEPS which is a 0x7f mask.

Signed-off-by: Andrew Paprocki <andrew@ishiboo.com>

diff -r 4a204306b295 -r 3681a8bf780e pci/hda/hda_codec.h
--- a/pci/hda/hda_codec.h	Fri Dec 14 14:42:41 2007 +0100
+++ b/pci/hda/hda_codec.h	Fri Dec 14 12:27:35 2007 -0500
@@ -234,7 +234,7 @@ enum {
 
 /* Volume knobs capabilities */
 #define AC_KNBCAP_NUM_STEPS		(0x7f<<0)
-#define AC_KNBCAP_DELTA			(1<<8)
+#define AC_KNBCAP_DELTA			(1<<7)
 
 /*
  * Control Parameters
