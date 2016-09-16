From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Revert "ASoC: core: mark SND_SOC_BYTES_EXT
	as deprecated"
Date: Fri, 16 Sep 2016 15:11:11 +0100
Message-ID: <20160916141111.GC27974@sirena.org.uk>
References: <1473980762-13259-1-git-send-email-o-takashi@sakamocchi.jp>
 <20160916105247.GY27974@sirena.org.uk>
 <9ad9a4af-85ab-6e9f-f17b-6e8afc7fe595@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1746084442716426296=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E55532666EB
 for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2016 16:11:27 +0200 (CEST)
In-Reply-To: <9ad9a4af-85ab-6e9f-f17b-6e8afc7fe595@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, clemens@ladisch.de, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============1746084442716426296==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2R+TDOstMAPx/aG/"
Content-Disposition: inline


--2R+TDOstMAPx/aG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 16, 2016 at 10:21:12PM +0900, Takashi Sakamoto wrote:
> On Sep 16 2016 19:52, Mark Brown wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem.  This makes it easier for people to identify relevant
> > patches.  Look at what existing commits in the area you're changing are
> > doing and make sure your subject lines visually resemble what they're
> > doing.

> OK. But the different fashion in ALSA SoC part from ALSA itself often
> puzzles me.

ALSA patches don't usually start "Revert" either...

> > > However, SND_SOC_BYTES_TLV brought confusions to user land because it
> > > doesn't follow to a protocol of ALSA control interface. At least, this
> > > macro and related kernel APIs include two misunderstandings:
> > >  - 'struct snd_ctl_elem_info.count' can also represent the length of TLV
> > >    packet paylaod, snd_soc_bytes_info_ext() performs in this way.
> > >  - 'struct snd_ctl_tlv.tlv' can include arbitrary data regardless of TLV
> > >    packet structure, snd_soc_bytes_tlv_callback() performs in this way.

> > I can't tell what problem you are trying to describe here, sorry.  What
> > are you expecting the userspace ABI to do that these controls don't,
> > you appear to be saying that the code does actually do what's expected
> > which obviously isn't a problem.

> These two APIs don't perform what to be expected in a point of application
> interface. These two items are not what to be expected in a point of
> application interface, but what they do wrong.

In what concrete way do they not do what is expected?

> > What do you expect to happen, what is
> > actually happening and why do you beleive this to be a problem?

> This patchset comes from a conclusion of this thread:

We need someone reading the changelog to be able to identify what the
change is doing, especially for something like this which is visible
outside the kernel.

> > Having two randomly different interfaces is not going to help
> > that or stop the larger controls existing, it'll just make the interface
> > more confusing for driver authors.

> On the other hand, when some driver developers actually follow to the
> message which I'd like to purge, then abuses of the interface are increased.
> Near future, it will bring confusions and disorder to ALSA applications. And
> the cause is hard to be identified from user land, because few developers
> think drivers lose protocol of application interface in fact.

> Of cource, there's a need to work more to solve this issue. This is quite a
> small part of it.

This isn't really going to help that too much unfortunately given that
one of the users of the new interface is the Intel drivers which are
presumably going to be one of the most common things applications
encounter.

--2R+TDOstMAPx/aG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX2/19AAoJECTWi3JdVIfQpoQH/ixp8nu+e3bcP+Ghx9iQ2Ft2
gHzDTmQwgNTznDD8dBEefugudFfyg9qpK5B9DA+5rWfKKrBM6kjQj5NjcH83As2t
veFQ5k92y5x7Mijaif7Xbl9kpHu5TnxCalvhV1M8GynKLTdv5gWjZ9YOTAcRp5DN
Wf9Aes5IDYncO0/7lutSo8sdrBjL4+v7Hmd7nKmKX+b2t1//gE3+vtAdy9iOZe6N
RKLSP7664zyiSSNocZWnAKtM5sbQ+Ej7w+gyB2+Zvdi0ydPjMb41GRgzY1y+r9eC
CV+zjtz/DUWlV5oojPozMU58MtpciXMc4ZeciCLoQ/d1HvC31DeWoh/ys37qA8c=
=RHTi
-----END PGP SIGNATURE-----

--2R+TDOstMAPx/aG/--

--===============1746084442716426296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1746084442716426296==--
