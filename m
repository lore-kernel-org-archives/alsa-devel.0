From: "John W. Linville" <linville@tuxdriver.com>
Subject: [patch 2.6.14-rc2 3/3] alsa: fix HD audio ALC882 lfe (un)mute
Date: Wed, 28 Sep 2005 17:50:53 -0400
Message-ID: <09282005175053.11066__39029.4803226881$1127944684$gmane$org@bilbo.tuxdriver.com>
References: <09282005175053.11001@bilbo.tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 61EF216F
	for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2005 23:54:02 +0200 (MEST)
In-Reply-To: <09282005175053.11001@bilbo.tuxdriver.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc: perex@suse.cz, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Mark the ALC880 "LFE Playback Switch" as an input, like the other
playback switch settings.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
This is speculative, based on the datasheet and my experience with the
ALC260. I do not have the actual hardware to test this myself. Testing
by others is requested, but I am pretty sure this is correct.

 sound/pci/hda/patch_realtek.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2501,7 +2501,7 @@ static snd_kcontrol_new_t alc882_base_mi
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x0e, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x0e, 2, 0x0, HDA_OUTPUT),
 	ALC_BIND_MUTE_MONO("Center Playback Switch", 0x0e, 1, 2, HDA_INPUT),
-	ALC_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_OUTPUT),
+	ALC_BIND_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
 	ALC_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
