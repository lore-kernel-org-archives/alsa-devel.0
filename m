From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6 v3] Add ASoC support for AMD Stoney APUs
Date: Thu, 31 Aug 2017 11:28:25 +0100
Message-ID: <20170831102825.glntvhochkawbpeh@sirena.org.uk>
References: <1503079830-16072-1-git-send-email-alexander.deucher@amd.com>
 <CADnq5_NV0wmstpos9Hqc_dbTAOOOUozb=B_-6vd1PhD=zCMLhQ@mail.gmail.com>
 <20170830151913.6vknazyhh4se5524@sirena.org.uk>
 <87h8wo28o1.fsf@anholt.net>
 <20170830211003.3qyilnuylzwjeium@sirena.org.uk>
 <BN6PR12MB16524B7C3F9BC4CA56552828F79C0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6144387821042733368=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E9A45267217
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 12:28:27 +0200 (CEST)
In-Reply-To: <BN6PR12MB16524B7C3F9BC4CA56552828F79C0@BN6PR12MB1652.namprd12.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, rajeev kumar <rajeevkumar.linux@gmail.com>, Eric Anholt <eric@anholt.net>, amd-gfx list <amd-gfx@lists.freedesktop.org>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexdeucher@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6144387821042733368==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v6ncgesxfsj2xkqm"
Content-Disposition: inline


--v6ncgesxfsj2xkqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 30, 2017 at 09:40:07PM +0000, Deucher, Alexander wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> I sent one patch in the v2 patch set that had already gone upstream
> because I didn't know that it had landed in Linus' tree yet.  I had
> thought it had just landed in the audio tree.  I apologize for that.
> On the v3 cover page, I mentioned that v3 was a resend of the patches
> that had not been applied to any tree yet; I did not resend any
> patches that were already applied.  I believe all the previous
> comments were addressed.  Now that we've clarified that, are there an
> outstanding objections to these patches?  The patches touch both drm
> and audio.  My preference would be to take them through the drm tree,
> but I'm happy to have them go through the audio tree if you prefer.

I haven't really looked at them yet because I was waiting for the DRM
side of it to get sorted out (previous experience has been that DRM
changes that need review can take a while to figure out).  To be a bit
clearer about what I said in the mail you're replying to you should just
apply the initial DRM bits and send a pull request, this is a standard
way of handling cross tree stuff and means that worst case there's fewer
dependencies after the merge window.

--v6ncgesxfsj2xkqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmn5MgACgkQJNaLcl1U
h9CBrQf/QDIT38uaqAbvsssT576jG/yYfS2rw01574zZtN2Ty+3QQoA4mrzqnwvX
CxeKdfb7Fr03/+FS0w28tKevovf3e/rj6GUIB63C0fcxWkrgya02oJ73CxQgyQ9E
c8laP3uQ6y52h1dbD329cYOqbxwJf8Gd9/yyK893K9sK13pYVVflzdGrMmQCUBQ6
kNikfytkLA/Qc4MSblQoMSbI91rSp/547Je+MDxMvAf5PWgaWYqxAlzAhJw82xTc
HP+PxEvdIJt9zLftiDyijTVUJzR9c4OpBp2KbFshQpdVdpwpe22wfX7qWPg+A3sj
RkW8mZ1r2dwUibLWlwCR5qSeWIAmhA==
=5fRk
-----END PGP SIGNATURE-----

--v6ncgesxfsj2xkqm--

--===============6144387821042733368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6144387821042733368==--
