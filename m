From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Do not announce false surround in
	Conexant auto
Date: Fri, 18 Feb 2011 09:33:55 +0100
Message-ID: <4D5E2EF3.8020202@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060309080607070205030803"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E5A4243B4
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 09:33:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060309080607070205030803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Without this patch, one line-out and one speaker and
Conexant's auto parser would announce (non-working) surround
capabilities.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------060309080607070205030803
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Do-not-announce-false-surround-in-Conexant-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Do-not-announce-false-surround-in-Conexant-.pa";
 filename*1="tch"

>From d7acab6cd1aa8be6a04d1c9a47d1802a39597a3e Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 16 Feb 2011 21:34:04 +0100
Subject: [PATCH] ALSA: HDA: Do not announce false surround in Conexant auto

Without this patch, one line-out and one speaker and
Conexant's auto parser would announce (non-working) surround
capabilities.

BugLink: http://bugs.launchpad.net/bugs/721126
Cc: stable@kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index fbe97d3..029741f 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3410,7 +3410,7 @@ static void cx_auto_parse_output(struct hda_codec *codec)
 		}
 	}
 	spec->multiout.dac_nids = spec->private_dac_nids;
-	spec->multiout.max_channels = nums * 2;
+	spec->multiout.max_channels = spec->multiout.num_dacs * 2;
 
 	if (cfg->hp_outs > 0)
 		spec->auto_mute = 1;
-- 
1.7.1


--------------060309080607070205030803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060309080607070205030803--
