From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: AC3 passthrough on Audigy and Audigy2...now Works!!!
Date: Thu, 28 Aug 2003 21:37:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4E6802.9010609@superbug.demon.co.uk>
References: <200308260847.KAA24438@www3.pobox.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040907090709090707000500"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308260847.KAA24438@www3.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: p z oooo <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040907090709090707000500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

p z oooo wrote:
> Hi,
> 
> This is taken from oss driver. It is not tested (I don't own 
> receiver). Can someone try it, maybe this works, I don't know.
> 
> Audigy.conf - copy this to /usr/share/alsa/cards/ and overwrite old 
> one (make backup).
> 
> emu10k1.h.patch - patch for file alsa-driver/alsa-
> kernel/include/emu10k1.h
> 
> emufx.c.patch - patch for file alsa-driver/alsa-
> kernel/pci/emu10k1/emufx.c
>

Do NOT comment out the following lines.

> If this doesn't work try to comment out lines
> A_OP(icode, &ptr, iSKIP, A_GPR_COND, A_GPR_COND, A_GPR(gpr - 2), 
> A_C_00000001);
> A_OP(icode, &ptr, iACC3, A_GPR(tmp + 2), A_C_00000000, A_C_00010000, 
> A_GPR(tmp + 2));
> 
> And if this doesn't work too, then delete this mail.
> 
> Peter Zubaj
> 
Your patch works up to a point. It will only work on the Audigy, and not
the Audigy2.
The Audigy and Audigy2 do things slighly differently.
The L and R channels are reversed on the Audigy2, so I have compensated
for this by using a different routing in Audigy2.conf.

If you add my patches, this will work with both the Audigy and Audigy2. :-)

emu10k1.c.patch - patch for file
alsa-driver/alsa-kernel/pci/emu10k1/emu10k1.c  (So that is looks for
Audigy2.conf)

Audigy2.conf - copy this to /usr/share/alsa/cards/  (It is a new file)

Summary: -
If one combines pzad's patch with my own, we have AC3 passthru working
on all SB cards. SB Live (Worked before), SB Audigy (with pzas's patch)
and SB Audigy2 (with my patch).

Please check these into the alsa-kernel cvs.

Cheers
James



--------------040907090709090707000500
Content-Type: text/plain;
 name="Audigy2.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Audigy2.conf"

#
# Configuration for the Audigy2 chip
#

<confdir:pcm/front.conf>

Audigy2.pcm.front.0 {
	@args [ CARD  ]
	@args.CARD {
		type string
	}
	type hw
	card $CARD
	device 0
}	

<confdir:pcm/rear.conf>

Audigy2.pcm.rear.0 {
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
				name "Wave Surround Playback Volume"
				preserve true
				lock true
				value [ 0 0 ]
			}
			{
				name "EMU10K1 PCM Send Volume"
				index { @func private_pcm_subdevice }
				lock true
				value [ 0 0 0 0 0 0 0 0  0 0 255 0 0 0 0 0  0 0 0 255 0 0 0 0 ]
			}
		]
	}
}	

<confdir:pcm/center_lfe.conf>

Audigy2.pcm.center_lfe.0 {
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
				name "Wave Center Playback Volume"
				preserve true
				lock true
				value 0
			}
			{
				name "Wave LFE Playback Volume"
				preserve true
				lock true
				value 0
			}
			{
				name "EMU10K1 PCM Send Volume"
				index { @func private_pcm_subdevice }
				lock true
				value [ 0 0 0 0 0 0 0 0  255 0 0 0 0 0 0 0  0 255 0 0 0 0 0 0 ]
			}
			{
				name "EMU10K1 PCM Send Routing"
				index { @func private_pcm_subdevice }
				lock true
				value [ 0 1 2 3 0 0 0 0  6 7 0 1 0 0 0 0  6 7 0 1 0 0 0 0 ]
			}
		]
	}
}	

<confdir:pcm/surround40.conf>

Audigy2.pcm.surround40.0 {
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
					"cards.Audigy2.pcm.front.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.Audigy2.pcm.rear.0:CARD=" $CARD
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

<confdir:pcm/surround51.conf>

Audigy2.pcm.surround51.0 {
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
					"cards.Audigy2.pcm.front.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.Audigy2.pcm.rear.0:CARD=" $CARD
				]
			}
			channels 2
		}
		{
			pcm {
				@func concat
				strings [
					"cards.Audigy2.pcm.center_lfe.0:CARD=" $CARD
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

Audigy2.pcm.iec958.0 {
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
		device 0
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
				name "EMU10K1 PCM Send Volume"
				index { @func private_pcm_subdevice }
				lock true
				value [ 0 0 0 0 0 0 0 0  0 255 0 0 0 0 0 0  255 0 0 0 0 0 0 0 ]
			}
			{
				name "EMU10K1 PCM Send Routing"
				index { @func private_pcm_subdevice }
				lock true
				value [ 0 1 2 3 0 0 0 0  20 21 0 1 0 0 0 0   20 21 0 1 0 0 0 0 ]
			}
			{
				name "Audigy Analog/Digital Output Jack"
				lock true
				preserve true
				value 1
			}
		]
	}
}

--------------040907090709090707000500
Content-Type: text/plain;
 name="emu10k1.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="emu10k1.c.patch"

--- emu10k1.c.org	2003-08-28 20:54:29.670139952 +0100
+++ emu10k1.c	2003-08-28 21:09:00.942686392 +0100
@@ -170,7 +170,10 @@
 	}
 #endif
  
-	if (emu->audigy) {
+	if (emu->audigy && (emu->revision == 4) ) {
+		strcpy(card->driver, "Audigy2");
+		strcpy(card->shortname, "Sound Blaster Audigy2");
+	} else if (emu->audigy) {
 		strcpy(card->driver, "Audigy");
 		strcpy(card->shortname, "Sound Blaster Audigy");
 	} else if (emu->APS) {

--------------040907090709090707000500--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
