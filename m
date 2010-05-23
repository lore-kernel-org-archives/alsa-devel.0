From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 099/199] Documentation/sound/oss/PSS-updates: Checkpatch cleanup
Date: Sun, 23 May 2010 21:52:49 +0200
Message-ID: <1274644376-24176-7-git-send-email-andrea.gelmini@gelma.net>
References: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/oss/PSS-updates:1: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:4: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:5: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:6: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:11: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:12: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:13: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:14: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:15: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:16: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:17: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:22: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:23: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:24: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:25: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:26: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:27: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:28: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:29: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:30: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:31: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:32: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:33: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:36: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:37: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:42: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:43: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:44: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:45: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:46: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:47: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:48: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:49: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:50: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:51: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:56: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:57: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:58: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:59: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:60: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:61: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:62: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:67: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:68: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:69: ERROR: trailing whitespace
Documentation/sound/oss/PSS-updates:70: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/oss/PSS-updates |   92 +++++++++++++++++-----------------
 1 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/Documentation/sound/oss/PSS-updates b/Documentation/sound/oss/PSS-updates
index c84dd75..83a94c4 100644
--- a/Documentation/sound/oss/PSS-updates
+++ b/Documentation/sound/oss/PSS-updates
@@ -1,73 +1,73 @@
-	This file contains notes for users of PSS sound cards who wish to use the 
+	This file contains notes for users of PSS sound cards who wish to use the
 newly added features of the newest version of this driver.
 
-	The major enhancements present in this new revision of this driver is the 
-addition of two new module parameters that allow you to take full advantage of 
-all the features present on your PSS sound card.  These features include the 
+	The major enhancements present in this new revision of this driver is the
+addition of two new module parameters that allow you to take full advantage of
+all the features present on your PSS sound card.  These features include the
 ability to enable both the builtin CDROM and joystick ports.
 
 pss_enable_joystick
 
-	This parameter is basically a flag.  A 0 will leave the joystick port 
-disabled, while a non-zero value would enable the joystick port.  The default 
-setting is pss_enable_joystick=0 as this keeps this driver fully compatible 
-with systems that were using previous versions of this driver.  If you wish to 
-enable the joystick port you will have to add pss_enable_joystick=1 as an 
-argument to the driver.  To actually use the joystick port you will then have 
-to load the joystick driver itself.  Just remember to load the joystick driver 
+	This parameter is basically a flag.  A 0 will leave the joystick port
+disabled, while a non-zero value would enable the joystick port.  The default
+setting is pss_enable_joystick=0 as this keeps this driver fully compatible
+with systems that were using previous versions of this driver.  If you wish to
+enable the joystick port you will have to add pss_enable_joystick=1 as an
+argument to the driver.  To actually use the joystick port you will then have
+to load the joystick driver itself.  Just remember to load the joystick driver
 AFTER the pss sound driver.
 
 pss_cdrom_port
 
-	This parameter takes a port address as its parameter.  Any available port 
-address can be specified to enable the CDROM port, except for 0x0 and -1 as 
-these values would leave the port disabled.  Like the joystick port, the cdrom 
-port will require that an appropriate CDROM driver be loaded before you can make 
-use of the newly enabled CDROM port.  Like the joystick port option above, 
-remember to load the CDROM driver AFTER the pss sound driver.  While it may 
-differ on some PSS sound cards, all the PSS sound cards that I have seen have a 
-builtin Wearnes CDROM port.  If this is the case with your PSS sound card you 
-should load aztcd with the appropriate port option that matches the port you 
-assigned to the CDROM port when you loaded your pss sound driver.  (ex. 
-modprobe pss pss_cdrom_port=0x340 && modprobe aztcd aztcd=0x340)  The default 
-setting of this parameter leaves the CDROM port disabled to maintain full 
+	This parameter takes a port address as its parameter.  Any available port
+address can be specified to enable the CDROM port, except for 0x0 and -1 as
+these values would leave the port disabled.  Like the joystick port, the cdrom
+port will require that an appropriate CDROM driver be loaded before you can make
+use of the newly enabled CDROM port.  Like the joystick port option above,
+remember to load the CDROM driver AFTER the pss sound driver.  While it may
+differ on some PSS sound cards, all the PSS sound cards that I have seen have a
+builtin Wearnes CDROM port.  If this is the case with your PSS sound card you
+should load aztcd with the appropriate port option that matches the port you
+assigned to the CDROM port when you loaded your pss sound driver.  (ex.
+modprobe pss pss_cdrom_port=0x340 && modprobe aztcd aztcd=0x340)  The default
+setting of this parameter leaves the CDROM port disabled to maintain full
 compatibility with systems using previous versions of this driver.
 
-	Other options have also been added for the added convenience and utility 
-of the user.  These options are only available if this driver is loaded as a 
+	Other options have also been added for the added convenience and utility
+of the user.  These options are only available if this driver is loaded as a
 module.
 
 pss_no_sound
 
-	This module parameter is a flag that can be used to tell the driver to 
-just configure non-sound components.  0 configures all components, a non-0 
-value will only attept to configure the CDROM and joystick ports.  This 
-parameter can be used by a user who only wished to use the builtin joystick 
-and/or CDROM port(s) of his PSS sound card.  If this driver is loaded with this 
-parameter and with the parameter below set to true then a user can safely unload 
-this driver with the following command "rmmod pss && rmmod ad1848 && rmmod 
-mpu401 && rmmod sound && rmmod soundcore" and retain the full functionality of 
-his CDROM and/or joystick port(s) while gaining back the memory previously used 
-by the sound drivers.  This default setting of this parameter is 0 to retain 
+	This module parameter is a flag that can be used to tell the driver to
+just configure non-sound components.  0 configures all components, a non-0
+value will only attept to configure the CDROM and joystick ports.  This
+parameter can be used by a user who only wished to use the builtin joystick
+and/or CDROM port(s) of his PSS sound card.  If this driver is loaded with this
+parameter and with the parameter below set to true then a user can safely unload
+this driver with the following command "rmmod pss && rmmod ad1848 && rmmod
+mpu401 && rmmod sound && rmmod soundcore" and retain the full functionality of
+his CDROM and/or joystick port(s) while gaining back the memory previously used
+by the sound drivers.  This default setting of this parameter is 0 to retain
 full behavioral compatibility with previous versions of this driver.
 
 pss_keep_settings
 
-	This parameter can be used to specify whether you want the driver to reset 
-all emulations whenever its unloaded.  This can be useful for those who are 
-sharing resources (io ports, IRQ's, DMA's) between different ISA cards.  This 
-flag can also be useful in that future versions of this driver may reset all 
-emulations by default on the driver's unloading (as it probably should), so 
-specifying it now will ensure that all future versions of this driver will 
-continue to work as expected.  The default value of this parameter is 1 to 
+	This parameter can be used to specify whether you want the driver to reset
+all emulations whenever its unloaded.  This can be useful for those who are
+sharing resources (io ports, IRQ's, DMA's) between different ISA cards.  This
+flag can also be useful in that future versions of this driver may reset all
+emulations by default on the driver's unloading (as it probably should), so
+specifying it now will ensure that all future versions of this driver will
+continue to work as expected.  The default value of this parameter is 1 to
 retain full behavioral compatibility with previous versions of this driver.
 
 pss_firmware
 
-	This parameter can be used to specify the file containing the firmware 
-code so that a user could tell the driver where that file is located instead 
-of having to put it in a predefined location with a predefined name.  The 
-default setting of this parameter is "/etc/sound/pss_synth" as this was the 
+	This parameter can be used to specify the file containing the firmware
+code so that a user could tell the driver where that file is located instead
+of having to put it in a predefined location with a predefined name.  The
+default setting of this parameter is "/etc/sound/pss_synth" as this was the
 path and filename the hardcoded value in the previous versions of this driver.
 
 Examples:
-- 
1.7.1.251.gf80a2

