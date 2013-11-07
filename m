From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] ALSA: hda - Add a block_report flag to
	jacks
Date: Thu,  7 Nov 2013 13:38:24 +0100
Message-ID: <1383827905-2618-3-git-send-email-david.henningsson@canonical.com>
References: <1383827905-2618-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B0512616E1
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 13:38:29 +0100 (CET)
In-Reply-To: <1383827905-2618-1-git-send-email-david.henningsson@canonical.com>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

If the jack should not be reported to userspace (e g, because it is
in some transitional state), one can set this flag.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_jack.c | 2 +-
 sound/pci/hda/hda_jack.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 05b3e3e..afe5944 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -286,7 +286,7 @@ void snd_hda_jack_report_sync(struct hda_codec *codec)
 	jack = codec->jacktbl.list;
 	for (i = 0; i < codec->jacktbl.used; i++, jack++)
 		if (jack->nid) {
-			if (!jack->kctl)
+			if (!jack->kctl || jack->block_report)
 				continue;
 			state = get_jack_plug_state(jack->pin_sense);
 			snd_kctl_jack_report(codec->bus->card, jack->kctl, state);
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index 379420c..46e1ea8 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -28,6 +28,7 @@ struct hda_jack_tbl {
 	unsigned int jack_detect:1;	/* capable of jack-detection? */
 	unsigned int jack_dirty:1;	/* needs to update? */
 	unsigned int phantom_jack:1;    /* a fixed, always present port? */
+	unsigned int block_report:1;    /* in a transitional state - do not report to userspace */
 	hda_nid_t gating_jack;		/* valid when gating jack plugged */
 	hda_nid_t gated_jack;		/* gated is dependent on this jack */
 	struct snd_kcontrol *kctl;	/* assigned kctl for jack-detection */
-- 
1.8.4.2
