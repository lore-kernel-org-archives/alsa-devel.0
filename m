From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Word clocks in envy24control
Date: Thu, 19 Feb 2004 11:46:22 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402191146030.1870@pnote.perex-int.cz>
References: <40346425.1030109@sun.ac.za>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40346425.1030109@sun.ac.za>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ludwig Schwardt <schwardt@sun.ac.za>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Feb 2004, Ludwig Schwardt wrote:

> 
> I see in the envy24control code that only the Delta 1010 is allowed to
> have a word clock option as Master Clock. I have the Delta 1010-LT and
> according to the documentation it definitely supports a word clock. Is
> this restriction in envy24control an ALSA ice1712 driver thing (as I
> don't see such options with amixer either), or can the option simply be
> enabled for my card as well?

It's envy24control bug. Here is the patch:

Index: hardware.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/hardware.c,v
retrieving revision 1.12
diff -u -r1.12 hardware.c
--- hardware.c	3 Nov 2003 18:20:53 -0000	1.12
+++ hardware.c	19 Feb 2004 10:43:42 -0000
@@ -45,7 +45,8 @@
 	
 	if ((err = snd_ctl_elem_read(ctl, internal_clock)) < 0)
 		g_print("Unable to read Internal Clock state: %s\n", snd_strerror(err));
-	if (card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTA1010) {
+	if (card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTA1010 ||
+	    card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTA1010LT) {
 		if ((err = snd_ctl_elem_read(ctl, word_clock_sync)) < 0)
 			g_print("Unable to read word clock sync selection: %s\n", snd_strerror(err));
 	}
@@ -78,7 +79,8 @@
 {
 	int err;
 
-	if (card_eeprom.subvendor != ICE1712_SUBDEVICE_DELTA1010)
+	if (card_eeprom.subvendor != ICE1712_SUBDEVICE_DELTA1010 &&
+	    card_eeprom.subvendor != ICE1712_SUBDEVICE_DELTA1010LT)
 		return;
 	snd_ctl_elem_value_set_boolean(word_clock_sync, 0, on ? 1 : 0);
 	if ((err = snd_ctl_elem_write(ctl, word_clock_sync)) < 0)
@@ -169,7 +171,8 @@
 	
 	if ((err = snd_ctl_elem_read(ctl, internal_clock)) < 0)
 		g_print("Unable to read Internal Clock state: %s\n", snd_strerror(err));
-	if (card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTA1010) {
+	if (card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTA1010 ||
+	    card_eeprom.subvendor == ICE1712_SUBDEVICE_DELTA1010LT) {
 		if ((err = snd_ctl_elem_read(ctl, word_clock_sync)) < 0)
 			g_print("Unable to read word clock sync selection: %s\n", snd_strerror(err));
 	}

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
