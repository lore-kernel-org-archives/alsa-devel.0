From: libin.yang@linux.intel.com
Subject: [PATCH 1/4] ALSA: Add documentation about HD-audio DP
	MST
Date: Thu, 31 Dec 2015 09:22:19 +0800
Message-ID: <1451524942-17288-2-git-send-email-libin.yang@linux.intel.com>
References: <1451524942-17288-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C8D8265AD9
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 02:25:19 +0100 (CET)
In-Reply-To: <1451524942-17288-1-git-send-email-libin.yang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

Add the documentation about HD-audio DP MST:
1. Overview
2. Jack

Others will be added later.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt | 78 ++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt

diff --git a/Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt b/Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt
new file mode 100644
index 0000000..ff28e55
--- /dev/null
+++ b/Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt
@@ -0,0 +1,78 @@
+To support DP MST audio, HD Audio hdmi codec driver introduces virtual pin
+and dynamic pcm assignment.
+
+Virtual pin is an extension of per_pin. The most difference of DP MST
+from legacy is that DP MST introduces device entry. Each pin can contain
+several device entries. Each device entry behaves as a pin.
+
+As each pin may contain several device entries and each codec may contain
+several pins, if we use one pcm per per_pin, there will be many PCMs.
+The new solution is to create a few PCMs and to dynamically bind pcm to
+per_pin. Driver uses spec->dyn_pcm_assign flag to indicate whether to use
+the new solution.
+
+PCM
+===
+To be added
+
+
+Jack
+====
+
+Presume:
+ - MST must be dyn_pcm_assign, it can be acomp or !acomp;
+ - NON-MST may or may not be dyn_pcm_assign, it can be acomp or !acomp;
+
+So there are the following scenarios:
+ a.MST (&& dyn_pcm_assign) && acomp
+ b.MST (&& dyn_pcm_assign) && !acomp
+ c.NON-MST && dyn_pcm_assign && acomp
+ d.NON-MST && dyn_pcm_assign && !acomp
+ e.NON-MST && !dyn_pcm_assign && acomp
+ f.NON-MST && !dyn_pcm_assign && !acomp
+
+Below discussion will ignore MST and NON-MST difference as it doesn't
+impact on jack handling too much.
+
+Driver uses new struct hdmi_pcm pcm[] array in hdmi_spec and snd_jack is
+a member of hdmi_pcm. Each pin has one struct hdmi_pcm * pcm pointer.
+
+For !dyn_pcm_assign, per_pin->pcm will assigned to spec->pcm[n] statically.
+
+For dyn_pcm_assign, per_pin->pcm will assigned to spec->pcm[n]
+when monitor is hotplugged.
+
+
+Build Jack
+----------
+
+Build jack based on the pcm. acomp or !acomp will not impact on jack buiding.
+- dyn_pcm_assign
+Will not use hda_jack but use snd_jack in spec->pcm_rec[pcm_idx].jack directly.
+
+- !dyn_pcm_assign
+Use hda_jack and assign spec->pcm_rec[pcm_idx].jack = jack->jack statically.
+
+
+Unsolicited Event Enabling
+--------------------------
+Enable unsolicited event if !acomp.
+
+
+Monitor Hotplug Event Handling
+------------------------------
+- acomp
+pin_eld_notify() -> check_presence_and_report() -> hdmi_present_sense() ->
+sync_eld_via_acomp().
+Use directly snd_jack_report() on spec->pcm_rec[pcm_idx].jack for
+both dyn_pcm_assign and !dyn_pcm_assign
+
+- !acomp
+Hdmi_unsol_event() -> hdmi_intrinsic_event() -> check_presence_and_report() ->
+hdmi_present_sense() -> hdmi_prepsent_sense_via_verbs()
+Use directly snd_jack_report() on spec->pcm_rec[pcm_idx].jack for dyn_pcm_assign.
+Use hda_jack mechanism to handle jack events.
+
+
+Others to be added later
+========================
-- 
1.9.1
