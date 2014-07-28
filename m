From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: Device tree binding to dummy codec
Date: Mon, 28 Jul 2014 12:20:55 +0100
Message-ID: <20140728112055.GM17528@sirena.org.uk>
References: <CAKON4Oynu5HE-jDETrNRBY3dYtwuh6XmOgyDOQuc4jmCzmNhNg@mail.gmail.com>
 <53D5ECA7.5090106@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6811765401395355169=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 80E0E260815
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 13:21:06 +0200 (CEST)
In-Reply-To: <53D5ECA7.5090106@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6811765401395355169==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TjoDfNCFvpOf6g+g"
Content-Disposition: inline


--TjoDfNCFvpOf6g+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 28, 2014 at 08:24:39AM +0200, Lars-Peter Clausen wrote:
> Cc ASoC maintainers.

Jon, you should really know to CC maintainers.

> > So how should this be implemented? You want to use simple-audio-card
> > when the MAX9768 is present.

You do - why?  It's not immediately obvious to me that this fits well,
there's a good reason why lots of the functionality there is done as a
library...

> While this restructuring allows for CODEC-less systems, it does not allow
> for DAI-less systems yet. At least if you want to have a PCM device. To
> properly support DAI-less systems 3 major pieces are missing:

To be honest I don't see a great need to remove the requirement for a
DAI - even with the CODEC baked into the SoC there will often be some
form of IP separation and the stubbing isn't really the blocker to
supporting anything.

> * Support for creating a PCM device without specifying a DAI link. Right now
> the only way in ASoC to create a PCM device is by having a DAI link. For
> systems without DAIs and DAI links we need an alternative. Preferably the
> driver for the on-chip CODEC should be able to create the PCM device itself
> since it is basically embedded in its hardware.

Another and probably simpler way of approaching this is to allow more
than one thing in the card to provide DAI links.  That meshes better
with DPCM as it stands and sidesteps the need to deal with carrying
digital stream configuration information through DAPM which is where you
end up otherwise since you really want DPCM systems to be able to behave
in a similar way.

A good proportion of these systems do actually seem to have physical I2S
interfaces as well to allow people to change up to a better CODEC if
they want so might actually want to be DPCM systems really.

> * Proper devicetree bindings for this kind of devices

What bindings would we have?  It should be transparent to device tree
since shouldn't be representing the internals of devices in the device
tree, that's redundant and adds to complication.  For device tree we
just want the external connection points of each device to be visible
and that's already handled.

What we do want is better support for building the card up from multiple
sources of data so that all the in-SoC stuff can be done by the drivers
for the components in the SoC instead of requring bits of it to be in
the machine driver as we do curently with DPCM.

--TjoDfNCFvpOf6g+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1jIUAAoJELSic+t+oim9fkYQAIvMVIOCrGJsCHV/X34RzkEV
xvAejA2eb1CSligtj7DMInt7tm66ynzaSWvK0VqzUijUlq23IHP21bVPoBdSTWce
oNfrcN1EJrpa5Ou7iUXqfELsXRbvsQiExRpp9ERsZ6W7EPwP9FP6yPjo5j48qjRY
PSq0EcpNLwvzEn3QIzLv0f9haYDYeATvpSeHKKp1N7h4oPSBIV3UrmguaUCXkrbT
zxHmXD6q7YXFdMoyrTOBuTVHOB6O05JRKI4Nt9rwzB0o+tuJpRUIv7vO/VBTd7Em
/8ECO4vmU+DGIkML6GkiJKskRxtEp5uTXRy2+S+huDGUuydpvHCJjuKmOuxrMTl/
4UI5FB/c5lkFSe7j0RbuVpEFIccyGI4+sVvJjKjckIgr0KSv8uzjmZ6wNpUG9HSk
6bKi469iu00etVpFScnEh8o16vjLix3plhuooIcFeng1kdDOKZvZXjxOH1hIcmG3
V0jbmTVi9Ui/QseHiMrM6LhKFtg+8SGukd9pOBPMHmZHYrmmacLIE353AP0FJCL1
Wgyt6de6NkR0KANQaqCQeJAPcCyDI45sAdYWejFc6vg93zRxZQewV37AREUZGkhe
ZVNqK/py2ln2FRP4xDaDtThKD/+G+TiJxoSjTPIJqpfSNy/RT/SgqBp4mmWDUCGM
xL50X5uTYOB4ArKC1qpP
=GyD3
-----END PGP SIGNATURE-----

--TjoDfNCFvpOf6g+g--

--===============6811765401395355169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6811765401395355169==--
