From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/30] ALSA: doc: ReSTize
	HD-Audio-DP-MST-audio.txt
Date: Thu, 10 Nov 2016 22:06:18 +0100
Message-ID: <20161110210641.5907-8-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C3992673A8
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:53 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 87E71ADE0
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:52 +0000 (UTC)
In-Reply-To: <20161110210641.5907-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A simple conversion from a plain text file.
Put to hd-audio subdirectory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../dp-mst.rst}                                    | 30 ++++++++++++++--------
 Documentation/sound/hd-audio/index.rst             |  1 +
 2 files changed, 21 insertions(+), 10 deletions(-)
 rename Documentation/sound/{alsa/HD-Audio-DP-MST-audio.txt => hd-audio/dp-mst.rst} (69%)

diff --git a/Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt b/Documentation/sound/hd-audio/dp-mst.rst
similarity index 69%
rename from Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt
rename to Documentation/sound/hd-audio/dp-mst.rst
index 82744ac3513d..58b72437e6c3 100644
--- a/Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt
+++ b/Documentation/sound/hd-audio/dp-mst.rst
@@ -1,3 +1,7 @@
+=======================
+HD-Audio DP-MST Support
+=======================
+
 To support DP MST audio, HD Audio hdmi codec driver introduces virtual pin
 and dynamic pcm assignment.
 
@@ -44,10 +48,12 @@ Build Jack
 ----------
 
 - dyn_pcm_assign
-Will not use hda_jack but use snd_jack in spec->pcm_rec[pcm_idx].jack directly.
+
+  Will not use hda_jack but use snd_jack in spec->pcm_rec[pcm_idx].jack directly.
 
 - !dyn_pcm_assign
-Use hda_jack and assign spec->pcm_rec[pcm_idx].jack = jack->jack statically.
+
+  Use hda_jack and assign spec->pcm_rec[pcm_idx].jack = jack->jack statically.
 
 
 Unsolicited Event Enabling
@@ -58,16 +64,20 @@ Enable unsolicited event if !acomp.
 Monitor Hotplug Event Handling
 ------------------------------
 - acomp
-pin_eld_notify() -> check_presence_and_report() -> hdmi_present_sense() ->
-sync_eld_via_acomp().
-Use directly snd_jack_report() on spec->pcm_rec[pcm_idx].jack for
-both dyn_pcm_assign and !dyn_pcm_assign
+
+  pin_eld_notify() -> check_presence_and_report() -> hdmi_present_sense() ->
+  sync_eld_via_acomp().
+
+  Use directly snd_jack_report() on spec->pcm_rec[pcm_idx].jack for
+  both dyn_pcm_assign and !dyn_pcm_assign
 
 - !acomp
-Hdmi_unsol_event() -> hdmi_intrinsic_event() -> check_presence_and_report() ->
-hdmi_present_sense() -> hdmi_prepsent_sense_via_verbs()
-Use directly snd_jack_report() on spec->pcm_rec[pcm_idx].jack for dyn_pcm_assign.
-Use hda_jack mechanism to handle jack events.
+
+  hdmi_unsol_event() -> hdmi_intrinsic_event() -> check_presence_and_report() ->
+  hdmi_present_sense() -> hdmi_prepsent_sense_via_verbs()
+
+  Use directly snd_jack_report() on spec->pcm_rec[pcm_idx].jack for dyn_pcm_assign.
+  Use hda_jack mechanism to handle jack events.
 
 
 Others to be added later
diff --git a/Documentation/sound/hd-audio/index.rst b/Documentation/sound/hd-audio/index.rst
index c6efd55a219f..f8a72ffffe66 100644
--- a/Documentation/sound/hd-audio/index.rst
+++ b/Documentation/sound/hd-audio/index.rst
@@ -7,3 +7,4 @@ HD-Audio
    notes
    models
    controls
+   dp-mst
-- 
2.10.2
