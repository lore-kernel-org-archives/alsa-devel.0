From: Dominik 'Aeneas' Schnitzer <dominik@schnitzer.at>
Subject: [PATCH] EMU10K1.conf
Date: Sat, 27 Dec 2003 01:31:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1072485112.2477.35.camel@blackhole>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-oo1Hya4uJ8OfTneR8r4e"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-oo1Hya4uJ8OfTneR8r4e
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I finally got my emu10k1 soundcard working with full 5.1 surround :-)

It took me 2 days, getting alsa to know and sound working properly. I
finally found out that /usr/share/alsa/cards/EMU10K1.conf was b0rked and
modified it so everything now works properly. Things which prevented it
from working properly were:

 - Rear/Center&&LFE Volume Controls in the config file were set to 0 and
locked!..

 - surround51 was statically bound to the non-digital output and locked
(to the analogue output), so there was no way to get surround sound on
my digital-out.

 - other volume controls were locked too, I had a look at Audigy.conf
and reduced the locked controls to the minimum required.


The patch attached for /usr/share/alsa/cards/EMU10K1.conf is actually
very trivial and a cleanup of the old file, it would be cool if you'd
apply the patch to the ALSA config file in CVS, I'm sure it would help a
lot of people which have no rear sound with the emu10k1.


/me now leans back and enjoys alsa and Lord Of The Rings II Extended
Version in _FULL_ Digital Dolby 5.1 :))))

best wishes,
dominik.
-- 
Dominik 'Aeneas' Schnitzer <dominik@schnitzer.at>
http://www.schnitzer.at/dominik/ - Update 03/08/31: Birthday Party

PGP Fingerprint: E839 B9EA F518 899D AA35  BB67 0DBF 7AB2 5FE6 525A
PGP Public Key: http://www.schnitzer.at/dominik/public.key

--=-oo1Hya4uJ8OfTneR8r4e
Content-Disposition: attachment; filename=EMU10K1.conf
Content-Type: text/plain; name=EMU10K1.conf; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

#
# Configuration for the EMU10K1 chip
#

<confdir:pcm/front.conf>

EMU10K1.pcm.front.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hw
	card $CARD
	device 0
}

<confdir:pcm/rear.conf>

EMU10K1.pcm.rear.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hooks
	slave.pcm {
		type hw
		card $CARD
		device 0
	}
	hooks.0 {
		type ctl_elems
		hook_args [
			{
				name "EMU10K1 PCM Send Volume"
				index { @func private_pcm_subdevice }
				lock true
				value [ 0 0 0 0 0 0 255 0 0 0 0 255 ]
			}
		]
	}
}	

<confdir:pcm/center_lfe.conf>

EMU10K1.pcm.center_lfe.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hooks
	slave.pcm {
		type hw
		card $CARD
		device 0
	}
	hooks.0 {
		type ctl_elems
		hook_args [
			{
				name "EMU10K1 PCM Send Volume"
				index { @func private_pcm_subdevice }
				lock true
				value [ 0 0 0 0 255 0 0 0 0 255 0 0 ]
			}
			{
				name "EMU10K1 PCM Send Routing"
				index { @func private_pcm_subdevice }
				lock true
				value [ 0 1 2 3 6 7 0 1 6 7 0 1 ]
			}
		]
	}
}	

<confdir:pcm/surround40.conf>

EMU10K1.pcm.surround40.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type multi
	slaves [
		{
			pcm {
				@func concat
				strings [
					"cards.EMU10K1.pcm.front.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.EMU10K1.pcm.rear.0:CARD=" $CARD
				]
			}
			channels 2
		}
	]
	bindings [
		{ slave 0 channel 0 }
		{ slave 0 channel 1 }
		{ slave 1 channel 0 }
		{ slave 1 channel 1 }
	]
}

<confdir:pcm/surround41.conf>
<confdir:pcm/surround50.conf>
<confdir:pcm/surround51.conf>

EMU10K1.pcm.surround51.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type multi
	slaves [
		{
			pcm {
				@func concat
				strings [
					"cards.EMU10K1.pcm.front.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.EMU10K1.pcm.rear.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.EMU10K1.pcm.center_lfe.0:CARD=" $CARD
				]
			}
			channels 2
		}
	]
	bindings [
		{ slave 0 channel 0 }
		{ slave 0 channel 1 }
		{ slave 1 channel 0 }
		{ slave 1 channel 1 }
		{ slave 2 channel 0 }
		{ slave 2 channel 1 }
	]
}

<confdir:pcm/iec958.conf>

EMU10K1.pcm.iec958.0 {
	@args [ CARD AES0 AES1 AES2 AES3 ]
	@args.CARD {
		type string
	}
	@args.AES0 {
		type integer
	}
	@args.AES1 {
		type integer
	}
	@args.AES2 {
		type integer
	}
	@args.AES3 {
		type integer
	}
	type hooks
	slave.pcm {
		type hw
		card $CARD
		device 3
	}
	hooks.0 {
		type ctl_elems
		hook_args [
			{
				name "IEC958 Playback Default"
				lock true
				preserve true
				value [ $AES0 $AES1 $AES2 $AES3 ]
			}
			{
				name "IEC958 Optical Raw Playback Switch"
				lock true
				preserve true
				value [ 1 1 ]
			}
			{
				name "SB Live Analog/Digital Output Jack"
				lock true
				preserve true
				value 1
			}
		]
	}
}

--=-oo1Hya4uJ8OfTneR8r4e
Content-Disposition: attachment; filename=EMU10K1-conf.patch
Content-Type: text/x-patch; name=EMU10K1-conf.patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

--- EMU10K1.conf.orig	2003-12-25 23:57:56.000000000 +0100
+++ EMU10K1.conf	2003-12-27 01:02:00.000000000 +0100
@@ -12,7 +12,7 @@
 	type hw
 	card $CARD
 	device 0
-}	
+}
 
 <confdir:pcm/rear.conf>
 
@@ -31,12 +31,6 @@
 		type ctl_elems
 		hook_args [
 			{
-				name "Wave Surround Playback Volume"
-				preserve true
-				lock true
-				value [ 0 0 ]
-			}
-			{
 				name "EMU10K1 PCM Send Volume"
 				index { @func private_pcm_subdevice }
 				lock true
@@ -63,38 +57,6 @@
 		type ctl_elems
 		hook_args [
 			{
-				name "Wave Center Playback Volume"
-				preserve true
-				lock true
-				value 0
-			}
-			{
-				name "Wave LFE Playback Volume"
-				preserve true
-				lock true
-				value 0
-			}
-			{
-				name "Headphone Center Playback Switch"
-				index 1
-				preserve true
-				lock true
-				value true
-			}
-			{
-				name "Headphone LFE Playback Switch"
-				index 1
-				preserve true
-				lock true
-				value true
-			}
-			{
-				name "SB Live Analog/Digital Output Jack"
-				preserve true
-				lock true
-				value 0
-			}
-			{
 				name "EMU10K1 PCM Send Volume"
 				index { @func private_pcm_subdevice }
 				lock true

--=-oo1Hya4uJ8OfTneR8r4e--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
