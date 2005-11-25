From: Josh Green <josh@resonance.org>
Subject: Re: Modem support for ICH6 based laptop?
Date: Fri, 25 Nov 2005 02:10:21 -0800
Message-ID: <1132913421.10774.32.camel@SillyPuddy.localdomain>
References: <1132791202.32481.22.camel@SillyPuddy.localdomain>
	 <20051124030116.GB6056@tecr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dO2+X6tH7RjRo2PrOIAP"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20051124030116.GB6056@tecr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sasha Khapyorsky <sashakh@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-dO2+X6tH7RjRo2PrOIAP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-11-24 at 05:01 +0200, Sasha Khapyorsky wrote:
> On 16:13 Wed 23 Nov     , Josh Green wrote:
> > I have an ASUS Z71V based laptop which has an Intel HDA sound system
> > (uses snd-hda-intel).  This laptop also has a modem, which I have heard
> > referred to as an ICH intel modem, but I'm not sure of the details.
> > I've tried loading the snd-intel8x0m module, but it doesn't seem to do
> > anything (no additional sound cards, output, etc).  I didn't find any
> > matches when looking through the list of PCI IDs in the intel8x0m.c
> > file.  Any ideas if this driver supports this modem, or could be made t=
o
> > support it?=20
>=20
> Not intel8x0m, there is HDA (High Definition Audio, or Azalia) bus and
> modem, the driver is 'hda-intel'. Is your modem supported or not depends
> on which kind of modem (modem codec) you have. Drop us content of file
> '/proc/asound/card0/codec#1' and we will know answer.
>=20

Ahh, ok, I was wondering how to identify it, since I assumed it was an
AC97 controlled device.  I'm currently using hda-intel for the sound
hardware, but its nice to know that this is also the same one that may
support my modem.

Info I gathered for this modem, if anyone is interested:


$ cat /proc/asound/card0/codec#1

Codec: Generic 14f1 ID 2bfa
Address: 1
Vendor Id: 0x14f12bfa
Subsystem Id: 0x0
Revision Id: 0x90000


scanModem:

Class 0403: 8086:2668   Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW=
 (ICH6 Family) High Definition Audio Controller (rev 04)
  SubSystem 1043:1964  ASUSTeK Computer Inc.: Unknown device 1964
        Flags: bus master, fast devsel, latency 0, IRQ 16

                  -----PCI_IDs-------                    --CompilerVer-
    Feature List:  Primary  Subsystem Distr  KernelVer   kernel default  CP=
U
 ./scanModem test 8086:2668 1043:1964 gentoo 2.6.14-gentoo-r2  3.4.4 3.4.4 =
   i686
 This combination of softmodem controller and Subsystem:
        Primary   8086:2668
        SubSystem 1043:1964
 has not been previously reported.

   for this pair, -----PCI_IDs-------, a modem codec is not in the records.

 The controller: 8086:2668 Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) =
High Definition Audio Controller
 is capable of supporting soft modem chips from AT LEAST manufacturers:
        Conexant
        Smartlink


> BTW. http://linmodems.technion.ac.il and discuss@linmodes.org list are
> useful places for "which modem driver" questions (codec#1 identification
> will be needed anyway).
>=20

Thanks for the tips.  I was having trouble finding any information on
this particular modem and ALSA (well actually ANY modem and ALSA), so I
decided to post here.  I'll do some more research myself now that I have
a better idea of how to identify the codec.  I'll try those other lists
too, since that is probably a more appropriate place for these questions
(unless it comes down to some ALSA code actually being added/changed :)

> Sasha.
>=20

Cheers!
	Josh Green


--=-dO2+X6tH7RjRo2PrOIAP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBDhuMMRoMuWKCcbgQRAkQ2AJ905RGdgomRzybHqYA5z772b9sIXQCdHA9e
sOHSuWxmqoA+9zJGBF6y3C8=
=6Wcz
-----END PGP SIGNATURE-----

--=-dO2+X6tH7RjRo2PrOIAP--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
