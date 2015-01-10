From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/20] ASoC: rsnd: add Synchronous SRC and
 U/O error salvage support
Date: Sat, 10 Jan 2015 11:32:16 +0000
Message-ID: <20150110113216.GC4160@sirena.org.uk>
References: <877fyh9ilx.wl%kuninori.morimoto.gx@renesas.com>
 <87h9wl7qlb.wl%kuninori.morimoto.gx@renesas.com>
 <20141230171032.GQ17800@sirena.org.uk>
 <874ms6rraj.wl%kuninori.morimoto.gx@renesas.com>
 <20150106183319.GS2634@sirena.org.uk>
 <87a91vp6s8.wl%kuninori.morimoto.gx@renesas.com>
 <54AEC20C.90706@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2487124169357381909=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FB1D2606A8
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 12:32:24 +0100 (CET)
In-Reply-To: <54AEC20C.90706@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Tim Cussins <timcussins@eml.cc>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============2487124169357381909==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 08, 2015 at 11:44:44AM -0600, Pierre-Louis Bossart wrote:

> This matches my definition of an asynchronous SRC. I really don't get what
> 'synchronous' means here, and it'd seem odd anyway to have 1Hz granularity
> for the updates?

AIUI it's referring to the intended usage of synchronizing the rates in
two domains (which isn't the normal audio terminology).

> >>Adding Tim and Pierre since they might have views if my guess is
> >>correct, I could be wrong though.

> I'd be good to have a snd_pcm_set_rate() generic framework, but I wonder if
> it's practical. Hardware with ASRC or tunable PLLs isn't very common except
> in pro audio, stb, networking and automotive, and usually has specific M/N
> dividers or rates, I am not sure it can be done generically. Also most servo

ASRC at least is very common in mobile, and in that market people have
been driving requirements for on the fly reprogrammability for some use
cases (though they've not been delivered universally and this sort of
small adjustment in rate wasn't one of the requirements).

I'm wondering if a way of specifying the target rate and a way of
reading back the constraints might solve the problem, it seems like a
lot of work though.

> loops are implemented in firmware or in environments that don't use Linux,
> not sure how many people would benefit from such additions. At the same time
> people usually don't use ALSA in such environments because it doesn't do
> what they want, so it might be worth relooking at adjustable clocks,
> presentation timestamps, PCR, etc.

Right, that's kind of my thinking here.  I'm aware of people doing this
stuff in Linux environments outside of ALSA and of people talking about
similar hardware capabilities but I don't know what those look like.  I
don't know if for the time being just defining a control name for the
target rate might be enough - doing this fully is probably a big task
and I'm not sure anyone is interested right now.

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUsQ2/AAoJECTWi3JdVIfQCc8H/0aU8qJcTVCPA6baV7lNwLOT
eD2unTM2lqS08IB7F1U1KALrNKbZZm+/ZEfeuriP3CxCnHX1zYvwuI/MZhFm0UIy
cKA7NAFIccPj+TLl7rR791EjlkbA4YCU+jtoQD5j8E1jjuj+oZp8rXDyd+bqhHkf
g84yv3kaHp64mNVsH5i9w/XUwmILVMGcPCzh0x05ILD2d3/LdgF9laSwcX/FVIZ/
375xxc2WEs7LhZCKywJzEXk4AUjkKAt4XfLin4MGJMhLR2MBdrO40hDeqV6myas5
d7AVl/RZshYkyTDXyzT6qLI5kbCWEPBw/jR3ryv7NVPyCYdfz9LqkuXNFXDApeg=
=84r4
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--

--===============2487124169357381909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2487124169357381909==--
