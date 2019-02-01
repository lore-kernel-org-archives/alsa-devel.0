From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ALSA: pcm: implement the anonymous dup
	v3
Date: Fri, 1 Feb 2019 13:01:17 +0000
Message-ID: <20190201130117.GF20797@sirena.org.uk>
References: <20190130124139.10439-1-perex@perex.cz>
 <20190130223237.GK2804@sirena.org.uk>
 <s5hsgx9ckrf.wl-tiwai@suse.de>
 <20190131122624.GA20797@sirena.org.uk>
 <ae257dec-72b9-654c-6366-486e3d7ff836@perex.cz>
 <CACL=Q7ykqDEsaJzcxVexaaNCukw4yiNNQSGZLON=fXbJ7AH-9g@mail.gmail.com>
 <CACL=Q7y==PFTdknurbg-yZPoBjYh6n5Lduyy32Us1HepeVU-bg@mail.gmail.com>
 <CAEiLdJb-QLmtp0vWxvCj6Kb3rmkEx8dKndmBovHvx7hk93pt_Q@mail.gmail.com>
 <s5h36p8d0v8.wl-tiwai@suse.de>
 <7d46e614-9291-a95a-6216-8abe9e6f1a5d@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1129491698911863145=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B1C4F266FA5
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2019 14:01:23 +0100 (CET)
In-Reply-To: <7d46e614-9291-a95a-6216-8abe9e6f1a5d@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.de>, Phil Burk <philburk@google.com>, Zach Riggle =?utf-8?B?8J+Wlg==?= <riggle@google.com>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1129491698911863145==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 01, 2019 at 10:55:24AM +0100, Jaroslav Kysela wrote:

> I agree. We can have just two modes for the beginning:

> a) full one (useful for testing)
> b) buffer only (allow just sound data mmap)

> The question, if we should use different names (line anon_inode:snd-pcm
> and anon_inode:snd-pcm-buffer) for the anonymous inodes remains. I
> believe it might be good to distinguish this to allow the proper SELinux
> audit.

I agree that the separte names seems better, it gives more flexibility
and control to people writing policies.

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxUQxwACgkQJNaLcl1U
h9BVqwf/Q3sN1REQQbe1Ne3kXaCdnps8nLv+rKNBjFPLcmv3NC4TTl63z52gpVdM
PZaiETVtCPRr8dyldhS0Ty5B+RR0j9Pl84MT1gSn+QfbdScFBe2Y9XlGuFb1kOeq
E9GW/I4BogZlZIJuuq66G9aJ+EADfr96VyXkWBC5eo4tLXa2wf+DAzSF5iBH3+nf
EzF5KQhxEub51jWevNfAvhEKHNPB9Jymthse8V1HcUZOa9ruXmm2YLZZmlHPfYoq
yrlLfBsG2DFvAWSu8IS3c1eaHv6gkWxrHCjaKcJjEjty/7bgbRA7sO24/XNjbUVo
AriQlugTfurOWAB5WfVY3BFl7BjQig==
=efe/
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--

--===============1129491698911863145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1129491698911863145==--
