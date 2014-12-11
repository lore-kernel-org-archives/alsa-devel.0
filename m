From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/4] sound: oss: Remove SoftOSS documentation
Date: Thu, 11 Dec 2014 14:19:10 +0200
Message-ID: <1418300353-13243-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 800562606E6
 for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2014 13:19:21 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

SoftOSS has been removed before kernel git history but not this
documentation part.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 Documentation/sound/oss/README.OSS | 46 --------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/Documentation/sound/oss/README.OSS b/Documentation/sound/oss/README.OSS
index 4be259428a1c..ad261dd602ce 100644
--- a/Documentation/sound/oss/README.OSS
+++ b/Documentation/sound/oss/README.OSS
@@ -516,52 +516,6 @@ Yamaha OPL3-SA1
 	use the standard MSS, MPU401 and OPL3 options with these chips and to
 	activate the card using isapnptools.
 
-4Front Technologies SoftOSS
-
-	SoftOSS is a software based wave table emulation which works with
-	any 16 bit stereo sound card. Due to its nature a fast CPU is
-	required (P133 is minimum). Although SoftOSS does _not_ use MMX
-	instructions it has proven out that recent processors (which appear
-	to have MMX) perform significantly better with SoftOSS than earlier
-	ones. For example a P166MMX beats a PPro200. SoftOSS should not be used
-	on 486 or 386 machines.
-
-	The amount of CPU load caused by SoftOSS can be controlled by
-	selecting the CONFIG_SOFTOSS_RATE and CONFIG_SOFTOSS_VOICES
-	parameters properly (they will be prompted by make config). It's
-	recommended to set CONFIG_SOFTOSS_VOICES to 32. If you have a
-	P166MMX or faster (PPro200 is not faster) you can set
-	CONFIG_SOFTOSS_RATE to 44100 (kHz). However with slower systems it
-	recommended to use sampling rates around 22050 or even 16000 kHz.
-	Selecting too high values for these parameters may hang your
-	system when playing MIDI files with hight degree of polyphony
-	(number of concurrently playing notes). It's also possible to
-	decrease CONFIG_SOFTOSS_VOICES. This makes it possible to use
-	higher sampling rates. However using fewer voices decreases
-	playback quality more than decreasing the sampling rate.
-
-	SoftOSS keeps the samples loaded on the system's RAM so much RAM is
-	required. SoftOSS should never be used on machines with less than 16 MB
-	of RAM since this is potentially dangerous (you may accidentally run out
-	of memory which probably crashes the machine). 
-
-	SoftOSS implements the wave table API originally designed for GUS. For
-	this reason all applications designed for GUS should work (at least
-	after minor modifications). For example gmod/xgmod and playmidi -g are
-	known to work.
-
-	To work SoftOSS will require GUS compatible
-	patch files to be installed on the system (in /dos/ultrasnd/midi). You
-	can use the public domain MIDIA patchset available from several ftp
-	sites.
-
-        *********************************************************************
-	IMPORTANT NOTICE! The original patch set distributed with the Gravis 
-	Ultrasound card is not in public domain (even though it's available from
-	some FTP sites). You should contact Voice Crystal (www.voicecrystal.com)
-	if you like to use these patches with SoftOSS included in OSS/Free.
-        *********************************************************************
-
 PSS based cards (AD1848 + ADSP-2115 + Echo ESC614 ASIC)
 	Analog Devices and Echo Speech have together defined a sound card
 	architecture based on the above chips. The DSP chip is used
-- 
2.1.3
