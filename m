From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] compress: add support for gapless playback
Date: Wed, 6 Feb 2013 13:32:53 +0000
Message-ID: <20130206133253.GM4720@opensource.wolfsonmicro.com>
References: <1360074085-562-1-git-send-email-vinod.koul@intel.com>
 <5111C39A.6020805@linux.intel.com>
 <20130206075419.GF3143@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2483878364233378351=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1989F265001
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2013 14:32:59 +0100 (CET)
In-Reply-To: <20130206075419.GF3143@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.jf.intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2483878364233378351==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p5BJhDJf0owydRUK"
Content-Disposition: inline


--p5BJhDJf0owydRUK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 05, 2013 at 11:54:19PM -0800, Vinod Koul wrote:
> On Tue, Feb 05, 2013 at 08:44:42PM -0600, Pierre-Louis Bossart wrote:

> > >+snd_compr_set_metadata(struct snd_compr_stream *stream, unsigned long arg)
> > >+{
> > >+	struct snd_compr_metadata *metadata;
> > >+	int retval;
> > >+
> > >+	if (!stream->ops->set_metadata)
> > >+		return -ENXIO;

> > Is this really a fatal error? Or do we want to mandate that gapless
> > be supported by all implementations?

> Fatal err? if DSP doesnt support metadata callback then we are reporting error
> ENXIO to userpsace. No we shouldnt mandate, its upto DSP folks to see what they
> should and can support.

Well, up to userspace to see how it handles the error anyway.  For
example an application may want to fall back to PCM playback with
gapless done on the CPU if the driver doesn't do it.  But then given
that there's more than one piece of metadata in the struct perhaps we
need some way for the application to figure out what's supported?

--p5BJhDJf0owydRUK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRElt4AAoJELSic+t+oim9v20P/2/RIGvdNHwhZ/1ApA8M5SxA
An5T32ER44PcmPSdUQyedNhkUlDpuR5c53lOknfRGlbJx3NkFndITw8700dc8raA
ChRAcNXdy+2uok4M724zXacnpRDhJqXcn1bMGFP2VX/W2E6xg2iSuhdqAW2eIqT+
rZdjOreNDKnizLRWOg+VseL3v1MN13t2xvaWUwzh/PNwL3i46jz+UjRzwucjYXpz
bsaUeRY3fmvZVdBjFYeBmzFkdP6F3FiOVGi6ibEiGpBJD4yl/P0VCyxAaeMOSfgE
u1pFR+qGaPg2JcuTyyvLa6cKZCcO6fzIRq3X5FxQFC3nGIKo3JSxU5CjBr85ZZBU
mURGRRt3TBu8kBJENN1uQjf3XbZuxt4dU6a2i3GpIejG9fgNADtBNncF81+8nwXT
psgz6mPyIU6ETMqfmDjdnbzhuoX0JFgSDUtLRZKFwA3RE/VtTnMsCQck2FxyVoHQ
/fKRKLM7FzISkjzf7xoCfakPM4JBV/WV9KZjflA3clbmaOPQ+PztFvRQubRgdJs4
q5Hd6DYEKSUCij2j/6dRdqyvJbST5inNemfbqxZQLkBrpwmoZETQNan/ePfIANdM
H2BwnCu3VdTsrOUV2GL6xrAQEH1ZmqK9I+MxlzbM51vshKiDKl5yWWlxBnFe1/uY
DhGdnprJIJJ/zWJOznZb
=eXCi
-----END PGP SIGNATURE-----

--p5BJhDJf0owydRUK--

--===============2483878364233378351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2483878364233378351==--
