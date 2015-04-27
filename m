From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v10 7/7] ALSA: Docs: Add documentation for Jack
	kcontrols
Date: Mon, 27 Apr 2015 21:21:02 +0800
Message-ID: <1430140862-17207-8-git-send-email-yang.jie@intel.com>
References: <1430140862-17207-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A6C98265275
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 15:17:46 +0200 (CEST)
In-Reply-To: <1430140862-17207-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tanu.kaskinen@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Add documentation describing Jack kcontrols and how to use them
with HD-Audio and ASoC.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 Documentation/sound/alsa/Jack-Controls.txt | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/sound/alsa/Jack-Controls.txt

diff --git a/Documentation/sound/alsa/Jack-Controls.txt b/Documentation/sound/alsa/Jack-Controls.txt
new file mode 100644
index 0000000..fe1c5e0
--- /dev/null
+++ b/Documentation/sound/alsa/Jack-Controls.txt
@@ -0,0 +1,43 @@
+Why we need Jack kcontrols
+==========================
+
+ALSA uses kcontrols to export audio controls(switch, volume, Mux, ...)
+to user space. This means userspace applications like pulseaudio can
+switch off headphones and switch on speakers when no headphones are
+pluged in.
+
+The old ALSA jack code only created input devices for each registered
+jack. These jack input devices are not readable by userspace devices
+that run as non root.
+
+The new jack code creates embedded jack kcontrols for each jack that
+can be read by any process.
+
+This can be combined with UCM to allow userspace to route audio more
+intelligently based on jack insertion or removal events.
+
+Jack Kcontrol Internals
+=======================
+
+Each jack will have a kcontrol list, so that we can create a kcontrol
+and attach it to the jack, at jack creation stage. We can also add a
+kcontrol to an existing jack, at anytime when required.
+
+Those kcontrols will be freed automatically when the Jack is freed.
+
+How to use jack kcontrols
+=========================
+
+In order to keep compatibility, snd_jack_new() has been modified by
+adding two params :-
+
+ - @initial_kctl: if true, create a kcontrol and add it to the jack
+	list.
+ - @phantom_jack: Don't create a input device for phantom jacks.
+
+HDA jacks can set phantom_jack to true in order to create a phantom
+jack and set initial_kctl to true to create an initial kcontrol with
+the correct id.
+
+ASoC jacks should set initial_kctl as false. The pin name will be
+assigned as the jack kcontrol name.
-- 
1.9.1
