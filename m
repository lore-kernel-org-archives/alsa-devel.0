From: =?UTF-8?Q?=C5=81ukasz_Wojni=C5=82owicz?= <lukasz.wojnilowicz@gmail.com>
Subject: Mute lfe and side for 4930g when pluging in headphones
Date: Thu, 19 Nov 2009 23:39:17 +0100
Message-ID: <1258670357.7166.6.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-cCszk/wzO7SJsMsgk5O4"
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-cCszk/wzO7SJsMsgk5O4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Sorry that I'm not sending this patch by git but it takes for me too
long to clone alsa-kernel.git repository at 15 KB download rate. Thanks
for your understanding

--=-cCszk/wzO7SJsMsgk5O4
Content-Disposition: attachment; filename="4930g mute lfe and side.patch"
Content-Type: text/x-patch; name="4930g mute lfe and side.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

From: =?utf-8?q?=C5=81ukasz=20Wojni=C5=82owicz?= <lukasz.wojnilowicz@gmail.com>
Subject: Mute lfe and side for 4930g when pluging in headphones
Comment: Fixes first issue from comment 0021423 in bug from site https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4317

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index eee3143..4ed3b77 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1786,6 +1786,8 @@ static void alc888_acer_aspire_4930g_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
+	spec->autocfg.speaker_pins[1] = 0x16;
+	spec->autocfg.speaker_pins[2] = 0x17;
 }
 
 static void alc888_acer_aspire_6530g_setup(struct hda_codec *codec)

--=-cCszk/wzO7SJsMsgk5O4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-cCszk/wzO7SJsMsgk5O4--
