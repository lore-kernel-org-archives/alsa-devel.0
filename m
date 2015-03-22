From: "W. Trevor King" <wking@tremily.us>
Subject: Missing beep controls for Via HDA codec
	(snd_hda_codec_via)
Date: Sun, 22 Mar 2015 00:54:49 -0700
Message-ID: <20150322075449.GT18986@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4982844060306823509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from resqmta-ch2-12v.sys.comcast.net
 (resqmta-ch2-12v.sys.comcast.net [69.252.207.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E75C2606DA
 for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2015 08:54:53 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org


--===============4982844060306823509==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LXqH7sWsIplhrbjF"
Content-Disposition: inline


--LXqH7sWsIplhrbjF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

My VT1802 chip has a beep-generating node:

  $ cat /proc/asound/card1/codec#0
  Codec: VIA VT1802
  ...
  Vendor Id: 0x11068446
  Subsystem Id: 0x15587410
  Revision Id: 0x100000
  ...
  Node 0x22 [Beep Generator Widget] wcaps 0x70040c: Mono Amp-Out
    Amp-Out caps: ofs=3D0x0a, nsteps=3D0x12, stepsize=3D0x05, mute=3D1
    Amp-Out vals:  [0x0a]
    Power states:  D0 D1 D2 D3
    Power: setting=3DD0, actual=3DD0
  ...

But I'm missing the:

  Control: name=3D...

entries that I think I need to manage this widget from alsamixer.  For
example, sambrian posts codec output for a CX20561 chip which has [1]:

  Node 0x13 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
    Control: name=3D"Beep Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D1, dir=3DOut, idx=3D0, ofs=3D0
    Control: name=3D"Beep Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D1, dir=3DOut, idx=3D0, ofs=3D0
    Amp-Out caps: ofs=3D0x03, nsteps=3D0x03, stepsize=3D0x17, mute=3D0
    Amp-Out vals: [0x00]

I can patch with something like this:

  diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
  index 3de6d3d..85a0c08 100644
  --- a/sound/pci/hda/patch_via.c
  +++ b/sound/pci/hda/patch_via.c
  @@ -1520,8 +1520,10 @@ static int patch_vt2002P(struct hda_codec *codec)
          spec->gen.mixer_nid =3D 0x21;
          override_mic_boost(codec, 0x2b, 0, 3, 40);
          override_mic_boost(codec, 0x29, 0, 3, 40);
  -       if (spec->codec_type =3D=3D VT1802)
  +       if (spec->codec_type =3D=3D VT1802) {
  +               spec->gen.beep_nid =3D 0x22;
                  fix_vt1802_connections(codec);
  +       }
          add_secret_dac_path(codec);

          snd_hda_pick_fixup(codec, NULL, vt2002p_fixups, via_fixups);

to get a dmesg entry like:

  input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card1=
/hdaudioC1D0/input15

but that doesn't add the beep controls.  Looking at patch_analog.c,
patch_conexant.c, and patch_realtek.c for inspiration, I expect we'll
need an HDA_CODEC_MUTE_BEEP(_MONO) entry, and possibly an
HDA_CODEC_VOLUME(_MONO) entry, but I'm not sure if these should be
mono or not, or if they should be inputs (following patch_realtek.c)
or outputs (following patch_analog.c and patch_conexant.c).  I've
filled out Via's datasheet-request form [2], but I don't know how
likely that is to be accepted.

Does anyone have a VT1802 datasheet that they're allowed to share (or
some free time to fill in Via beep support on their own)?  Or am I
barking up the wrong tree?  My only previous experience with this
code-base was a beep-tweak for a previous box's Realtek chip [3], but
I love my beeps and am happy to poke around with a datasheet until I
get this working ;).  Maybe folks with more experience can just guess
the right code without needing to see specs for the VT1802?

Cheers,
Trevor

[1]: http://forums.fedoraforum.org/archive/index.php/t-265822.html
[2]: http://www.via.com.tw/en/support/contact_us/
[3]: http://thread.gmane.org/gmane.linux.alsa.devel/121300

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--LXqH7sWsIplhrbjF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVDnVGAAoJEG8/JgBt8ol8vzYP/1f64z59gsWSPhWYFWVtIDPX
w1v3tXv0ae8+Co/Y2UpkOThhrjNUZKX0MRIJM3UWE5X5PdxmoErOrwuoxWJYA6jJ
QmZwHuuEDUSbuo5WI9WA4IUVQrRVnQrAXFHi8DBCpjRj7fnkCQkEVFNJ7L8bWjlU
rHSU+8vQlEvvfZYBzB+UIKK6J1I3/ec5qM/qzDrQth2ZbDRrL2ttmZLayA1ggyyr
jShNEpBEpKPAEpskACc6cbnQyE7K5c7ovIhbwH4NEl6jUjNEweFHtUHZMT+QmLTu
gWMJdfFCoPoRuBqJ8S2kJHfUNjzbUfV+Q0xnoPbeSQyC+vHCgl5HkXL2yqAgNaTt
zSG4FzPDMt1AVcAoOhptI1G4b/qg4UDRCNhcYCWqhoczLOx0ed6CwpJsEydt5a6M
fnvpnMLddAnGNTDeE7eV4ozOxPARA3hC9ztN+6PmOQLqMwcPsSzSNm5cHL0k5uBx
lgF/BwX4+KgiKuVYjyE2gDERV34PrEu6NndBUROMut3XahmcWLXZgnH7Piue/xej
PVRH0KSES6/J580FwGyeKqQJJdZOzB2hRk8bsJEQBHe+y2wlfOUoyfrruBr0HIco
dY9mep+M5XF3v1MBVzroY5pckG2G6nkBXW/aAcewBtAphLCLou9uANUlJa6nSdM6
oTusVXqekjbfFAY3t/MQ
=XQlk
-----END PGP SIGNATURE-----

--LXqH7sWsIplhrbjF--

--===============4982844060306823509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4982844060306823509==--
