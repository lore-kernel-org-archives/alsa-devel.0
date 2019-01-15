From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Tue, 15 Jan 2019 00:06:10 +0000
Message-ID: <20190115000610.GM11073@sirena.org.uk>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5255498058445700871=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 38B502670AC
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 01:06:12 +0100 (CET)
In-Reply-To: <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
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
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, Ajit Pandey <ajitp@codeaurora.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============5255498058445700871==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uwB7x3tnyrZQfZJI"
Content-Disposition: inline


--uwB7x3tnyrZQfZJI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 11, 2019 at 03:49:08PM -0600, Pierre-Louis Bossart wrote:

> Adding some traces I can see that the the platform name we use doesn't se=
em
> compatible with your logic. All the Intel boards used a constant platform
> name matching the PCI ID, see e.g. [1], which IIRC is used to bind
> components. Liam, do you recall in more details if this is really require=
d?

That's telling me that either snd_soc_find_components() isn't finding
components in the same way that we do when we bind things which isn't
good or we're binding links without having fully matched everything on
the link which also isn't good. =20

Without a system that shows the issue I can't 100% confirm but I think
it's the former - I'm fairly sure that those machines are relying on the
component name being initialized to fmt_single_name() in
snd_soc_component_initialize().  That is supposed to wind up using
dev_name() (which would be the PCI address for a PCI device) as the
basis of the name.  What I can't currently see is how exactly that gets
bound (or how any of the other links avoid trouble for that matter).  We
could revert and push this into cards but I would rather be confident
that we understand what's going on, I'm not comfortable that we aren't
just pushing the breakage around rather than fixing it.  Can someone
with an x86 system take a look and confirm exactly what's going on with
binding these cards please?

--uwB7x3tnyrZQfZJI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9I/EACgkQJNaLcl1U
h9CXiQf/ais5lfLk5aThXWHOcT4Aeoa0gV56hJp1nZlMrEqb1NJ2cJwcbJhJK3mR
tHznZeav6m+nItDv0/qwQKuu4XAI/A2WVQl52w6aBQUoVyJhDTIowkxRg1IHQzyf
y549gsvaqYW9OU9L0wPMIIqCJWXuTmpdSRcw7VlAqNB4SOQAGKDZpanAQzFOETg9
7mqSDTDrROwt0kK7PXkQrtfYwb8FtpYZKJvq/siY4oKM6trowrVn73qgLLWLHhsc
pWk3oqcr+6q+Yn1S46FoAxNoi3fq1qhXopSxXi+jJWQ1MNQOWijIMjYQfn8qCSCc
YqnhYw4TVD84O6dU0crP6DRw6pkbnA==
=jct2
-----END PGP SIGNATURE-----

--uwB7x3tnyrZQfZJI--

--===============5255498058445700871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5255498058445700871==--
