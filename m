From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/9] ASoC: ml26124: Fix negative array
	index read
Date: Wed, 30 Oct 2013 14:33:49 -0700
Message-ID: <20131030213349.GP2493@sirena.org.uk>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
 <1383118507-21503-8-git-send-email-tiwai@suse.de>
 <20131030164838.GH2493@sirena.org.uk>
 <s5h4n7yk68b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7382899646602257033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 54CAC261740
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 22:34:03 +0100 (CET)
In-Reply-To: <s5h4n7yk68b.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7382899646602257033==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYfJCIN5rqlfy3K0"
Content-Disposition: inline


--WYfJCIN5rqlfy3K0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 06:40:04PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > This is ignoring the supplied error code, I'd expect to see the error
> > code being passed back (and fixed at the point where it's injected if
> > it's just returning -1 or something).

> Ah right.  The revised patch is attached below.

Applied, thanks.

--WYfJCIN5rqlfy3K0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScXs6AAoJELSic+t+oim9Y2IP/0345Gqxxu2AiJ6SxyMkEoiX
gs8yrm3PnVonwzRm/qy5eFykqAG5aM8+AxoGLavIPSmvgPHhjP3pNwjJjDor4ELn
Qt3gp7yc+3+9nlVWapR77LIYp8tw4xYrEK3UxVhCLGCPp3CUlw/NH98ZEjiwtGIT
6a1F6mfsYejhfT9LmIHDH6HEX7NNcRyG4DaEVOdcm7mKTkPMSGVYvTxJhX8J/c3L
HRvqlutuistC8T1znnDSZIM5es8nE+qDi5eJhYh5EonNrITFhVMlJqE2s83oAfjY
adQlqG9ej6Lg2iPEAgQfZPfjz1hFgJ9Fyxiikr80zmFCOwX3/ida5mMMC+Fb9CKR
f+k9xA7nLKVjcIxE7seyXKG2aE8khYqgq5ZBEzQGo/jN1nxM1q8oTEnp3WsR/Ait
68Roidb8OecohTy7dLZWBktjoy0fFziFV+0/KVX7YlsLbN3haJyd7auwNaVEneMs
Ik8PDF5lOkZXV500Gb9ktiMs/W00qpc9iKpCL77kSOI3k2UHqOHqoCStsiiMeuMx
gCVVddJZuc7WjjzMjckxM4K44WyNpVpIi1odmbLsSKt72FuAIWe/dZq5uIp48Mt3
ZGdJB5W9LZRnEr+zGrVT1KKjuIllCn9jFdbke6QifwA7RLcKQukhlhfoAjKjFA+V
LIUl3ESTaTUmAAf6ovYX
=8c3w
-----END PGP SIGNATURE-----

--WYfJCIN5rqlfy3K0--

--===============7382899646602257033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7382899646602257033==--
