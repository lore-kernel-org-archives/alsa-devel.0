From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] ALSA: compress_core: Ensure device is
 stopped when stream closed
Date: Fri, 26 Apr 2013 16:38:48 +0100
Message-ID: <20130426153848.GA5019@opensource.wolfsonmicro.com>
References: <20130426134706.GA27501@opensource.wolfsonmicro.com>
 <20130426134850.GX5019@opensource.wolfsonmicro.com>
 <20130426135627.GB27501@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3605007045827116226=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A00B1260291
 for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2013 17:38:49 +0200 (CEST)
In-Reply-To: <20130426135627.GB27501@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


--===============3605007045827116226==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rMBvpMIlSQ3hWZ0K"
Content-Disposition: inline


--rMBvpMIlSQ3hWZ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2013 at 02:56:27PM +0100, Richard Fitzgerald wrote:
> >> +     if ((data->stream.runtime->state == SNDRV_PCM_STATE_RUNNING) ||
> >> +         (data->stream.runtime->state == SNDRV_PCM_STATE_PAUSED))
> >> +             data->stream.ops->trigger(&data->stream, SNDRV_PCM_TRIGGER_STOP);
> >> +

> >A switch statement would be more idiomatic for this sort of thing.
> >

> This follows the general style used in other functions in the
> source file. I'm happy to upload a version that uses a switch
> instead if that's preferred.

Well, it doesn't quite follow the same style as the code generally does:

        if (stream->runtime->state == SNDRV_PCM_STATE_PAUSED ||
                        stream->runtime->state == SNDRV_PCM_STATE_OPEN) {

with fewer () and different indentation to what you have above...  being
consistent with the rest of the file is best, though it would be nice to
update the file to do this sort of thing with switches.

--rMBvpMIlSQ3hWZ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRep+BAAoJELSic+t+oim9Z/kP/2TI+JL/TgGNQamvWJW4foc5
LmnUyo0dZUrT494UEhg1apy7VDTD36A4q/d7PEgW+n6FeMttUUTF3ab0fscaAGHa
RecBK5XH+P0Ea1IJbBNlA8a3sgbJVQvpELssuLPqoAGiVUSXJ4sMtIQgrtzpRPa5
KXCCUhK2JViOz66pfk/RLUwpsFDZnaEkHXSLIQ4qZr722PB6+NiMl9LDwY8VH6qB
MCZhiPZt0oh2not9WHlCLUF+chjzZVvsDn/oIgN+6sa5dqEhWOo1+ovfF+857ngF
/jdLTbqe6kMWH6R/uRrHqL55E5k8UrArDdgk6WCP4Uaonm9i3xlobnogXCae8YqN
rCtywEoLbstHmRmI91fK4mnWyK8yQUmUKQNyRzNWFQ/vdLAJ6PnoJxH3SkT2S+SQ
NAEW2aQD3xEPiIdQAl+Cu6W5bwIcl+9zEz6sFWzDD4aXa3lj0DT9gCjt/2DMN7dP
CDcAchwfbLQyWDjzjiRGcYC7dcsxHseUi+hLF/6AUWBIzA2Ytv2X++KbUehNB/ct
U6QpTjkEjQkGNJWZ0ds3HOI2GGTg2UEtSrycZua7OCi9NmzbBivx219lSMZBNwYX
XL8bNiVIgC30emqdZnMtVP64jC7qBST3IPzUzTjKnInuniVEGBHIk134ICpbu5Tx
QglA1eDJB0R1iAoL1Ven
=n5Fy
-----END PGP SIGNATURE-----

--rMBvpMIlSQ3hWZ0K--

--===============3605007045827116226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3605007045827116226==--
