From: Eric Anholt <eric@anholt.net>
Subject: Re: [RESEND PATCH] conf/cards: add VC4-HDMI card
Date: Thu, 16 Mar 2017 10:28:36 -0700
Message-ID: <87fuidcerf.fsf@eliezer.anholt.net>
References: <1488451773-22010-1-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0190448206052179828=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anholt.net (anholt.net [50.246.234.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 71BED267183
 for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2017 18:28:40 +0100 (CET)
In-Reply-To: <1488451773-22010-1-git-send-email-boris.brezillon@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

--===============0190448206052179828==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> Add a conf file for the VC4-HDMI sound card.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> Hi,
>
> Sorry for the noise, but I didn't send this patch to the alsa-lib
> maintainer on my first attempt.
>
> This patch is adding a card config file for the audio sound card whose
> driver has been submitted here [1] (not accepted yet).
>
> Since I am a total newbie to the alsa world, I'd like to get some
> feedback on this patch.
>
> Also, the card only supports 2 to 8 channels, and I wonder if we should
> add a plug element to support mono streams, and where this element
> should be added (after or before the iec958 element).
>
> Regards,
>
> Boris
>
> [1]https://www.spinics.net/lists/arm-kernel/msg565182.html

The kernel driver is getting merged now.

Tested-by: Eric Anholt <eric@anholt.net>

PulseAudio on the desktop seems to work fine.  aplay at the console
fails:

aplay -v  ~/LRMonoPhase4.wav
Playing WAVE '/home/anholt/LRMonoPhase4.wav' : Signed 16 bit Little Endian,=
 Rate 48000 Hz, Stereo
aplay: set_params:1297: Sample format non available
Available formats:
=2D IEC958_SUBFRAME_LE

but if you specify iec958 it works:

aplay -v -D iec958  ~/LRMonoPhase4.wav=20
Playing WAVE '/home/anholt/LRMonoPhase4.wav' : Signed 16 bit Little Endian,=
 Rate 48000 Hz, Stereo
IEC958 subframe conversion PCM (IEC958_SUBFRAME_LE)
Its setup is:
  stream       : PLAYBACK
...

but if you specify a mono file it doesn't:

anholt@rpi-open:/home/anholt% aplay -v -D iec958  /usr/share/sounds/alsa/Fr=
ont_Left.wav=20
Playing WAVE '/usr/share/sounds/alsa/Front_Left.wav' : Signed 16 bit Little=
 Endian, Rate 48000 Hz, Mono
aplay: set_params:1361: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
...

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAljKy0QACgkQtdYpNtH8
nui0axAAj+eiHtdterW2iJ80RfdafDbaL7D9lPw2fXi16foSRckRcbjhiTYjUvgJ
dUIdDieQIs1sYc/i/icrG4cL4Z+vK34G1fpJdk3ncRQ3WJ5xGCOx2STSSBI7enNW
Q3cPl4MBMxsob2+323D+zxsUkhjcke/Olz5z04aCSvtmr3vRKjpSmuahZ90Z5H/Q
HmrRYrNXlT8dGM7+w+caIfhgdWU/e/X0GJKMhWykGdkLakkk0YxN8uo7Qr6oKe5c
acrCT/ERg5kfSEKhBZ6zlrLFKvxfmOiqi3ND4iDhsWy6nTcm6ux4eVcXkEFzZZn5
qpbSKNalKEApzXjxSjSRE3A2C/KCSOPmHP/B5w6crxtm71mtkwMDvxWtUGqHM0B5
CL2WUpyl1Fqymz5QNKwQqh+jyPt8FX+j/AOyKpLLLefBSFV+CfiErxBBWsVq5nj0
k8srOVvOewczrb15MaDSPw+H1GeTw7COCjg0o112CDWZPGR8xOsUwjba7IDVUk8H
eOPjUvAlmcs4vGrw3S0a0JCnNWHsmFiTI0priWvqdlUzcVOxCnEL7zgob1WhirRj
8VAIBNjhkDSWwbYr1+/nznMs+MxmJmsaTNuX2Wf2MgFAgPmE4ZDh/oipUJPiCmDY
9GUjSkt/u1wzklUDUwgyIk1n726fzYTXGUGtUMbJ2/74CANBbXk=
=5n8B
-----END PGP SIGNATURE-----
--=-=-=--

--===============0190448206052179828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0190448206052179828==--
