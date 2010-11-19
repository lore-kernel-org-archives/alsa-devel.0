From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] ALSA: HDA: Rename "Front" to "Master
 Front" on ALC861VD and ALC887
Date: Fri, 19 Nov 2010 10:29:37 +0100
Message-ID: <4CE64381.4070003@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040808030805090205070405"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B044243E9
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2010 10:29:37 +0100 (CET)
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
--------------040808030805090205070405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Since "Front" controls headphones as well on these two codecs,
they should be labeled "Master Front" in order to be handled correct
by PulseAudio.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040808030805090205070405
Content-Type: text/x-patch;
 name="0002-ALSA-HDA-Rename-Front-to-Master-Front-on-ALC861VD-an.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-ALSA-HDA-Rename-Front-to-Master-Front-on-ALC861VD-an.pa";
 filename*1="tch"

>From daf075d2301e9d2105ab3a5a6517ad72dbba7c7f Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 16 Nov 2010 09:32:53 +0100
Subject: [PATCH 2/3] ALSA: HDA: Rename "Front" to "Master Front" on ALC861VD and ALC887

Since "Front" controls headphones as well on these two codecs,
they should be labeled "Master Front" in order to be handled correct
by PulseAudio.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ce4017e..4cc7bb2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -16966,7 +16966,7 @@ static void alc861vd_auto_init_analog_input(struct hda_codec *codec)
 static int alc861vd_auto_create_multi_out_ctls(struct alc_spec *spec,
 					     const struct auto_pin_cfg *cfg)
 {
-	static const char *chname[4] = {"Front", "Surround", "CLFE", "Side"};
+	static const char *chname[4] = {"Master Front", "Surround", "CLFE", "Side"};
 	hda_nid_t nid_v, nid_s;
 	int i, err;
 
-- 
1.7.1


--------------040808030805090205070405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040808030805090205070405--
