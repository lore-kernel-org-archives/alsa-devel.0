From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 4/5] ALSA: hda: rename sound/hda/hda* as
	sound/hda/hdalib
Date: Sun,  8 Mar 2015 20:07:58 +0530
Message-ID: <1425825479-28780-5-git-send-email-vinod.koul@intel.com>
References: <1425825479-28780-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B493026044F
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 15:41:32 +0100 (CET)
In-Reply-To: <1425825479-28780-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com, Hardik T Shah <hardik.t.shah@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

The hda common library will eventually have name space conflicts with other
code, so start moving the common code to use hdalib names, so we willr
eplace all common code from snd_hda_* to snd_hdalib_*

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/Makefile                                 |   27 ++++++++++----------
 .../{hda_auto_parser.c => hdalib_auto_parser.c}    |    0
 sound/hda/{hda_beep.c => hdalib_beep.c}            |    0
 sound/hda/{hda_codec.c => hdalib_codec.c}          |    0
 .../hda/{hda_controller.c => hdalib_controller.c}  |    0
 sound/hda/{hda_eld.c => hdalib_eld.c}              |    0
 sound/hda/{hda_generic.c => hdalib_generic.c}      |    0
 sound/hda/{hda_hwdep.c => hdalib_hwdep.c}          |    0
 sound/hda/{hda_jack.c => hdalib_jack.c}            |    0
 sound/hda/{hda_proc.c => hdalib_proc.c}            |    0
 sound/hda/{hda_sysfs.c => hdalib_sysfs.c}          |    0
 11 files changed, 14 insertions(+), 13 deletions(-)
 rename sound/hda/{hda_auto_parser.c => hdalib_auto_parser.c} (100%)
 rename sound/hda/{hda_beep.c => hdalib_beep.c} (100%)
 rename sound/hda/{hda_codec.c => hdalib_codec.c} (100%)
 rename sound/hda/{hda_controller.c => hdalib_controller.c} (100%)
 rename sound/hda/{hda_eld.c => hdalib_eld.c} (100%)
 rename sound/hda/{hda_generic.c => hdalib_generic.c} (100%)
 rename sound/hda/{hda_hwdep.c => hdalib_hwdep.c} (100%)
 rename sound/hda/{hda_jack.c => hdalib_jack.c} (100%)
 rename sound/hda/{hda_proc.c => hdalib_proc.c} (100%)
 rename sound/hda/{hda_sysfs.c => hdalib_sysfs.c} (100%)

diff --git a/sound/hda/Makefile b/sound/hda/Makefile
index 6862de9bcbb6..ae57a6a6c40d 100644
--- a/sound/hda/Makefile
+++ b/sound/hda/Makefile
@@ -1,20 +1,21 @@
-snd-hda-controller-objs := hda_controller.o
-snd-hda-codec-y := hda_codec.o hda_jack.o hda_auto_parser.o \
-	hda_eld.o hda_sysfs.o
-
-snd-hda-codec-$(CONFIG_PROC_FS) += hda_proc.o
-snd-hda-codec-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
-snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
+ccflags-y += -Werror
+ccflags-y += -DDEBUG
+snd-hdalib-controller-objs := hdalib_controller.o
+snd-hdalib-codec-y := hdalib_codec.o hdalib_jack.o hdalib_auto_parser.o \
+hdalib_eld.o hdalib_sysfs.o
+snd-hdalib-codec-$(CONFIG_PROC_FS) += hdalib_proc.o
+snd-hdalib-codec-$(CONFIG_SND_HDA_HWDEP) += hdalib_hwdep.o
+snd-hdalib-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hdalib_beep.o
 
 # for trace-points
-CFLAGS_hda_controller.o := -I$(src)
-CFLAGS_hda_codec.o := -I$(src)
+CFLAGS_hdalib_controller.o := -I$(src)
+CFLAGS_hdalib_codec.o := -I$(src)
 
-snd-hda-codec-generic-objs := hda_generic.o
+snd-hdalib-codec-generic-objs := hdalib_generic.o
 
 # common driver
-obj-$(CONFIG_SND_CORE_HDA) += snd-hda-codec.o
-obj-$(CONFIG_SND_CORE_HDA) += snd-hda-controller.o
+obj-$(CONFIG_SND_CORE_HDA) += snd-hdalib-codec.o
+obj-$(CONFIG_SND_CORE_HDA) += snd-hdalib-controller.o
 
 # codec drivers
-obj-$(CONFIG_SND_CORE_HDA_GENERIC) += snd-hda-codec-generic.o
+obj-$(CONFIG_SND_CORE_HDA_GENERIC) += snd-hdalib-codec-generic.o
diff --git a/sound/hda/hda_auto_parser.c b/sound/hda/hdalib_auto_parser.c
similarity index 100%
rename from sound/hda/hda_auto_parser.c
rename to sound/hda/hdalib_auto_parser.c
diff --git a/sound/hda/hda_beep.c b/sound/hda/hdalib_beep.c
similarity index 100%
rename from sound/hda/hda_beep.c
rename to sound/hda/hdalib_beep.c
diff --git a/sound/hda/hda_codec.c b/sound/hda/hdalib_codec.c
similarity index 100%
rename from sound/hda/hda_codec.c
rename to sound/hda/hdalib_codec.c
diff --git a/sound/hda/hda_controller.c b/sound/hda/hdalib_controller.c
similarity index 100%
rename from sound/hda/hda_controller.c
rename to sound/hda/hdalib_controller.c
diff --git a/sound/hda/hda_eld.c b/sound/hda/hdalib_eld.c
similarity index 100%
rename from sound/hda/hda_eld.c
rename to sound/hda/hdalib_eld.c
diff --git a/sound/hda/hda_generic.c b/sound/hda/hdalib_generic.c
similarity index 100%
rename from sound/hda/hda_generic.c
rename to sound/hda/hdalib_generic.c
diff --git a/sound/hda/hda_hwdep.c b/sound/hda/hdalib_hwdep.c
similarity index 100%
rename from sound/hda/hda_hwdep.c
rename to sound/hda/hdalib_hwdep.c
diff --git a/sound/hda/hda_jack.c b/sound/hda/hdalib_jack.c
similarity index 100%
rename from sound/hda/hda_jack.c
rename to sound/hda/hdalib_jack.c
diff --git a/sound/hda/hda_proc.c b/sound/hda/hdalib_proc.c
similarity index 100%
rename from sound/hda/hda_proc.c
rename to sound/hda/hdalib_proc.c
diff --git a/sound/hda/hda_sysfs.c b/sound/hda/hdalib_sysfs.c
similarity index 100%
rename from sound/hda/hda_sysfs.c
rename to sound/hda/hdalib_sysfs.c
-- 
1.7.9.5
