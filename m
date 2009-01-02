From: Ulrich Dangel <uli@spamt.net>
Subject: [PATCH -  2/2] ALSA: hda - cxt5051 report jack state
Date: Fri,  2 Jan 2009 19:30:14 +0100
Message-ID: <1230921014-7729-2-git-send-email-uli@spamt.net>
References: <1230921014-7729-1-git-send-email-uli@spamt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1230921014-7729-1-git-send-email-uli@spamt.net>
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
Cc: alsa-devel@alsa-project.org, Ulrich Dangel <uli@spamt.net>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ulrich Dangel <uli@spamt.net>

diff --git a/pci/hda/patch_conexant.c b/pci/hda/patch_conexant.c
index 3cb640c..66c5021 100644
--- a/pci/hda/patch_conexant.c
+++ b/pci/hda/patch_conexant.c
@@ -1714,6 +1714,7 @@ static void cxt5051_hp_automute(struct hda_codec *codec)
 static void cxt5051_hp_unsol_event(struct hda_codec *codec,
 				   unsigned int res)
 {
+	int nid = (res & AC_UNSOL_RES_SUBTAG) >> 20;
 	switch (res >> 26) {
 	case CONEXANT_HP_EVENT:
 		cxt5051_hp_automute(codec);
@@ -1725,6 +1726,7 @@ static void cxt5051_hp_unsol_event(struct hda_codec *codec,
 		cxt5051_portc_automic(codec);
 		break;
 	}
+	conexant_report_jack(codec, nid);
 }
 
 static struct snd_kcontrol_new cxt5051_mixers[] = {
@@ -1799,6 +1801,7 @@ static struct hda_verb cxt5051_init_verbs[] = {
 static int cxt5051_init(struct hda_codec *codec)
 {
 	conexant_init(codec);
+	conexant_init_jacks(codec);
 	if (codec->patch_ops.unsol_event) {
 		cxt5051_hp_automute(codec);
 		cxt5051_portb_automic(codec);
-- 
1.6.0.6
