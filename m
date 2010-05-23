From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 095/199] Documentation/sound/oss/MultiSound: Checkpatch cleanup
Date: Sun, 23 May 2010 21:52:45 +0200
Message-ID: <1274644376-24176-3-git-send-email-andrea.gelmini@gelma.net>
References: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644376-24176-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: Andrew Veliath <andrewtv@usa.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Randy Dunlap <rdunlap@xenotime.net>, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Documentation/sound/oss/MultiSound:17: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:21: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:22: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:25: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:36: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:43: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:44: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:47: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:59: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:60: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:68: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:94: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:113: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:118: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:123: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:128: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:153: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:157: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:159: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:163: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:165: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:170: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:173: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:177: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:180: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:183: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:187: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:212: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:215: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:220: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:224: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:225: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:228: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:245: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:246: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:281: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:282: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:285: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:287: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:288: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:290: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:292: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:295: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:298: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:307: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:308: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:311: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:315: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:330: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:333: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:339: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:344: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:517: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:526: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:654: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:676: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:698: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:726: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:806: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:849: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:875: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:909: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:922: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:933: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:980: ERROR: trailing whitespace
Documentation/sound/oss/MultiSound:1117: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/sound/oss/MultiSound |  132 ++++++++++++++++++------------------
 1 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/Documentation/sound/oss/MultiSound b/Documentation/sound/oss/MultiSound
index e4a18bb..7a7a882 100644
--- a/Documentation/sound/oss/MultiSound
+++ b/Documentation/sound/oss/MultiSound
@@ -14,15 +14,15 @@
 #
 #  -=-=- Getting Firmware -=-=-
 #  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-#  
+#
 #  See the section `Obtaining and Creating Firmware Files' in this
 #  document for instructions on obtaining the necessary firmware
 #  files.
-#  
-#  
+#
+#
 #  Supported Features
 #  ~~~~~~~~~~~~~~~~~~
-#  
+#
 #  Currently, full-duplex digital audio (/dev/dsp only, /dev/audio is
 #  not currently available) and mixer functionality (/dev/mixer) are
 #  supported (memory mapped digital audio is not yet supported).
@@ -33,18 +33,18 @@
 #  Support for the Turtle Beach MultiSound Hurricane architecture is
 #  composed of the following modules (these can also operate compiled
 #  into the kernel):
-#  
+#
 #  msnd               - MultiSound base (requires soundcore)
 #
 #  msnd_classic       - Base audio/mixer support for Classic, Monetery and
 #                       Tahiti cards
 #
 #  msnd_pinnacle      - Base audio/mixer support for Pinnacle and Fiji cards
-#  
-#  
+#
+#
 #  Important Notes - Read Before Using
 #  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-#  
+#
 #  The firmware files are not included (may change in future).  You
 #  must obtain these images from Turtle Beach (they are included in
 #  the MultiSound Development Kits), and place them in /etc/sound for
@@ -56,8 +56,8 @@
 #  Please note these files must be binary files, not assembler.  See
 #  the section later in this document for instructions to obtain these
 #  files.
-#  
-#  
+#
+#
 #  Configuring Card Resources
 #  ~~~~~~~~~~~~~~~~~~~~~~~~~~
 #
@@ -65,7 +65,7 @@
 #     or your machine may crash if you do not do this correctly. **
 #
 #  * Classic/Monterey/Tahiti
-#  
+#
 #  These cards are configured through the driver msnd_classic.  You must
 #  know the io port, then the driver will select the irq and memory resources
 #  on the card.  It is up to you to know if these are free locations or now,
@@ -91,7 +91,7 @@
 #
 #
 #  *** PnP mode
-#  
+#
 #  Use pnpdump to obtain a sample configuration if you can; I was able
 #  to obtain one with the command `pnpdump 1 0x203' -- this may vary
 #  for you (running pnpdump by itself did not work for me).  Then,
@@ -110,22 +110,22 @@
 #  (READPORT 0x0203)
 #  (CSN 2)
 #  (IDENTIFY *)
-#  
+#
 #  # DSP
 #  (CONFIGURE BVJ0440/-1 (LD 0
 #          (INT 0 (IRQ 5 (MODE +E))) (IO 0 (BASE 0x0210)) (MEM 0 (BASE 0x0d8000))
 #          (ACT Y)))
-#  
+#
 #  # Kurzweil Synth (Pinnacle Only)
 #  (CONFIGURE BVJ0440/-1 (LD 1
 #          (IO 0 (BASE 0x0330)) (INT 0 (IRQ 9 (MODE +E)))
 #          (ACT Y)))
-#  
+#
 #  (WAITFORKEY)
 #
 #
 #  *** Non-PnP mode
-#  
+#
 #  The second way is by running the card in non-PnP mode.  This
 #  actually has some advantages in that you can access some other
 #  devices on the card, such as the joystick and IDE controller.  To
@@ -150,41 +150,41 @@
 #
 # ** It is very easy to cause problems in your machine if you choose a
 #    resource value which is incorrect. **
-#  
+#
 #
 #  Examples
 #  ~~~~~~~~
-#  
+#
 #  * MultiSound Classic/Monterey/Tahiti:
-#  
+#
 #  modprobe soundcore
 #  insmod msnd
 #  insmod msnd_classic io=0x290 irq=7 mem=0xd0000
-#  
+#
 #  * MultiSound Pinnacle in PnP mode:
-#  
+#
 #  modprobe soundcore
 #  insmod msnd
 #  isapnp mypinnacle.conf
 #  insmod msnd_pinnacle io=0x210 irq=5 mem=0xd8000 <-- match mypinnacle.conf values
-#  
+#
 #  * MultiSound Pinnacle in non-PnP mode (replace 0x250 with your configuration port,
 #    one of 0x250, 0x260 or 0x270):
-#  
+#
 #  insmod soundcore
 #  insmod msnd
 #  insmod msnd_pinnacle cfg=0x250 io=0x290 irq=5 mem=0xd0000
-#  
+#
 # * To use the MPU-compatible Kurzweil synth on the Pinnacle in PnP
 #   mode, add the following (assumes you did `isapnp mypinnacle.conf'):
-#  
+#
 #  insmod sound
 #  insmod mpu401 io=0x330 irq=9                    <-- match mypinnacle.conf values
-#  
+#
 # * To use the MPU-compatible Kurzweil synth on the Pinnacle in non-PnP
 #   mode, add the following.  Note how we first configure the peripheral's
 #   resources, _then_ install a Linux driver for it:
-#  
+#
 #  insmod sound
 #  pinnaclecfg 0x250 mpu 0x330 9
 #  insmod mpu401 io=0x330 irq=9
@@ -209,23 +209,23 @@
 #  insmod msnd
 #  insmod msnd_pinnacle cfg=0x250 io=0x290 irq=5 mem=0xd0000 joystick_io=0x200
 #
-#  
+#
 #  msnd_classic, msnd_pinnacle Required Options
 #  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-#  
+#
 #  If the following options are not given, the module will not load.
 #  Examine the kernel message log for informative error messages.
 #  WARNING--probing isn't supported so try to make sure you have the
 #  correct shared memory area, otherwise you may experience problems.
-#  
+#
 #  io                   I/O base of DSP, e.g. io=0x210
 #  irq                  IRQ number, e.g. irq=5
 #  mem                  Shared memory area, e.g. mem=0xd8000
-#  
-#  
+#
+#
 #  msnd_classic, msnd_pinnacle Additional Options
 #  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-#  
+#
 #  fifosize             The digital audio FIFOs, in kilobytes.  If not
 #                       specified, the default will be used.  Increasing
 #                       this value will reduce the chance of a FIFO
@@ -242,8 +242,8 @@
 #  calibrate_signal     Setting this to one calibrates the ADCs to the
 #                       signal, zero calibrates to the card (defaults
 #                       to zero).
-#  
-#  
+#
+#
 #  msnd_pinnacle Additional Options
 #  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 #
@@ -278,24 +278,24 @@
 #  ide_io1		Second I/O port of IDE controller
 #  ide_irq		IRQ IDE controller
 #  joystick_io          I/O port of joystick
-#  
-#  
+#
+#
 #  Obtaining and Creating Firmware Files
 #  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-#  
+#
 #       For the Classic/Tahiti/Monterey
-#       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
-#  
+#       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+#
 #  Download to /tmp and unzip the following file from Turtle Beach:
-#  
+#
 #       ftp://ftp.voyetra.com/pub/tbs/msndcl/msndvkit.zip
-#  
+#
 #  When unzipped, unzip the file named MsndFiles.zip.  Then copy the
 #  following firmware files to /etc/sound (note the file renaming):
-#  
+#
 #    cp DSPCODE/MSNDINIT.BIN /etc/sound/msndinit.bin
 #    cp DSPCODE/MSNDPERM.REB /etc/sound/msndperm.bin
-#  
+#
 #  When configuring the Linux kernel, specify /etc/sound/msndinit.bin and
 #  /etc/sound/msndperm.bin for the two firmware files (Linux kernel
 #  versions older than 2.2 do not ask for firmware paths, and are
@@ -304,15 +304,15 @@
 #  If you are compiling the driver into the kernel, these files must
 #  be accessible during compilation, but will not be needed later.
 #  The files must remain, however, if the driver is used as a module.
-#  
-#  
+#
+#
 #       For the Pinnacle/Fiji
 #       ~~~~~~~~~~~~~~~~~~~~~
-#  
+#
 #  Download to /tmp and unzip the following file from Turtle Beach (be
 #  sure to use the entire URL; some have had trouble navigating to the
 #  URL):
-#  
+#
 #       ftp://ftp.voyetra.com/pub/tbs/pinn/pnddk100.zip
 #
 #  Unpack this shell archive, and run make in the created directory
@@ -327,21 +327,21 @@
 #  To generating the firmware files with the `conv' program, we create
 #  the binary firmware files by doing the following conversion
 #  (assuming the archive unpacked into a directory named PINNDDK):
-#  
+#
 #    ./conv < PINNDDK/dspcode/pndspini.asm > /etc/sound/pndspini.bin
 #    ./conv < PINNDDK/dspcode/pndsperm.asm > /etc/sound/pndsperm.bin
-#  
+#
 #  The conv (and conv.l) program is not needed after conversion and can
 #  be safely deleted.  Then, when configuring the Linux kernel, specify
 #  /etc/sound/pndspini.bin and /etc/sound/pndsperm.bin for the two
 #  firmware files (Linux kernel versions older than 2.2 do not ask for
 #  firmware paths, and are hardcoded to /etc/sound).
-#  
+#
 #  If you are compiling the driver into the kernel, these files must
 #  be accessible during compilation, but will not be needed later.
 #  The files must remain, however, if the driver is used as a module.
 #
-#  
+#
 #  Using Digital I/O with the S/PDIF Port
 #  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 #
@@ -514,7 +514,7 @@ X		exit(1);
 X	}
 X
 X	recsrc |= SOUND_MASK_DIGITAL1;
-X	
+X
 X	if (ioctl(fd, SOUND_MIXER_WRITE_RECSRC, &recsrc) < 0) {
 X		fprintf(stderr, "error: ioctl write recording source failed\n");
 X		perror("ioctl");
@@ -523,7 +523,7 @@ X		exit(1);
 X	}
 X
 X	close(fd);
-X	
+X
 X	return 0;
 }
 SHAR_EOF
@@ -651,7 +651,7 @@ static int msnd_read_cfg_io0(int cfg, int num, WORD *io)
 {
 X	if (msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
 X		return -EIO;
-X	
+X
 X	*io = MAKEWORD(msnd_read_cfg(cfg, IREG_IO0_BASELO),
 X		       msnd_read_cfg(cfg, IREG_IO0_BASEHI));
 X
@@ -673,7 +673,7 @@ static int msnd_read_cfg_io1(int cfg, int num, WORD *io)
 {
 X	if (msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
 X		return -EIO;
-X	
+X
 X	*io = MAKEWORD(msnd_read_cfg(cfg, IREG_IO1_BASELO),
 X		       msnd_read_cfg(cfg, IREG_IO1_BASEHI));
 X
@@ -695,7 +695,7 @@ static int msnd_read_cfg_irq(int cfg, int num, WORD *irq)
 {
 X	if (msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
 X		return -EIO;
-X	
+X
 X	*irq = msnd_read_cfg(cfg, IREG_IRQ_NUMBER);
 X
 X	return 0;
@@ -723,7 +723,7 @@ static int msnd_read_cfg_mem(int cfg, int num, int *mem)
 {
 X	if (msnd_write_cfg(cfg, IREG_LOGDEVICE, num))
 X		return -EIO;
-X	
+X
 X	*mem = MAKEWORD(msnd_read_cfg(cfg, IREG_MEMBASELO),
 X			msnd_read_cfg(cfg, IREG_MEMBASEHI));
 X	*mem <<= 8;
@@ -803,7 +803,7 @@ X	int i;
 X
 X	for (i = 0; i < 4; ++i)
 X		msnd_write_cfg_logical(config_port, i, 0, 0, 0, 0);
-X	
+X
 X	return 0;
 }
 X
@@ -846,7 +846,7 @@ X	}
 X
 X	if (count == 0)
 X		fprintf(stderr, "no devices configured\n");
-X	
+X
 X	return 0;
 }
 X
@@ -872,7 +872,7 @@ X		fprintf(stderr, "error: io must be one of "
 X			"210, 220, 230, 240, 250, 260, 290, or 3E0\n");
 X		usage();
 X	}
-X	
+X
 X	if (!(irq == 5 ||
 X	      irq == 7 ||
 X	      irq == 9 ||
@@ -906,7 +906,7 @@ X	if (argc < 2 ||
 X	    sscanf(argv[0], "0x%x", &io) != 1 ||
 X	    sscanf(argv[1], "%d", &irq) != 1)
 X		usage();
-X	
+X
 X	return msnd_write_cfg_logical(config_port, 1, io, 0, irq, 0);
 }
 X
@@ -919,7 +919,7 @@ X	    sscanf(argv[0], "0x%x", &io0) != 1 ||
 X	    sscanf(argv[0], "0x%x", &io1) != 1 ||
 X	    sscanf(argv[1], "%d", &irq) != 1)
 X		usage();
-X	
+X
 X	return msnd_write_cfg_logical(config_port, 2, io0, io1, irq, 0);
 }
 X
@@ -930,7 +930,7 @@ X
 X	if (argc < 1 ||
 X	    sscanf(argv[0], "0x%x", &io) != 1)
 X		usage();
-X	
+X
 X	return msnd_write_cfg_logical(config_port, 3, io, 0, 0, 0);
 }
 X
@@ -977,7 +977,7 @@ X	}
 X
 X	if (rv)
 X		fprintf(stderr, "error: device configuration failed\n");
-X	
+X
 X	return 0;
 }
 SHAR_EOF
@@ -1114,7 +1114,7 @@ X		exit(1);
 X	}
 X
 X	close(fd);
-X	
+X
 X	return 0;
 }
 SHAR_EOF
-- 
1.7.1.251.gf80a2

