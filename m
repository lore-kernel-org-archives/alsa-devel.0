From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Enable surround speakers (when
	line out is also present)
Date: Thu, 10 Oct 2013 09:01:25 +0200
Message-ID: <1381388485-3649-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id EF5332617AB
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 09:01:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>, 1236965@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

In the case where we have both line out and more than stereo speakers,
the speaker DACs will end up in extra_out_nid.
In fact, AFAIU, speakers are the only ones that can end up in extra_out_nid,
and if we have several of those, they should be surround outputs
rather than copy front.

BugLink: https://bugs.launchpad.net/bugs/1236965
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_codec.c |   19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

Notes:
 * Thanks to Raymond Yau for the pointer
 * Not tested (yet), except in hda-emu
 * Not sure if this should be sent to stable or not, given that it is a change of behaviour
 * Alsainfo available here:
   https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1236965/+attachment/3867946/+files/alsaInfoWhenAudioPlaybackFailing.txt

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 5b6c4e3..68801ba 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -5395,11 +5395,6 @@ int snd_hda_multi_out_analog_prepare(struct hda_codec *codec,
 			snd_hda_codec_setup_stream(codec,
 						   mout->hp_out_nid[i],
 						   stream_tag, 0, format);
-	for (i = 0; i < ARRAY_SIZE(mout->extra_out_nid); i++)
-		if (!mout->no_share_stream && mout->extra_out_nid[i])
-			snd_hda_codec_setup_stream(codec,
-						   mout->extra_out_nid[i],
-						   stream_tag, 0, format);
 
 	/* surrounds */
 	for (i = 1; i < mout->num_dacs; i++) {
@@ -5410,6 +5405,20 @@ int snd_hda_multi_out_analog_prepare(struct hda_codec *codec,
 			snd_hda_codec_setup_stream(codec, nids[i], stream_tag,
 						   0, format);
 	}
+
+	/* extra surrounds */
+	for (i = 0; i < ARRAY_SIZE(mout->extra_out_nid); i++) {
+		int ch = 0;
+		if (!mout->extra_out_nid[i])
+			break;
+		if (chs >= (i + 1) * 2)
+			ch = i * 2;
+		else if (!mout->no_share_stream)
+			break;
+		snd_hda_codec_setup_stream(codec, mout->extra_out_nid[i],
+					   stream_tag, ch, format);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_HDA(snd_hda_multi_out_analog_prepare);
-- 
1.7.9.5
