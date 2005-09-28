From: "John W. Linville" <linville@tuxdriver.com>
Subject: [patch 2.6.14-rc2 1/3] alsa: fix HD audio ALC260 mono (un)mute
Date: Wed, 28 Sep 2005 17:50:52 -0400
Message-ID: <09282005175052.10938@bilbo.tuxdriver.com>
References: <09282005175052.10882@bilbo.tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EF7B0163
	for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2005 23:53:45 +0200 (MEST)
In-Reply-To: <09282005175052.10882@bilbo.tuxdriver.com>
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

The ALC260 "Mono Playback Switch" is marked as an output in
patch_realtek.c. It actually does not work unless it is marked as an
input. Go figure... This was tested and confirmed on an HP xw4300.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 sound/pci/hda/patch_realtek.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2243,7 +2243,7 @@ static snd_kcontrol_new_t alc260_base_mi
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x09, 0x0, HDA_OUTPUT),
 	ALC_BIND_MUTE("Headphone Playback Switch", 0x09, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME_MONO("Mono Playback Volume", 0x0a, 1, 0x0, HDA_OUTPUT),
-	ALC_BIND_MUTE_MONO("Mono Playback Switch", 0x0a, 1, 2, HDA_OUTPUT),
+	ALC_BIND_MUTE_MONO("Mono Playback Switch", 0x0a, 1, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x04, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x04, 0x0, HDA_INPUT),
 	{
@@ -2270,7 +2270,7 @@ static snd_kcontrol_new_t alc260_hp_mixe
 	HDA_CODEC_VOLUME("Headphone Playback Volume", 0x09, 0x0, HDA_OUTPUT),
 	ALC_BIND_MUTE("Headphone Playback Switch", 0x09, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME_MONO("Mono Playback Volume", 0x0a, 1, 0x0, HDA_OUTPUT),
-	ALC_BIND_MUTE_MONO("Mono Playback Switch", 0x0a, 1, 2, HDA_OUTPUT),
+	ALC_BIND_MUTE_MONO("Mono Playback Switch", 0x0a, 1, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("Capture Volume", 0x05, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x05, 0x0, HDA_INPUT),
 	{


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
