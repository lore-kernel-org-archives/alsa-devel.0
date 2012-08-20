From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - don't create dysfunctional
	mixer controls for ca0132
Date: Mon, 20 Aug 2012 11:17:00 +0200
Message-ID: <1345454220-4233-3-git-send-email-david.henningsson@canonical.com>
References: <1345454220-4233-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A68C265DB4
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 10:47:21 +0200 (CEST)
In-Reply-To: <1345454220-4233-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, ian_minett@creativelabs.com
Cc: stable@kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

It's possible that these amps are settable somehow, e g through
secret codec verbs, but for now, don't create the controls (as
they won't be working anyway, and cause errors in amixer).

Cc: stable@kernel.org
BugLink: https://bugs.launchpad.net/bugs/1038651
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_ca0132.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 2685590..bf061a3 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -275,6 +275,10 @@ static int _add_switch(struct hda_codec *codec, hda_nid_t nid, const char *pfx,
 	int type = dir ? HDA_INPUT : HDA_OUTPUT;
 	struct snd_kcontrol_new knew =
 		HDA_CODEC_MUTE_MONO(namestr, nid, chan, 0, type);
+	if ((query_amp_caps(codec, nid, type) & AC_AMPCAP_MUTE) == 0) {
+		snd_printdd("Skipping '%s %s Switch' (no mute on node 0x%x)\n", pfx, dirstr[dir], nid);
+		return 0;
+	}
 	sprintf(namestr, "%s %s Switch", pfx, dirstr[dir]);
 	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
 }
@@ -286,6 +290,10 @@ static int _add_volume(struct hda_codec *codec, hda_nid_t nid, const char *pfx,
 	int type = dir ? HDA_INPUT : HDA_OUTPUT;
 	struct snd_kcontrol_new knew =
 		HDA_CODEC_VOLUME_MONO(namestr, nid, chan, 0, type);
+	if ((query_amp_caps(codec, nid, type) & AC_AMPCAP_NUM_STEPS) == 0) {
+		snd_printdd("Skipping '%s %s Volume' (no amp on node 0x%x)\n", pfx, dirstr[dir], nid);
+		return 0;
+	}
 	sprintf(namestr, "%s %s Volume", pfx, dirstr[dir]);
 	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
 }
-- 
1.7.9.5
