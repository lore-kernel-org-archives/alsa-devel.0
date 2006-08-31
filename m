From: Jaroslaw Gorny <jaroslav@aster.pl>
Subject: Re: what about STAC92xx (was: No headphones on
	STAC7661)
Date: Thu, 31 Aug 2006 21:08:44 +0200
Message-ID: <200608312108.52327.jaroslav@aster.pl>
References: <44F556E5.6010909@axege.com> <44F59A79.5040100@axege.com>
	<s5hzmdm48tn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1043914606=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hzmdm48tn.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1043914606==
Content-Type: multipart/signed; boundary="nextPart1432594.Az13jfNK9b";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1432594.Az13jfNK9b
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dnia =C5=9Broda, 30 sierpnia 2006 16:06, Takashi Iwai napisa=C5=82:
> At Wed, 30 Aug 2006 16:02:33 +0200,
>
> Franck Routier wrote:
> >
> > This ?
> >
> > 0000:00:1b.0 0403: 8086:27d8 (rev 02)
> >      Subsystem: 104d:81e6
> >      Flags: bus master, fast devsel, latency 0, IRQ 74
> >      Memory at de400000 (64-bit, non-prefetchable) [size=3D16K]
> >      Capabilities: [50] Power Management version 2
> >      Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=3D0/0
> > Enable-
> >      Capabilities: [70] #10 [0091]
>
> Yes.  Confirmed that your device is already included in the latest
> ALSA HG tree.
>
Ah, as we are here, I just want to ask about this one:
<quote>
00:1b.0 0403: 8086:27d8 (rev 01)
        Subsystem: 1028:01bd
        Flags: bus master, fast devsel, latency 0, IRQ 233
        Memory at dfebc000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=3D0/0=
=20
Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)
</quote>

aplay -l tells that this device is:
<quote>
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
</quote>

I know I should just try it instead of asking, but I'm dramatically out of=
=20
time and won't be able to compile it before next week :(

Thanks,
J

PS. Just want to add that before last kernel update (FC5 distro-kernel)=20
aplay -l showed _two_ "cards". One 'Analog' and the other 'Digital'. Now as=
=20
you see I've got one (which still works ocassionally - this hasn't changed).

Regards,

=2D-=20
Jaroslaw Gorny
jaroslav@aster.pl


=2D----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GMU/E/CS d+/-- s+: a- c++ UL++/US P+>++ L+++>++++
E>++ W N++ o? K w--- !O M V- PS+++ PE++ Y PGP>++ t 5
X- R- tv--/!tv b++ DI-- D G- e++>+++ h-- r+++ z+++
=2D----END GEEK CODE BLOCK-----

--nextPart1432594.Az13jfNK9b
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE9zPE6haYWsLTFVgRAgNtAJ9Qud1tCp67NKRsSupN4g4bVwQV/QCeNOPH
Y7wFYalBzCPhrVwUU1XBQFc=
=QLuF
-----END PGP SIGNATURE-----

--nextPart1432594.Az13jfNK9b--


--===============1043914606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1043914606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1043914606==--
