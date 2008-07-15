From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [PATCH] ALSA: add TriTech 28023 AC97 codec ID and
	Wolfson 9701 name.
Date: Tue, 15 Jul 2008 03:22:15 +0200
Message-ID: <487BFBC7.7070701@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060805000503060509040009"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id BA56A243C7
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 03:23:01 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060805000503060509040009
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi

Have the TriTech 28023 on one of my Ensoniq ENS1371 cards and on a ESS 
Maestro-2 card. Have a Wolfson XWM9701 on a Trident 4DWAVE-DX one.

Rene.



--------------060805000503060509040009
Content-Type: text/plain;
 name="0001-ALSA-add-TriTech-28023-AC97-codec-ID-and-Wolfson-97.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-ALSA-add-TriTech-28023-AC97-codec-ID-and-Wolfson-97.pat";
 filename*1="ch"

>From 8c57754f2974e30b16e5c90181f478ee75190c64 Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Tue, 15 Jul 2008 03:00:21 +0200
Subject: [PATCH] ALSA: add TriTech 28023 AC97 codec ID and Wolfson 9701 name.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
---
 sound/pci/ac97/ac97_codec.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 07364c0..8c49a00 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -161,6 +161,7 @@ static const struct ac97_codec_id snd_ac97_codec_ids[] = {
 { 0x50534304, 0xffffffff, "UCB1400",		patch_ucb1400,	NULL },
 { 0x53494c20, 0xffffffe0, "Si3036,8",		mpatch_si3036,	mpatch_si3036, AC97_MODEM_PATCH },
 { 0x54524102, 0xffffffff, "TR28022",		NULL,		NULL },
+{ 0x54524103, 0xffffffff, "TR28023",		NULL,		NULL },
 { 0x54524106, 0xffffffff, "TR28026",		NULL,		NULL },
 { 0x54524108, 0xffffffff, "TR28028",		patch_tritech_tr28028,	NULL }, // added by xin jin [07/09/99]
 { 0x54524123, 0xffffffff, "TR28602",		NULL,		NULL }, // only guess --jk [TR28023 = eMicro EM28023 (new CT1297)]
@@ -169,7 +170,7 @@ static const struct ac97_codec_id snd_ac97_codec_ids[] = {
 { 0x56494170, 0xffffffff, "VIA1617A",		patch_vt1617a,	NULL }, // modified VT1616 with S/PDIF
 { 0x56494182, 0xffffffff, "VIA1618",		NULL,		NULL },
 { 0x57454301, 0xffffffff, "W83971D",		NULL,		NULL },
-{ 0x574d4c00, 0xffffffff, "WM9701A",		NULL,		NULL },
+{ 0x574d4c00, 0xffffffff, "WM9701,WM9701A",	NULL,		NULL },
 { 0x574d4C03, 0xffffffff, "WM9703,WM9707,WM9708,WM9717", patch_wolfson03, NULL},
 { 0x574d4C04, 0xffffffff, "WM9704M,WM9704Q",	patch_wolfson04, NULL},
 { 0x574d4C05, 0xffffffff, "WM9705,WM9710",	patch_wolfson05, NULL},
-- 
1.5.5


--------------060805000503060509040009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060805000503060509040009--
