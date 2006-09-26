From: Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>
Subject: Re: ALC260 (Re:  ALSA 1.0.13rc2 release)
Date: Tue, 26 Sep 2006 08:25:43 +0200
Message-ID: <1159251949.14557.20.camel@osmosis>
References: <200609252340.k8PNeaBN018198@auster.physics.adelaide.edu.au>
Reply-To: andrea.gozzi@linuxrevolution.eu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1721154603=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200609252340.k8PNeaBN018198@auster.physics.adelaide.edu.au>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1721154603==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-oFQy3/GtTlNBjVQdr9/d"


--=-oFQy3/GtTlNBjVQdr9/d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.



> Excellent.  By the way, do you need "disable_msi=3D1" in order for it to
> work correctly?

Without "disable_msi=3D1" things improved a little.
I now can hear both from the Line In jack and from the Mic jack if I set
"LINE1 pin mode" or "MIC1 pin mode" to "Headphones".
Still nothing from the S/PDIF or the speakers yet.

> Good work, I think we're starting to get somewhere.  I would have expecte=
d
> the headphones to still work if the "LINE1 pin mode" was set to "Headphon=
e"
> as well.  Did it?  In any case this result indicates that on your laptop =
the
> "Line out" jack is physically connected to the ALC260's LINE1 output.

It does now without "disable_msi=3D1".

>=20
> Now, what other physical jack sockets do you have on that laptop (besides
> "line out")?  Do you also have problems with them or do they "just work"
> when you load snd_intel_hda without options?

On the laptop I have a Microphone, Line in and S/PDIF sockets.
If the module  is loaded without options nothing works, you can only
hear a faint noise from the S/PDIF jack.

>=20
> > Attached to this e-mail are outputs of /proc/asound/card0/codec#0/1 and
> > aplay.

Sorry.

Codec: Realtek ALC260
Address: 0
Vendor Id: 0x10ec0260
Subsystem Id: 0x16311635
Revision Id: 0x100400
Default PCM: rates 0x560, bits 0x0e, types 0x1
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  PCM: rates 0x560, bits 0x0e, types 0x1
Node 0x03 [Audio Output] wcaps 0x211: Stereo Digital
  PCM: rates 0x560, bits 0x1e, types 0x1
Node 0x04 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x23, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00] [0x00 0x00] [0x00 0x00]
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 7
     0x12* 0x13 0x14 0x15 0x16 0x0f 0x10
Node 0x05 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=3D0x00, nsteps=3D0x23, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  PCM: rates 0x160, bits 0x06, types 0x1
  Connection: 8
     0x12* 0x13 0x14 0x15 0x16 0x07 0x0f 0x10
Node 0x06 [Audio Input] wcaps 0x100391: Stereo Digital
  PCM: rates 0x160, bits 0x1e, types 0x1
  Connection: 1
     0x19
Node 0x07 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=3D0x23, nsteps=3D0x41, stepsize=3D0x03, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3]
  Connection: 8
     0x12 0x13 0x14 0x15 0x16 0x17 0x0f 0x10
Node 0x08 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x02 0x07
Node 0x09 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=3D0x40, nsteps=3D0x40, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x02 0x07
Node 0x0a [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00] [0x00]
  Amp-Out caps: ofs=3D0x23, nsteps=3D0x41, stepsize=3D0x03, mute=3D0
  Amp-Out vals:  [0x00]
  Connection: 2
     0x02 0x07
Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0e [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x08* 0x09
Node 0x0f [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081003f: IN OUT HP EAPD Detect
  Pin Default 0x01014110: [Jack] Line Out at Ext Rear
    Conn =3D 1/8, Color =3D Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x08
Node 0x10 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x081003f: IN OUT HP EAPD Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x09
Node 0x11 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80]
  Pincap 0x0810: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0a
Node 0x12 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x01a19930: [Jack] Mic at Ext Rear
    Conn =3D 1/8, Color =3D Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x0b
Node 0x13 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0c
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x01813131: [Jack] Line In at Ext Rear
    Conn =3D 1/8, Color =3D Blue
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0d
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08133f: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0e
Node 0x16 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x99330132: [Fixed] CD at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
  Pin-ctls: 0x00:
Node 0x17 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x9983013e: [Fixed] Line In at Int ATAPI
    Conn =3D ATAPI, Color =3D Unknown
  Pin-ctls: 0x00:
Node 0x18 [Pin Complex] wcaps 0x400380: Mono Digital
  Pincap 0x0814: OUT Detect
  Pin Default 0x01454120: [Jack] SPDIF Out at Ext Rear
    Conn =3D Optical, Color =3D Green
  Pin-ctls: 0x00:
  Connection: 1
     0x03
Node 0x19 [Pin Complex] wcaps 0x400280: Mono Digital
  Pincap 0x0824: IN Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn =3D 1/8, Color =3D Black
  Pin-ctls: 0x00:
Node 0x1a [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x1b [Volume Knob Widget] wcaps 0x600080: Mono


[aplay -l]

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC260 Analog [ALC260 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


[aplay -L]

PCM list:
hw {
	@args.0 CARD
	@args.1 DEV
	@args.2 SUBDEV
	@args.CARD {
		type string
		default {
			@func getenv
			vars {
				0 ALSA_PCM_CARD
				1 ALSA_CARD
			}
			default {
				@func refer
				name 'defaults.pcm.card'
			}
		}
	}
	@args.DEV {
		type integer
		default {
			@func igetenv
			vars {
				0 ALSA_PCM_DEVICE
			}
			default {
				@func refer
				name 'defaults.pcm.device'
			}
		}
	}
	@args.SUBDEV {
		type integer
		default {
			@func refer
			name 'defaults.pcm.subdevice'
		}
	}
	type hw
	card $CARD
	device $DEV
	subdevice $SUBDEV
}
plughw {
	@args.0 CARD
	@args.1 DEV
	@args.2 SUBDEV
	@args.CARD {
		type string
		default {
			@func getenv
			vars {
				0 ALSA_PCM_CARD
				1 ALSA_CARD
			}
			default {
				@func refer
				name 'defaults.pcm.card'
			}
		}
	}
	@args.DEV {
		type integer
		default {
			@func igetenv
			vars {
				0 ALSA_PCM_DEVICE
			}
			default {
				@func refer
				name 'defaults.pcm.device'
			}
		}
	}
	@args.SUBDEV {
		type integer
		default {
			@func refer
			name 'defaults.pcm.subdevice'
		}
	}
	type plug
	slave.pcm {
		type hw
		card $CARD
		device $DEV
		subdevice $SUBDEV
	}
}
plug {
	@args.0 SLAVE
	@args.SLAVE {
		type string
	}
	type plug
	slave.pcm $SLAVE
}
shm {
	@args.0 SOCKET
	@args.1 PCM
	@args.SOCKET {
		type string
	}
	@args.PCM {
		type string
	}
	type shm
	server $SOCKET
	pcm $PCM
}
tee {
	@args.0 SLAVE
	@args.1 FILE
	@args.2 FORMAT
	@args.SLAVE {
		type string
	}
	@args.FILE {
		type string
	}
	@args.FORMAT {
		type string
		default raw
	}
	type file
	slave.pcm $SLAVE
	file $FILE
	format $FORMAT
}
file {
	@args.0 FILE
	@args.1 FORMAT
	@args.FILE {
		type string
	}
	@args.FORMAT {
		type string
		default raw
	}
	type file
	slave.pcm null
	file $FILE
	format $FORMAT
}
null {
	type null
}
cards 'cards.pcm'
front 'cards.pcm.front'
rear 'cards.pcm.rear'
center_lfe 'cards.pcm.center_lfe'
side 'cards.pcm.side'
surround40 'cards.pcm.surround40'
surround41 'cards.pcm.surround41'
surround50 'cards.pcm.surround50'
surround51 'cards.pcm.surround51'
surround71 'cards.pcm.surround71'
iec958 'cards.pcm.iec958'
spdif 'cards.pcm.iec958'
modem 'cards.pcm.modem'
phoneline 'cards.pcm.phoneline'
default 'cards.pcm.default'
dmix 'cards.pcm.dmix'
dsnoop 'cards.pcm.dsnoop'



> I think we're getting there.  For my reference could you please remind me=
 of
> the make/model of the laptop we're dealing with?

It's a Packard Bell EasyNote V7900.


Thanks again.

Andrea

--=-oFQy3/GtTlNBjVQdr9/d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFGMfnoIXRn+fZcV0RAutbAKCXOZzerxvNQpFC5Pofk/y47YPk6ACeMpNp
qIFprJc73h00qtgDafstVNI=
=yg+L
-----END PGP SIGNATURE-----

--=-oFQy3/GtTlNBjVQdr9/d--



--===============1721154603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1721154603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1721154603==--
