From: "John W. Linville" <linville@tuxdriver.com>
Subject: [patch 2.6.14-rc2 2/3] alsa: fix alc880_test_mixer typo
Date: Wed, 28 Sep 2005 17:50:53 -0400
Message-ID: <09282005175053.11001@bilbo.tuxdriver.com>
References: <09282005175052.10938@bilbo.tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [24.172.12.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 37341163
	for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2005 23:54:01 +0200 (MEST)
In-Reply-To: <09282005175052.10938@bilbo.tuxdriver.com>
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

Fix a typo (cut & paste) in the alc880_test_mixer structure.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 sound/pci/hda/patch_realtek.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1385,8 +1385,8 @@ static snd_kcontrol_new_t alc880_test_mi
 	HDA_CODEC_VOLUME("Side Playback Volume", 0x0f, 0x0, HDA_OUTPUT),
 	ALC_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),
 	ALC_BIND_MUTE("Surround Playback Switch", 0x0d, 2, HDA_INPUT),
-	ALC_BIND_MUTE("CLFE Playback Volume", 0x0e, 2, HDA_INPUT),
-	ALC_BIND_MUTE("Side Playback Volume", 0x0f, 2, HDA_INPUT),
+	ALC_BIND_MUTE("CLFE Playback Switch", 0x0e, 2, HDA_INPUT),
+	ALC_BIND_MUTE("Side Playback Switch", 0x0f, 2, HDA_INPUT),
 	PIN_CTL_TEST("Front Pin Mode", 0x14),
 	PIN_CTL_TEST("Surround Pin Mode", 0x15),
 	PIN_CTL_TEST("CLFE Pin Mode", 0x16),


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
