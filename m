From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Add support for platform and
 CODEC drivers on same device
Date: Fri, 15 Mar 2013 17:02:59 +0000
Message-ID: <20130315170259.GC8988@opensource.wolfsonmicro.com>
References: <1359020951-25904-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130126092020.GH30594@opensource.wolfsonmicro.com>
 <20130315153540.GC2141@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7165887348620383238=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E41C264F4B
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 18:03:05 +0100 (CET)
In-Reply-To: <20130315153540.GC2141@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7165887348620383238==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline


--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2013 at 03:35:40PM +0000, Charles Keepax wrote:
> On Sat, Jan 26, 2013 at 05:20:21PM +0800, Mark Brown wrote:
> > On Thu, Jan 24, 2013 at 09:49:11AM +0000, Charles Keepax wrote:

> > > So this patch will check for existing widgets during soc_probe_platform
> > > and only create new widgets if no existing ones exist.

> > ...or as I was sending that it occurred to me that it'd be even neater
> > to share the DAPM context, though that's much more refactoring.

> Looking at this in more detail sharing the DAPM context doesn't
> fix the issue. The problem is related to overwriting the widgets
> on the DAI which means any routes added to the old widgets are
> no longer considered when DAPM processes the DAI. So I will sent

I don't think you've fully understood my suggestion, or what's involved
in much more refactoring.  I can't fully recall the context since it's
been several months since the discussion came up but I suspect the thing
here is that the widgets are mostly a function of the DAPM context so if
we share the context we share the widgets and don't end up creating
multiple copies.

> However, that said there is some argument for sharing the context
> anyway as there is no need for the one device to have two
> contexts associated with it, however I am not sure it is worth
> it. The most sensible way I can see to do so is to replace the
> dapm structs in snd_soc_platform and snd_soc_codec with pointers
> and dynamically allocate the dapm contexts. However this is a

Why would we need to dynamically allocate anything here?  The DAIs
should all be owned by something (the CODEC or, now, the component).

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQ1Q7AAoJELSic+t+oim9/CoP/1dgL/Iv9oag6wK58JhDFNse
feulhYgzD6Spjn115jjj+DxL1Eooo5Wa1h1iuWe9nanloPJ9ow6ZGjmjCIhhTkOO
64yQz0xH/FGrO3TLpOyca+HxXCqU3zIo40S43TaPZjigFj8NmXsnHT8j3vZ7L5Qz
sry0LVSAQ10uhgiHL5vtpX7dLHxKjBI6sqpktmUY+YH+QdmAn+Z2KTbFDD8S3Ujl
QhvZpr7LC4VtkP74+XT2D5B5+fsJcd2gVRcjSWS06vipTQWuive2iMAtMdNJrQ28
2iYlELj/oaPO5e/11i5j3ja9LGMlwsJBSO0buU/F2QYzjvuPLcx0nw70y6R+FiSc
LxnhL7nKIKFVHflJ5avAN5IIV90WWeBqmlcE0DcJUeznz/EItIzlPFw5Woe8P2YV
TOBI4/lpBFZGQLHunZENM75moWZzQx+TpnFrauDXJYCG6Z6WronLRlqWJ05Ps6FE
7sQVgNwk35o/TrRLfhCWfB/YLjM7xba7fFnYPQDYuIHtj2v2Ev5E6qaeqwq8PO3K
hWEa2ddDCtPd2Yfg+jInkrGzLApwVq3oemxqAYlLIxMorzfB16XCtWS6q52EZIeW
49fvfUckzFilJOmXr1EO7uXYGeq8v7hXMcRCjQW+oZh0XSlSylpNon6TnSm/4Wfp
wmSIzbcUtA9URo4SHyF1
=4HG6
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--

--===============7165887348620383238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7165887348620383238==--
