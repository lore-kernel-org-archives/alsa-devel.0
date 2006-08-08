From: Jochen Voss <voss@seehuhn.de>
Subject: Re: GPIO connections for the M-Audio Revolution 5.1
Date: Tue, 8 Aug 2006 17:30:25 +0100
Message-ID: <20060808163025.GA12347@tarte.seehuhn.de>
References: <20060807203113.GA5305@tarte.seehuhn.de>
	<s5hbqqvr0i6.wl%tiwai@suse.de> <20060808104015.GA20149@seehuhn.de>
	<s5h4pwnqydd.wl%tiwai@suse.de>
	<20060808111850.GB2922@localhost.localdomain>
	<s5hzmefpj2o.wl%tiwai@suse.de>
	<20060808114033.GA3784@tarte.seehuhn.de>
	<s5hpsfbpe9t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1436055541=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hpsfbpe9t.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============1436055541==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Tue, Aug 08, 2006 at 03:07:10PM +0200, Takashi Iwai wrote:
> My rough guess is 3-wire control, using the same CLK (0x02) and CIN
> (0x04) with a different CS (0x80).  Or possibly CS0 (0x10) or CS2
> (0x40) is used instead.  Currently the driver resets all CS0-2 bits
> for a single AK4358 chip, but only one of them should be needed.

I might have been confused when I wrote about GPIO pins before.

1) I claimed that GPIO0 is connected to the PCI bus.
This was wrong, I confused it with the address line next to it.
I apologise for the confusion.

2) From visual inspection I would think that only GPIO0, GPIO2, GPIO5,
GPIO6, GPIO7 and GPIO22 are connected.  The others are connected to
dark areas which I take to be the ground.  But this might be wrong,
too, since ...

3) I played around with the code in alsa-kernel/pci/ice1724/revo.c and
more specifically with the akm_revo51_priv structure there.  Originally
it is initialised as

static struct snd_ak4xxx_private akm_revo51_priv __devinitdata =3D {
	.caddr =3D 2,
	.cif =3D 0,
	.data_mask =3D VT1724_REVO_CDOUT,
	.clk_mask =3D VT1724_REVO_CCLK,
	.cs_mask =3D VT1724_REVO_CS0 | VT1724_REVO_CS1 | VT1724_REVO_CS2,
	.cs_addr =3D 0,
	.cs_none =3D VT1724_REVO_CS0 | VT1724_REVO_CS1 | VT1724_REVO_CS2,
	.add_flags =3D VT1724_REVO_CCLK, /* high at init */
	.mask_flags =3D 0,
};

I tried several combinations of CS0, CS1 and CS2 in the .cs_addr field.
Results:

    .cs_addr  | result
 ------------------------------------------------------
       0      | playback: ok, capture: no
      CS1     | playback: ok, capture: works!
      CS2     | playback: ok, capture: no
      CS1|CS2 | playback: ok, capture: works!
      CS0     | playback: very noisy, capture: no
      CS0|CS1 | playback: very noisy, capture: works!

where

    "capture: works!" means, that arecord no longer returns 0 bytes.
    I did not yet try to record something meaningful, but without a
    microphone connected I get something which looks like line noise
    to me.

    "playback: very noisy": the signal is overlayed by a lot of noise.
    The volume control elements of the mixer no longer work.  The
    "H/W" element switches off the music (but not the noise) for the
    right speaker when not set to "PCM out".  Similarly the "H/W 1"
    element switches off the music (but not the noise) for the left
    speaker when not set to "PCM out".

Conclusions:

(1) GPIO4 seems to be connected (I still can't see this on the board),
otherwise the CS0 setting would not have any effect.

(2) Setting CS1 seems to enable the capture channel.

I hope this helps,
Jochen
--=20
http://seehuhn.de/

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE2Lwhf+iD8yEbECURAl05AKDJxqpKikX+F+KlAzJfDFkxa3Eu4QCdHxKc
h3vcAhlRHxXVuIsRvuj/n+k=
=a4jP
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--


--===============1436055541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1436055541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1436055541==--
