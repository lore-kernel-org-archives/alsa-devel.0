From: "Tais M. Hansen" <tais.hansen@osd.dk>
Subject: Re: Re: [Alsa-user] Upgrade problems -addendum
Date: Thu, 23 Jan 2003 12:15:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301231215.29675.tais.hansen@osd.dk>
References: <200301221234.33054.tais.hansen@osd.dk> <200301230135.58325.tais.hansen@osd.dk> <s5hfzrkyyi3.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzrkyyi3.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 23 January 2003 11:03, Takashi Iwai wrote:
> ok, the attached is the third trial.
> please appply it solely without the preivous patches.

I'm assuming the very first via8233a-fix.dif is still supposed to be appl=
ied.=20
(won't work without it anyway)

> hope this works better...

Well... Ogg123 freezes the same way as with test1. Artsd no longer fails =
with=20
"cpu overload", but it's constantly busy and can't play sound. There's=20
nothing to see in syslog but there's suddenly a bunch of output in the de=
bug=20
log.

This is ogg123:

Jan 23 12:05:25 proficio kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123:=20
Unexpected hw_pointer value (stream =3D 0, delta: -1024, max jitter =3D 4=
096):=20
wrong interrupt acknowledge?
Jan 23 12:05:35 proficio last message repeated 429 times
Jan 23 12:05:35 proficio kernel: ALSA ../alsa-kernel/core/pcm_lib.c:2117:=
=20
playback write error (DMA or IRQ trouble?)

And this is artsd:

Jan 23 12:06:31 proficio kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123:=20
Unexpected hw_pointer value (stream =3D 0, delta: -1024, max jitter =3D 8=
192):=20
wrong interrupt acknowledge?
Jan 23 12:06:41 proficio last message repeated 206 times

Aplay is able to play a wav-file though but it also generates errors in t=
he=20
debug log:

Jan 23 12:08:16 proficio kernel: ALSA ../alsa-kernel/core/pcm_lib.c:123:=20
Unexpected hw_pointer value (stream =3D 0, delta: -3386, max jitter =3D 1=
1025):=20
wrong interrupt acknowledge?

Aplay also threw the usual in syslog once:

Jan 23 12:08:18 proficio kernel: ALSA ../alsa-kernel/pci/via82xx.c:601:=20
invalid via82xx_cur_ptr, using last valid pointer

- --=20
Regards,
Tais M. Hansen
OSD

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQIVAwUBPi/O0IIvLOJqwYc4AQIpHQ//SToDIhB49e/UlJYOqTkTrya/25Vuvqju
dYIhobeCn1bm8Lbun3Eb75rBt6pWqf/6g3YhfxdYwVYi5HD9YrX9SaqkOFdEFxiZ
KUR0Vop7Nyu7Y379w7BKNZILE6ApvgKoSSsYXiR4EMI3mu5Rst+fAbhvyKuL1+u0
eggkgbZgffmMjZFtm0yyPywBmQxUz1INknIhs+/AXpTpbfHFxIEtaZGwSuEpK2DO
is33gNvMIrAGmaXWoC3xNLLcDAOffcWVY3Cjx7KJAi8+UOAiJ15LCORaO41uv3r9
MvycX3KpDvMb5u+/RH00fLutTY8fQKiSwjRCRJWz3QBLOPJw18mIUz55T4i7VSoO
x00fy+73xx2IePd9tT8mGZRr+leH19tnXP44+5QeVEj3GuOd85fw4nFkf+01z+9X
m0DSS44/+UUG/XDQjl3SBeD0ad3alqOm748Ef0mHnmy058VF+Vh65s6B7bUzq/bf
p59x0Ea1Tk9fph8+vyhJfvTLBMzywGhhNrOUuijUwjAkvojsMyB879ay838xkL0c
lRW7WmvmB8HSoFCvJmjXHuHCoxP9GrRw0L3V4zj/OmuD8qM+SYUBhkdmLjEjzgsh
e9RfEftSNDZSR+bdXE3nChiGWqeDCJXvYdZVcM/kpUfnZbRTZOdKdN2mqZLBvm6D
dXEZcr9VgfA=3D
=3DhpJK
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
