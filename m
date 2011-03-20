From: Andres Mejia <mcitadel@gmail.com>
Subject: [PATCH - Set EAPD for Realtek ALC665 (Vendor Id:
	0x10eSet EAPD for Realtek ALC665 (Vendor Id: 0x10ec0665).
Date: Sun, 20 Mar 2011 14:07:40 -0400
Message-ID: <1300644460-5968-1-git-send-email-mcitadel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
Cc: alsa-devel@alsa-project.org, Andres Mejia <mcitadel@gmail.com>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Andres Mejia <mcitadel@gmail.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 50855cf..be910fa6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1264,6 +1264,7 @@ static void alc_auto_init_amp(struct hda_codec *codec, int type)
 		case 0x10ec0660:
 		case 0x10ec0662:
 		case 0x10ec0663:
+		case 0x10ec0665:
 		case 0x10ec0862:
 		case 0x10ec0889:
 			set_eapd(codec, 0x14, 1);
@@ -4236,6 +4237,7 @@ static void alc_power_eapd(struct hda_codec *codec)
 	case 0x10ec0660:
 	case 0x10ec0662:
 	case 0x10ec0663:
+	case 0x10ec0665:
 	case 0x10ec0862:
 	case 0x10ec0889:
 		set_eapd(codec, 0x14, 0);
-- 
1.7.4.1
