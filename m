From: ross@lug.udel.edu
Subject: ice1712: Card ID problem
Date: Wed, 8 Sep 2004 16:33:46 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040908203346.GA27226@jose.lug.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sf.net
Cc: bkaney@gmail.com
List-Id: alsa-devel@alsa-project.org

Hello everyone,

	I'm tracking down the problem that I reported on the alsa-user
mailing list below.  I started by trying to answer the question "Why
does envy24control think I have 8 outputs, 0 inputs, and 2 spdifs?"

	My very first thought: maybe the driver is mis-identifing the
card.  As a debug measure, I inserted the following line early on in
the execution:
fprintf (stderr, "DEBUG: card_eeprom.subvendor = %x\n", card_eeprom.subvendor);

When I run envy24control, this prints:
DEBUG: card_eeprom.subvendor = 0x121433a0

This subvendor ID doesn't exist in envy24control.h.  So I changed the
ICE1712_SUBDEVICE_DELTA44 to match the above ID.  Nothing has changed.
I tried also forcing the ID to the original ID in envy24control.h, to no
effect.

Summary: the wrong subdevice ID doesn't seem to be causing the problem.



Some more digging brings me to mixer.c - the place where the code
establishes which channels are active.  In particular, I'm looking
around line 200:

for (i = 0; i < input_channels; i++) {
                snd_ctl_elem_value_set_numid(val, 0);
                snd_ctl_elem_value_set_index(val, i);
                if (snd_ctl_elem_read(ctl, val) < 0)
                        continue;

                stream_is_active[i + MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS] = 1;
                nb_active_channels++;
        }

Since input_channels ends up being zero, it must be the case that
snd_ctl_elem_read(ctl, val) is returning less than zero every time.  The
docs are kind of skimpy on why this might happen - anyone have any tips?

Thanks a lot,
Ross


PS - Brian, could you apply the patch that is at the very bottom of this
email and run envy24control?  I'd like to see your output to see if you
get the same kinds of messages as I do.


----- Forwarded message from ross@lug.udel.edu -----

From: ross@lug.udel.edu
To: alsa-user@lists.sf.net
X-Spam-Score: 0.4 (/)
Subject: [Alsa-user] ICE1712 broken with 2.4.27, alsa-1.0.6a
X-Original-Date: Thu, 26 Aug 2004 00:37:03 -0400
Date: Thu, 26 Aug 2004 00:37:03 -0400

Hello,

	I'm trying to get my Delta44 ICE1712 card working again, but
it's not working correctly.  With all ALSA and snd modules unloaded, I
run as root:

# modprobe snd-ice1712
PCI: Found IRQ 10 for device 00:0b.0

	Now, if I run envy24control:

$ envy24control
using    --- input_channels: 0
         --- output_channels: 0
         --- pcm_output_channels: 8
         --- spdif in/out channels: 2

Eight outputs and no inputs!!  Yikes!  If I play sound, the meters go,
but no sounds come out.  Moreover, the "Analog Volume" tab is missing
and I don't know another way of setting analog mixer volume.

System details:
Linux 2.4.27 with lowlatency, ALSA 1.0.6a, tried with and without the
	"noapic acpi=off" boot parameters.
ASUS KT400 motherboard (A7V8X-X)
M-Audio Delta 44
Slackware 9.1 (but with lots of audio software installed aftermarket ::-)

Some help would be much appreciated!!

-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

----- End forwarded message -----


diff -u envy24control/envy24control.c envy24control.debugging/envy24control.c
--- envy24control/envy24control.c	2004-05-18 07:34:07.000000000 -0400
+++ envy24control.debugging/envy24control.c	2004-09-08 15:57:17.000000000 -0400
@@ -2076,6 +2076,12 @@
 		}
 	}
 
+	/* Print some eeprom information */
+	fprintf (stderr, "DEBUG: card_eeprom.subvendor = %x\n", card_eeprom.subvendor);
+	card_eeprom.subvendor = 0x121433d6;
+	fprintf (stderr, "DEBUG: adcIDs: %x, %x, %x, %x\n", card_eeprom.adcID[0], card_eeprom.adcID[1], card_eeprom.adcID[2], card_eeprom.adcID[3]);
+	fprintf (stderr, "DEBUG: dacIDs: %x, %x, %x, %x\n", card_eeprom.dacID[0], card_eeprom.dacID[1], card_eeprom.dacID[2], card_eeprom.dacID[3]);
+
 	/* Initialize code */
 	level_meters_init();
 	mixer_init();
diff -u envy24control/mixer.c envy24control.debugging/mixer.c
--- envy24control/mixer.c	2004-03-05 04:10:01.000000000 -0500
+++ envy24control.debugging/mixer.c	2004-09-08 16:15:39.000000000 -0400
@@ -181,6 +181,7 @@
 	memset (stream_is_active, 0, (MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS + MAX_INPUT_CHANNELS + MAX_SPDIF_CHANNELS) * sizeof(int));
 	snd_ctl_elem_value_set_name(val, MULTI_PLAYBACK_SWITCH);
 	nb_active_channels = 0;
+	fprintf (stderr, "mixer.c: pcm_output_channels = %d\n", pcm_output_channels);
 	for (i = 0; i < pcm_output_channels; i++) {
 		snd_ctl_elem_value_set_numid(val, 0);
 		snd_ctl_elem_value_set_index(val, i);
@@ -190,6 +191,7 @@
 		stream_is_active[i] = 1;
 		nb_active_channels++;
 	}
+	fprintf (stderr, "mixer.c: nb_active_channels = %d\n", nb_active_channels);
 	pcm_output_channels = nb_active_channels;
 	for (i = MAX_PCM_OUTPUT_CHANNELS; i < MAX_PCM_OUTPUT_CHANNELS + spdif_channels; i++) {
 		snd_ctl_elem_value_set_numid(val, 0);
@@ -200,6 +202,7 @@
 	}
 	snd_ctl_elem_value_set_name(val, HW_MULTI_CAPTURE_SWITCH);
 	nb_active_channels = 0;
+	fprintf (stderr, "mixer.c: input_channels = %d\n", input_channels);
 	for (i = 0; i < input_channels; i++) {
 		snd_ctl_elem_value_set_numid(val, 0);
 		snd_ctl_elem_value_set_index(val, i);
@@ -209,6 +212,7 @@
 		stream_is_active[i + MAX_PCM_OUTPUT_CHANNELS + MAX_SPDIF_CHANNELS] = 1;
 		nb_active_channels++;
 	}
+	fprintf (stderr, "mixer.c: nb_active_channels = %d\n", nb_active_channels);
 	input_channels = nb_active_channels;
 	snd_ctl_elem_value_set_name(val, IEC958_MULTI_CAPTURE_SWITCH);
 	for (i = 0; i < spdif_channels; i++) {


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
