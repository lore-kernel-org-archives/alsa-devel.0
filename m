From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: [PATCH] Use "Skeaper" instead of "chname" by deafult.
Date: Sun,  6 Dec 2009 19:57:24 +0100
Message-ID: <1260125844-3650-1-git-send-email-bug-track@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 7792224379
	for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2009 19:57:34 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Alexey Fisher <bug-track@fisher-privat.net>
List-Id: alsa-devel@alsa-project.org

If you use Speacker by defaut, Surround volume controls will have bad names.
For example:
before patch  ->  after patch
-----------------------------
Speaker       ->  Front
Speaker 1     ->  Surround
Speaker 2     ->  Side

Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>

	modified:   sound/pci/hda/patch_sigmatel.c
---
 sound/pci/hda/patch_sigmatel.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index e604bae..121a93e 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -3152,13 +3152,13 @@ static int create_multi_out_ctls(struct hda_codec *codec, int num_outs,
 				idx = i;
 				break;
 			case AUTO_PIN_SPEAKER_OUT:
-				name = "Speaker";
-				idx = i;
-				break;
-			default:
 				name = chname[i];
 				idx = 0;
 				break;
+			default:
+				name = "Speaker";
+				idx = i;
+				break;
 			}
 			err = create_controls_idx(codec, name, idx, nid, 3);
 			if (err < 0)
-- 
1.6.3.3
