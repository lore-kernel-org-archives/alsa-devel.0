From: Mark Brown <broonie@kernel.org>
Subject: Re: Abouut adv7511 driver
Date: Sat, 1 Aug 2015 12:08:36 +0100
Message-ID: <20150801110836.GS20873@sirena.org.uk>
References: <87zj2cvqi7.wl%kuninori.morimoto.gx@renesas.com>
 <55BB2704.4070509@metafoo.de>
 <87y4hwviyu.wl%kuninori.morimoto.gx@renesas.com>
 <2068811.mrRDGz9M57@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5031844664908735194=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <2068811.mrRDGz9M57@avalon>
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Magnus <magnus.damm@gmail.com>, alsa-devel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============5031844664908735194==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0blaZc+aUkVqY8MO"
Content-Disposition: inline


--0blaZc+aUkVqY8MO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 01, 2015 at 12:44:06PM +0300, Laurent Pinchart wrote:
> On Friday 31 July 2015 08:21:16 Kuninori Morimoto wrote:
> > Hi Lars

> > > The reason why the driver is not upstream at the moment is that the w=
ay it
> > > implements things is definitely not the right way. But there is still=
 a
> > > lot of discussion on what actually is the right way to implement audio
> > > support for HDMI devices. Once that has been sorted out the driver wi=
ll
> > > hopefully go upstream.

> Beside the in-kernel API, have you given a thought to DT bindings for HDM=
I=20
> encoders ? Some platforms use DT bindings based on OF graph for the video=
=20
> path, would it make sense to model the audio path similarly ? The=20
> implementation could become a bit of a challenge though.

It's a bit of a struggle to get anyone to consider the generic problems
for HDMI at all - Russell did some really nice work with the EDID
handling but that's been about it.  There was some talk about replacing
simple card with a graph based simple card but it hasn't been moving
quickly.

Personally I'm not 100% sure how relevant binding issues will be to the
HDMI integration - as far as I can tell the integration of audio and
video is generally happening within a single device (either an external
encoder or the SoC itself) so it's not something that needs to be
represented externally to that device and there's sometimes some
flexibility about the connections internal to the device so we don't
want to nail things up entirely in DT even if it was needed.  There may
be other kinds of hardware I'm not familiar with here where it does
become important though, or I may be missing things.

--0blaZc+aUkVqY8MO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVvKi0AAoJECTWi3JdVIfQI/EIAIYim+TKA5J0X/U5Od38QxkK
3wFuxwAUoBho/MwxHeehT6h73T9zJ8j/34824SkhTYjmrSi4bWIktHSXrpmw9AJ3
F1XqPIJIIr6UdlEFI2ggr1xVdw3HCP0QRlUy5K3beMQHAlmDUTaeTDM3h91Y4wpa
/Tut9bI+06TADLTtbCixsfuGGit7YzrOuV16jWpf3RltFPt8RQYEE8OYbnhRqcpt
TAmxJ2mM1woUM/90ij6WzMlXvBZIGuieuoAVYnv8ifwAKYX8Y+IvdKjNgQNwh5Pf
oCY3tUlnaK23xYAcIf3BH/r5MyYdglIpfdSokIFDNActuhu5jZaVLmKWzC6DX7o=
=BPdO
-----END PGP SIGNATURE-----

--0blaZc+aUkVqY8MO--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in


--===============5031844664908735194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5031844664908735194==--
