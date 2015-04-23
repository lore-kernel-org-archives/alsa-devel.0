From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v9 7/7] ALSA: Docs: Add documentation for Jack
	kcontrols
Date: Thu, 23 Apr 2015 10:32:46 +0800
Message-ID: <1429756366-22520-8-git-send-email-yang.jie@intel.com>
References: <1429756366-22520-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E8A8C265B5F
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 04:29:39 +0200 (CEST)
In-Reply-To: <1429756366-22520-1-git-send-email-yang.jie@intel.com>
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

Add documentation describing Jack embedded kcontrols, and how to
use it on HD-Audio and ASoC case.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 Documentation/sound/alsa/Jack-Controls.txt | 49 ++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/sound/alsa/Jack-Controls.txt

diff --git a/Documentation/sound/alsa/Jack-Controls.txt b/Documentation/sound/alsa/Jack-Controls.txt
new file mode 100644
index 0000000..c5dd866
--- /dev/null
+++ b/Documentation/sound/alsa/Jack-Controls.txt
@@ -0,0 +1,49 @@
+Why we need kcontrols for Jack?
+===============================
+
+ALSA using kcontrols to export controlling(switch, volume, Mux, ...) to
+user space, e.g. pulseaudio can switch off headphone and switch on
+speaker when no heaphone is pluged in.
+
+For each physical jack, there may be dynamic pluged in/out status which
+upper layer may be interested in. Currently the ALSA jack core registers
+only input devices for each jack registered. These jack input devices
+are not readable by userspace devices that run as non root.
+
+So we create embeded kcontrols for each jack(including phantom jack),
+report jack event via these kcontrols, userspace switch them to ack on
+these event, to implement what they are wanna to.
+
+Combining with ucm machanism, userpace can do fantasic controlling as
+they want to.
+
+Jack and kcontrols
+==================
+
+Each jack will have a kcontrol list, we can create a kcontrol and attach
+it to the jack, at jack creating stage. Also, we can add kcontrol to an
+exist jack, at anytime when you are happy.
+
+Those kcontrols will be freed automatically when the Jack is freed.
+
+How to create kcontrol embedded jack?
+=====================================
+
+To be compatible with previous HD-Audio jack and ASoC jack, we modify
+snd_jack_new() with adding two params:
+
+ - @initial_kctl: create kctl if true, also add it to the non-phantom
+	jack kctl list.
+ - @phantom_jack: for phantom jack, only create needed kctl, won't create
+	input device.
+
+For HDA jack, we can use phantom_jack = true for phantom jack creating,
+and set initial_kctl to true to initial kcontrol with the jack id.
+
+For ASoC jack, usually, we create kcontrols after jack is
+created(calling snd_jack_new() with initial_kctl==false), with
+calling snd_hda_jack_add_kctl() for each jack pins. And, the pin name
+will be assigned to the corresponding kcontrol name. So, to make
+userspace understand and recognize it, please assign proper name for
+each jack pin.
+
-- 
1.9.1
