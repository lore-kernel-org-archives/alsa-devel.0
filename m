From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Realtek: Avoid unnecessary volume
 control index on Surround/Side
Date: Wed, 23 Mar 2011 08:56:34 +0100
Message-ID: <4D89A7B2.6050204@canonical.com>
References: <20110321113702.GA15206@atlantis.wh2.tu-dresden.de.de>	<4D87C6AF.2090906@canonical.com>
	<20110321231321.GA13972@atlantis.wh2.tu-dresden.de.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010401080105070700060709"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id B256124440
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 08:56:37 +0100 (CET)
In-Reply-To: <20110321231321.GA13972@atlantis.wh2.tu-dresden.de.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, losinski@wh2.tu-dresden.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010401080105070700060709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 2011-03-22 00:13, Jan Losinski wrote:
> * David Henningsson<david.henningsson@canonical.com>  [2011-03-21 22:44]:
>> Hmm, I made one or two patches in relation to this but they aimed at=20
>> moving index 1 to index 0, not the other way around. Could you please=20
>> give alsa-info (see wiki.ubuntu.com/Audio/AlsaInfo ) information,=20
>> preferably with 2.6.38 (and without your workaround) installed?
>
> Of course, it's located at [1] (2.6.38 without my "fix". Let me know if
> you need more information or if you need someone to test).
>
> Jan Losinski
>
> [1] http://www.alsa-project.org/db/?f=3D80bc05cada24ed993c4f964d4188add6d0e=
> 1dddb

Thanks, I've attached a patch that fixes this issue - Takashi, will you 
apply it?

> PS1: The tool does not work with LANG=3Dde_DE.UTF-8

Could not reproduce here, tried "LANG=de_DE.UTF-8 ./alsa-info.sh" and it 
succeeded normally.

> PS2: I've subscribed the list ;)

Great! Nevertheless I like being CC:ed myself when something concerns me 
in person, so I tend to do the same to others.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------010401080105070700060709
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Realtek-Avoid-unnecessary-volume-control-in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Realtek-Avoid-unnecessary-volume-control-in.pa";
 filename*1="tch"

>From bda10a777732d2f31d1a5a51954fe73b37177f2d Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 23 Mar 2011 08:35:07 +0100
Subject: [PATCH] ALSA: HDA: Realtek: Avoid unnecessary volume control index on Surround/Side

Similar to commit 7e59e097c09b82760bb0fe08b0fa2b704d76c3f4, this patch
avoids unnecessary volume control indices for more
Realtek auto-parsers, e g the ALC66x family, on the "Surround" and "Side"
controls.
These indices cause these volume controls to be ignored by PulseAudio and
vmaster and should be removed whenever possible.

Cc: stable@kernel.org
Reported-by: Jan Losinski <losinski@wh2.tu-dresden.de>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f1a03f2..dc67c5d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -16006,9 +16006,12 @@ static int alc861_auto_create_multi_out_ctls(struct hda_codec *codec,
 				return err;
 		} else {
 			const char *name = pfx;
-			if (!name)
+			int index = i;
+			if (!name) {
 				name = chname[i];
-			err = __alc861_create_out_sw(codec, name, nid, i, 3);
+				index = 0;
+			}
+			err = __alc861_create_out_sw(codec, name, nid, index, 3);
 			if (err < 0)
 				return err;
 		}
@@ -17159,16 +17162,19 @@ static int alc861vd_auto_create_multi_out_ctls(struct alc_spec *spec,
 				return err;
 		} else {
 			const char *name = pfx;
-			if (!name)
+			int index = i;
+			if (!name) {
 				name = chname[i];
+				index = 0;
+			}
 			err = __add_pb_vol_ctrl(spec, ALC_CTL_WIDGET_VOL,
-						name, i,
+						name, index,
 					  HDA_COMPOSE_AMP_VAL(nid_v, 3, 0,
 							      HDA_OUTPUT));
 			if (err < 0)
 				return err;
 			err = __add_pb_sw_ctrl(spec, ALC_CTL_BIND_MUTE,
-					       name, i,
+					       name, index,
 					  HDA_COMPOSE_AMP_VAL(nid_s, 3, 2,
 							      HDA_INPUT));
 			if (err < 0)
@@ -19217,12 +19223,15 @@ static int alc662_auto_create_multi_out_ctls(struct hda_codec *codec,
 				return err;
 		} else {
 			const char *name = pfx;
-			if (!name)
+			int index = i;
+			if (!name) {
 				name = chname[i];
-			err = __alc662_add_vol_ctl(spec, name, nid, i, 3);
+				index = 0;
+			}
+			err = __alc662_add_vol_ctl(spec, name, nid, index, 3);
 			if (err < 0)
 				return err;
-			err = __alc662_add_sw_ctl(spec, name, mix, i, 3);
+			err = __alc662_add_sw_ctl(spec, name, mix, index, 3);
 			if (err < 0)
 				return err;
 		}
-- 
1.7.1


--------------010401080105070700060709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010401080105070700060709--
