From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: ep93xx: get rid of
 ep93xx-pcm-audio struct device
Date: Tue, 10 Dec 2013 17:02:57 +0000
Message-ID: <20131210170257.GC11468@sirena.org.uk>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
 <1386620656-18391-2-git-send-email-swarren@wwwdotorg.org>
 <52A62BC3.1050807@metafoo.de> <52A6573E.1000504@wwwdotorg.org>
 <52A6C702.4000607@metafoo.de>
 <20131210102334.GX29268@sirena.org.uk>
 <52A747C7.9040706@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0224335246519872922=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C7012652AC
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 18:03:02 +0100 (CET)
In-Reply-To: <52A747C7.9040706@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0224335246519872922==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2013 at 09:56:39AM -0700, Stephen Warren wrote:
> On 12/10/2013 03:23 AM, Mark Brown wrote:

> > Yes.

> OK, so you plan on merging topic/dma into topic/ep93xx and topic/spear
> then? Since this series does depend on patches in topic/dma.

Yes, that's how I normally handle these things - merge the core branch
into the relevant driver branch.  The final removal is going to be stuck
due to the ux500 anyway.

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSp0k+AAoJELSic+t+oim9edkP/3Kl4QGnZ0HfI2/1LQOs8Lus
yw8qoXq0AFHYOueCiHtL4GicZvP0V+UEe9x1hbRERux1ZAxJff1nwVbi2jpAkg79
Je8DeAAK8aH6+I3nN9fp6iFHsBlzzou2/9ICV3V0MBI4YQro67KHmcrVDoLxMQdc
iezvITpCa58hSFPI24pMhckUMGQm/ODFBpuEmQPyuqg573J50Ki9fv3G93EMs0L9
XWcv2dbRu9zQ0PjR31IMuYyTfwaJDwEZB8sv1+JnLERErBpfMcqCJJEdu7ODH6cx
cGIhGf/QjR3JgEQdZR/WNGxJ7Kp4zY77n06PyCIR+JTo7N0ydSr4JDvDGz7lk3qi
JKzhWriwTbG3WZBNg07dxaN/LhKRGpIFa19BsJUzfzlZ7HH1Pf+/+SA7wLXfsw+4
RfLSE1Gr6fmDjzyS7e4jr3QJ5TBQSD9qecDhB1eQi2TD9X8OJOnzTK56W4quToCy
crzS4p2jOQcT4hdWFy5QAqGkyr70Gqjp8cKWv1OwfUk+k9EW5APRvueOPMOXXNcM
UlCGzf5a9xauX6KnS0HLnDE3B/MvSHHE87ngq2ho8QeHawnzacEuXIgLDgmuPPVh
fI3H5xEMKnvaWJZozHHto3aqp7gB0L5Plf4fefdTGhCT9pUFT9Pvk64sd0TJjHaC
V/0Ibj/wOKd7XOvI2hLe
=uOLo
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--

--===============0224335246519872922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0224335246519872922==--
