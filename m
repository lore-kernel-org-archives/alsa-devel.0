From: Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>
Subject: Re: :  ALC260 (Re:  ALSA 1.0.13rc2 release)
Date: Mon, 25 Sep 2006 20:06:22 +0200
Message-ID: <1159207582.14557.6.camel@osmosis>
References: <200609250128.k8P1SLth010255@auster.physics.adelaide.edu.au>
Reply-To: andrea.gozzi@linuxrevolution.eu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1726611375=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200609250128.k8P1SLth010255@auster.physics.adelaide.edu.au>
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


--===============1726611375==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-KmXTKVCeNVW1RmqLgXWL"


--=-KmXTKVCeNVW1RmqLgXWL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I found this on the PB site, I don't know if it could help:



> Description
> The ALC260 2-Channel High Definition Audio Codec with UAA (Universal
> Audio Architecture) is designed for commercial desktop and notebook PC
> systems and features a 24-bit two-channel DAC and two stereo 20-bit
> ADCs. The codec incorporates proprietary converter technology to
> achieve 95dB sound quality; easily meeting PC2001 requirements and
> also bringing PC sound quality closer to consumer electronic devices.
>=20
> The ALC260 provides two output channels, along with flexible mixing,
> mute, and fine gain control functions to provide a complete integrated
> audio solution for PCs. The DAC (with a highest sampling rate of 192
> kHz) and Realtek proprietary hardware content protection are
> applicable for DVD-Audio; previously only implemented in high-end
> consumer electronics but now achieved by PCs equipped with the ALC260.
> The ALC260 provides high-quality audio using S/PDIF to output analogue
> data, or for multiple-source recording applications.
>=20
> Realtek's proprietary impedance sensing and jack detect techniques
> allow device loads on inputs and outputs to be auto-detected. All
> analogue IOs are input and output capable. Headphone amplifiers are
> also integrated at each analogue output. All analogue IOs can be
> re-tasked according to user's definitions, or automatically switched
> to suit the connecting device (Universal Audio Jack).
>=20
> The ALC260 supports 32-bit S/PDIF input and output functions, with a
> sampling rate of up to 96 kHz, offering easy connection of PCs to high
> quality consumer electronic products such as AC-3 decoders/speakers,
> and mini disk devices.
>=20
> The ALC260 supports host/soft audio from the Intel ICH6 chipset, as
> well as from any other HDA compatible audio controller. With power
> management setting, and Realtek's unique microphone application
> (AEC/Beam Forming/Noise Suppression) and reliable driver support, the
> ALC260 is the ideal choice for Commercial Desktop and Notebook PC
> users.=20
> Features
>       * Single-chip multi-bit Sigma-Delta converters with high S/N
>         ratio
>       * 1 stereo DAC supports 16/20/24-bit PCM format with 44.1 kHz /
>         48 kHz / 96 kHz / 192 kHz sample rate
>       * 2 stereo ADCs support 16/20-bit PCM format with 44.1 kHz / 48
>         kHz / 96 kHz sample rate
>       * Applicable for 2-Channel 192 kHz DVD-Audio solutions
>       * Line-Out, HP-Out, Line1, Line2, Mic1, and Mic2 are stereo
>         input and output re-tasking
>       * Mono line level output to subwoofer speaker for 2.1 channel
>         applications
>       * High-quality differential CD analogue input
>       * External PC beep input is applicable, and internal beep
>         generator is integrated
>       * Power-Off CD mode supported
>       * Power management and enhanced power saving features
>       * Power support: Digital 3.3 V; analogue 3.3 V / 5.0 V
>       * Selectable 2.5 V / 3.75 V VREFOUT
>       * Two jack detection pins (each designed to detect 4 jacks)
>       * Supports 444.1 kHz / 48 kHz / 96 kHz / 192 kHz S/PDIF output
>       * Supports 44.1 kHz / 48 kHz / 96 kHz S/PDIF input
>       * 48-pin LQFP packages (lead (Pb)-free package also available)
>       * Supports external volume knob control
>       * Reserve analogue mixer architecture is backwards compatible
>         with AC'97
>       * -64 dB ~ +30 dB with 1 dB mixer gain for fine volume control
>       * Impedance sensing capability for each re-tasking jack
>       * Built-in headphone amplifier for each re-tasking jack
>       * Supports GPIOs (General Purpose Input/Output) for customized
>         applications
>       * Hardware copyright protection for DVD-Audio
>       * Meets Microsoft WHQL/WLP 2.0 audio requirements
>       * EAX 1.0 & 2.0 compatible
>       * Direct Sound 3D compatible
>       * A3D compatible
>       * I3DL2 compatible
>       * HRTF 3D Positional Audio
>       * Emulation of 26 sound environments to enhance gaming
>         experience
>       * 10-band Software Equalizer
>       * Voice Cancellation and Key Shifting in Karaoke mode
>       * Realtek Media Player
>       * Enhanced Configuration Panel and device sensing wizard to
>         improve user experience
>       * Content Copy Protection for S/PDIF interface
>       * Power Management setting
>       * Microphone Acoustic Echo Cancellation (AEC) and Beam Forming
>         (BF) technology for voice application
>       * Mono/Stereo Microphone Noise Suppression





On Mon, 2006-09-25 at 10:58 +0930, Jonathan Woithe wrote:
> Hi Andrea
>=20
> > I'm sorry to bother you again but every time I try to set an option on
> > snd-hda-intel I get this in syslog:
> >=20
> > Sep 23 22:31:33 stariez kernel:
> > ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/../../alsa-kernel/pci/=
hda/patch_realtek.c:4059: hda_codec: Unknown model for ALC260, trying auto-=
probe from BIOS...
> > Sep 23 22:31:33 stariez kernel:
> > ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2150:
> > autoconfig: line_outs=3D1 (0xf/0x0/0x0/0x0/0x0)
> > Sep 23 22:31:33 stariez kernel:
> > ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2154:
> > speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
> > Sep 23 22:31:33 stariez kernel:
> > ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2156:
> > hp=3D0x0, dig_out=3D0x18, din_in=3D0x0
> > Sep 23 22:31:33 stariez kernel:
> > ALSA /usr/src/alsa/alsa-driver-1.0.13rc2/pci/hda/hda_codec.c:2164:
> > inputs: mic=3D0x12, fmic=3D0x0, line=3D0x14, fline=3D0x0, cd=3D0x16, au=
x=3D0x0
> >=20
> > Is it normal?
>=20
> Which options are you trying?  What command line(s) are you using?  If
> you're trying to use the "model=3Dtest" option to modprobe, have you firs=
t
> configured ALSA with the "--enable-debug" option and recompiled/reinstall=
ed?
> If testing alsa from within a standard kernel tree there's a similarly na=
med
> configuration option in the alsa section of "make menuconfig".
>=20
> As Takashi said, the "test" model is only available if debugging has been
> enabled.
>=20
> Regards
>   jonathan

--=20
Andrea Gozzi <andrea.gozzi@linuxrevolution.eu>

--=-KmXTKVCeNVW1RmqLgXWL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFGBqeoIXRn+fZcV0RAsxxAJwIAxWs7xAW5b/axRpFkTGDNDj8MgCeIlbp
xj9Tjrw1VtS9B/5XhXdMwok=
=5RGB
-----END PGP SIGNATURE-----

--=-KmXTKVCeNVW1RmqLgXWL--



--===============1726611375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1726611375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1726611375==--
