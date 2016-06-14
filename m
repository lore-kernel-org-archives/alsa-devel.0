Return-Path: <alsa-devel-bounces@alsa-project.org>
Date: Tue, 14 Jun 2016 22:38:10 +0200
From: Henrik Austad <henrik@austad.us>
Message-ID: <20160614203810.GC21689@sisyphus.home.austad.us>
References: <1465686096-22156-1-git-send-email-henrik@austad.us>
 <20160613114713.GA9544@localhost.localdomain>
 <20160613130059.GA20320@sisyphus.home.austad.us>
 <20160613193208.GA2441@netboy>
 <20160614093000.GB21689@sisyphus.home.austad.us>
 <20160614182615.GA2741@netboy>
MIME-Version: 1.0
In-Reply-To: <20160614182615.GA2741@netboy>
Subject: Re: [alsa-devel] [very-RFC 0/8] TSN driver for the kernel
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7496952745549675809=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-devel@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>, linux-media@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>


--===============7496952745549675809==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2016 at 08:26:15PM +0200, Richard Cochran wrote:
> On Tue, Jun 14, 2016 at 11:30:00AM +0200, Henrik Austad wrote:
> > So loop data from kernel -> userspace -> kernelspace and finally back t=
o=20
> > userspace and the media application?
>=20
> Huh?  I wonder where you got that idea.  Let me show an example of
> what I mean.
>=20
> 	void listener()
> 	{
> 		int in =3D socket();
> 		int out =3D open("/dev/dsp");
> 		char buf[];
>=20
> 		while (1) {
> 			recv(in, buf, packetsize);
> 			write(out, buf + offset, datasize);
> 		}
> 	}
>=20
> See?

Where is your media-application in this? You only loop the audio from=20
network to the dsp, is the media-application attached to the dsp-device?

Whereas I want to do=20

aplay some_song.wav
or mplayer
or spotify
or ..


> > Yes, I know some audio apps "use networking", I can stream netradio, I =
can=20
> > use jack to connect devices using RTP and probably a whole lot of other=
=20
> > applications do similar things. However, AVB is more about using the=20
> > network as a virtual sound-card.
>=20
> That is news to me.  I don't recall ever having seen AVB described
> like that before.
>=20
> > For the media application, it should not=20
> > have to care if the device it is using is a soudncard inside the box or=
 a=20
> > set of AVB-capable speakers somewhere on the network.
>=20
> So you would like a remote listener to appear in the system as a local
> PCM audio sink?  And a remote talker would be like a local media URL?
> Sounds unworkable to me, but even if you were to implement it, the
> logic would surely belong in alsa-lib and not in the kernel.  Behind
> the enulated device, the library would run a loop like the example,
> above.
>=20
> In any case, your patches don't implement that sort of thing at all,
> do they?

Subject: [very-RFC 7/8] AVB ALSA - Add ALSA shim for TSN

Did you even bother to look?

--=20
Henrik Austad

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAldgazIACgkQ6k5VT6v45lkBYACePNiLE3TpU9VONnqHAbNfEtBA
HzIAn3AGu7lakjCHeutRZ7Yn2fDegbSV
=QsdK
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in


--===============7496952745549675809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7496952745549675809==--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
