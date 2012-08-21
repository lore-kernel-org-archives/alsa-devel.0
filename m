From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/5] hda-emu: Store pointers to pcm streams
	instead of their content
Date: Tue, 21 Aug 2012 10:53:59 +0200
Message-ID: <1345539243-8147-2-git-send-email-david.henningsson@canonical.com>
References: <1345539243-8147-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B7FEA265EE0
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 10:54:10 +0200 (CEST)
In-Reply-To: <1345539243-8147-1-git-send-email-david.henningsson@canonical.com>
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

The HDMI playback engine relies on the same pointer value being sent
in hdmi_pcm_open, as being given in the attach_pcm callback.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-emu.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hda-emu.c b/hda-emu.c
index 77d5a7f..b4bd8a9 100644
--- a/hda-emu.c
+++ b/hda-emu.c
@@ -504,7 +504,7 @@ void hda_log_set_user_pin_configs(unsigned int nid, unsigned int cfg)
 #define MAX_PCM_STREAMS		16
 
 static int num_pcm_streams;
-static struct hda_pcm pcm_streams[MAX_PCM_STREAMS];
+static struct hda_pcm *pcm_streams[MAX_PCM_STREAMS];
 
 #ifndef OLD_HDA_PCM
 /* get a string corresponding to the given HDA_PCM_TYPE_XXX */
@@ -529,7 +529,7 @@ void hda_list_pcms(void)
 	int i;
 
 	for (i = 0; i < num_pcm_streams; i++) {
-		struct hda_pcm *p = &pcm_streams[i];
+		struct hda_pcm *p = pcm_streams[i];
 		if (!p->stream[0].substreams && !p->stream[1].substreams)
 			continue;
 #ifdef OLD_HDA_PCM
@@ -588,26 +588,26 @@ void hda_test_pcm(int id, int op, int subid,
 	unsigned int ctls = 0;
 	int i, err;
 
-	if (id < 0 || id >= num_pcm_streams) {
+	if (id < 0 || id >= num_pcm_streams || !pcm_streams[id]) {
 		hda_log(HDA_LOG_ERR, "Invalid PCM id %d\n", id);
 		return;
 	}
-	if (!pcm_streams[id].stream[0].substreams &&
-	    !pcm_streams[id].stream[1].substreams) {
+	if (!pcm_streams[id]->stream[0].substreams &&
+	    !pcm_streams[id]->stream[1].substreams) {
 		hda_log(HDA_LOG_ERR, "Empty PCM for id %d\n", id);
 		return;
 	}
 
-	if (!pcm_streams[id].stream[dir].substreams) {
+	if (!pcm_streams[id]->stream[dir].substreams) {
 		hda_log(HDA_LOG_INFO, "No substream in PCM %s for %s\n",
-			pcm_streams[id].name,
+			pcm_streams[id]->name,
 			(dir ? "capt" : "play"));
 		return;
 	}
-	if (subid < 0 || subid >= pcm_streams[id].stream[dir].substreams) {
+	if (subid < 0 || subid >= pcm_streams[id]->stream[dir].substreams) {
 		hda_log(HDA_LOG_INFO,
 			"Invalid substream %d for PCM %s for %s\n",
-			subid, pcm_streams[id].name,
+			subid, pcm_streams[id]->name,
 			(dir ? "capt" : "play"));
 		return;
 	}
@@ -624,7 +624,7 @@ void hda_test_pcm(int id, int op, int subid,
 	runtime->format = get_alsa_format(format);
 	runtime->channels = channels;
 
-	hinfo = &pcm_streams[id].stream[dir];
+	hinfo = &pcm_streams[id]->stream[dir];
 
 	runtime->hw.channels_min = hinfo->channels_min;
 	runtime->hw.channels_max = hinfo->channels_max;
@@ -643,7 +643,7 @@ void hda_test_pcm(int id, int op, int subid,
 
 	if (op != PCM_TEST_END) {
 		hda_log(HDA_LOG_INFO, "Open PCM %s for %s\n",
-			pcm_streams[id].name,
+			pcm_streams[id]->name,
 			(dir ? "capt" : "play"));
 		snd_hda_power_up(_codec);
 		err = hinfo->ops.open(hinfo, _codec, substream);
@@ -739,7 +739,7 @@ static int attach_pcm(struct hda_bus *bus, struct hda_codec *codec,
 			hda_log(HDA_LOG_ERR, "Too many streams\n");
 			return 0;
 		}
-		pcm_streams[num_pcm_streams] = *cpcm;
+		pcm_streams[num_pcm_streams] = cpcm;
 #ifdef HAVE_HDA_ATTACH_PCM
 		cpcm->pcm = &dummy_pcm; /* just non-NULL */
 #endif
-- 
1.7.9.5
