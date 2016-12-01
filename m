From: David Howells <dhowells@redhat.com>
Subject: [PATCH 39/39] Annotate hardware config module parameters in
 sound/pci/
Date: Thu, 01 Dec 2016 12:34:52 +0000
Message-ID: <148059569231.31612.6348897065301653096.stgit@warthog.procyon.org.uk>
References: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gnomes@lxorguk.ukuu.org.uk, alsa-devel@alsa-project.org, minyard@acm.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, dhowells@redhat.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When the kernel is running in secure boot mode, we lock down the kernel to
prevent userspace from modifying the running kernel image.  Whilst this
includes prohibiting access to things like /dev/mem, it must also prevent
access by means of configuring driver modules in such a way as to cause a
device to access or modify the kernel image.

To this end, annotate module_param* statements that refer to hardware
configuration and indicate for future reference what type of parameter they
specify.  The parameter parser in the core sees this information and can
skip such parameters with an error message if the kernel is locked down.
The module initialisation then runs as normal, but just sees whatever the
default values for those parameters is.

Note that we do still need to do the module initialisation because some
drivers have viable defaults set in case parameters aren't specified and
some drivers support automatic configuration (e.g. PNP or PCI) in addition
to manually coded parameters.

This patch annotates drivers in sound/pci/.

Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jaroslav Kysela <perex@perex.cz>
cc: Takashi Iwai <tiwai@suse.com>
cc: alsa-devel@alsa-project.org
---

 sound/pci/als4000.c         |    2 +-
 sound/pci/cmipci.c          |    6 +++---
 sound/pci/ens1370.c         |    2 +-
 sound/pci/riptide/riptide.c |    6 +++---
 sound/pci/sonicvibes.c      |    2 +-
 sound/pci/via82xx.c         |    2 +-
 sound/pci/ymfpci/ymfpci.c   |    6 +++---
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index edabe1371660..e17d1742057d 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -102,7 +102,7 @@ MODULE_PARM_DESC(id, "ID string for ALS4000 soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable ALS4000 soundcard.");
 #ifdef SUPPORT_JOYSTICK
-module_param_array(joystick_port, int, NULL, 0444);
+module_param_hw_array(joystick_port, int, ioport, NULL, 0444);
 MODULE_PARM_DESC(joystick_port, "Joystick port address for ALS4000 soundcard. (0 = disabled)");
 #endif
 
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 73f593526b2d..8a217752a5f8 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -68,14 +68,14 @@ module_param_array(id, charp, NULL, 0444);
 MODULE_PARM_DESC(id, "ID string for C-Media PCI soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable C-Media PCI soundcard.");
-module_param_array(mpu_port, long, NULL, 0444);
+module_param_hw_array(mpu_port, long, ioport, NULL, 0444);
 MODULE_PARM_DESC(mpu_port, "MPU-401 port.");
-module_param_array(fm_port, long, NULL, 0444);
+module_param_hw_array(fm_port, long, ioport, NULL, 0444);
 MODULE_PARM_DESC(fm_port, "FM port.");
 module_param_array(soft_ac3, bool, NULL, 0444);
 MODULE_PARM_DESC(soft_ac3, "Software-conversion of raw SPDIF packets (model 033 only).");
 #ifdef SUPPORT_JOYSTICK
-module_param_array(joystick_port, int, NULL, 0444);
+module_param_hw_array(joystick_port, int, ioport, NULL, 0444);
 MODULE_PARM_DESC(joystick_port, "Joystick port address.");
 #endif
 
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 7e760fed0728..cdb3637a2bb1 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -106,7 +106,7 @@ module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable Ensoniq AudioPCI soundcard.");
 #ifdef SUPPORT_JOYSTICK
 #ifdef CHIP1371
-module_param_array(joystick_port, int, NULL, 0444);
+module_param_hw_array(joystick_port, int, ioport, NULL, 0444);
 MODULE_PARM_DESC(joystick_port, "Joystick port address.");
 #else
 module_param_array(joystick, bool, NULL, 0444);
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index ada5f01d479c..8b39f03f2144 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -137,12 +137,12 @@ MODULE_PARM_DESC(id, "ID string for Riptide soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable Riptide soundcard.");
 #ifdef SUPPORT_JOYSTICK
-module_param_array(joystick_port, int, NULL, 0444);
+module_param_hw_array(joystick_port, int, ioport, NULL, 0444);
 MODULE_PARM_DESC(joystick_port, "Joystick port # for Riptide soundcard.");
 #endif
-module_param_array(mpu_port, int, NULL, 0444);
+module_param_hw_array(mpu_port, int, ioport, NULL, 0444);
 MODULE_PARM_DESC(mpu_port, "MPU401 port # for Riptide driver.");
-module_param_array(opl3_port, int, NULL, 0444);
+module_param_hw_array(opl3_port, int, ioport, NULL, 0444);
 MODULE_PARM_DESC(opl3_port, "OPL3 port # for Riptide driver.");
 
 /*
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index e1a13870bb80..01ace45d9405 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -66,7 +66,7 @@ module_param_array(reverb, bool, NULL, 0444);
 MODULE_PARM_DESC(reverb, "Enable reverb (SRAM is present) for S3 SonicVibes soundcard.");
 module_param_array(mge, bool, NULL, 0444);
 MODULE_PARM_DESC(mge, "MIC Gain Enable for S3 SonicVibes soundcard.");
-module_param(dmaio, uint, 0444);
+module_param_hw(dmaio, uint, ioport, 0444);
 MODULE_PARM_DESC(dmaio, "DDMA i/o base address for S3 SonicVibes soundcard.");
 
 /*
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 38a17b4342a6..2dc8f1a86aa2 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -92,7 +92,7 @@ module_param(index, int, 0444);
 MODULE_PARM_DESC(index, "Index value for VIA 82xx bridge.");
 module_param(id, charp, 0444);
 MODULE_PARM_DESC(id, "ID string for VIA 82xx bridge.");
-module_param(mpu_port, long, 0444);
+module_param_hw(mpu_port, long, ioport, 0444);
 MODULE_PARM_DESC(mpu_port, "MPU-401 port. (VT82C686x only)");
 #ifdef SUPPORT_JOYSTICK
 module_param(joystick, bool, 0444);
diff --git a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
index 812e27a1bcbc..4faf3e1ed06a 100644
--- a/sound/pci/ymfpci/ymfpci.c
+++ b/sound/pci/ymfpci/ymfpci.c
@@ -55,12 +55,12 @@ module_param_array(id, charp, NULL, 0444);
 MODULE_PARM_DESC(id, "ID string for the Yamaha DS-1 PCI soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable Yamaha DS-1 soundcard.");
-module_param_array(mpu_port, long, NULL, 0444);
+module_param_hw_array(mpu_port, long, ioport, NULL, 0444);
 MODULE_PARM_DESC(mpu_port, "MPU-401 Port.");
-module_param_array(fm_port, long, NULL, 0444);
+module_param_hw_array(fm_port, long, ioport, NULL, 0444);
 MODULE_PARM_DESC(fm_port, "FM OPL-3 Port.");
 #ifdef SUPPORT_JOYSTICK
-module_param_array(joystick_port, long, NULL, 0444);
+module_param_hw_array(joystick_port, long, ioport, NULL, 0444);
 MODULE_PARM_DESC(joystick_port, "Joystick port address");
 #endif
 module_param_array(rear_switch, bool, NULL, 0444);
