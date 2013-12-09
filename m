From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] dma: Indicate residue granularity in
	dma_slave_caps
Date: Mon, 9 Dec 2013 17:13:15 +0000
Message-ID: <20131209171315.GV29268@sirena.org.uk>
References: <1386519489-1935-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2017369964686965432=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6299026172C
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 18:13:25 +0100 (CET)
In-Reply-To: <1386519489-1935-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2017369964686965432==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fbglzKaagM3twbm3"
Content-Disposition: inline


--fbglzKaagM3twbm3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 08, 2013 at 05:18:06PM +0100, Lars-Peter Clausen wrote:

Please word wrap a bit earlier, you're right at 80 columns which causes
issues when quoted.

> ALSA period pointer depends on the granularity of the reported residue. E.g. if
> residue is only updated once every period this means that the position in the
> buffer from/to which the hardware is currently reading/writing could be
> anywhere between the reported PCM pointer and the reported PCM pointer plus one

Since there's quite a bit of development going on with the DMA stuff
it'd be good if this could be merged via ASoC (either itself or as a
shared branch) so we can get the ASoC changes in easily.

> 	* BYTE: Same as BURST but with a byte level granularity.

> I've only included the last one for completeness and I'm not sure if we really
> need it. Even if the hardware is able to report the amount of transferred data
> with a byte level granularity the lower bits will not carry too much
> meaning. When using burst transfers the lower bits will remain the same for
> longer periods and then rapidly increment during the burst transfer. The upper
> bits though will increment with the actual frequency with which the data is
> consumed. And that's what applications are typically interested in.

I share your concerns about the usefulness here, and once you get to
this point you're starting to worry about if it means bytes on the
device side or the memory side which is really angels dancing on the
head of a pin sort of thing.  That can apply to burst sizes as well
where it gets a bit more relevant, we might want to say which we mean
there (I'd assume right now it's just the same as our current burst
configuration) if it even matters.

--fbglzKaagM3twbm3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpfooAAoJELSic+t+oim9czMP+wcMzA83BHewVhXBlbAaMz+B
8LZhrAHQifwgoiwvp3+icm8KryGSRF2pyP3EEuIHRJK4j+PYLlDs5LsnjOpMr9s3
Hm61O1/tfrG7OhPW5lj45udZ+Of/qQt5s30Wx/0Lf/51VnlFZHjnY8ddDJ2qX9cW
wuXtgGzVFdgHuNkSnHJSh+m/qwrI6e0yu6CvMdzldjAHNYpNqCrrcWmx3FDXjVvr
7KTPjfVdY7Jf8pTmJAOau94wS7gN6TvN7b0NrX/S5zpM6/Yzbj1vsaeE6/9lWwQu
vLgQKV7ePlh9PKig0KhXinvGXCGG965cjMv5y+z65ZtLyLF/nLt0HoignZEMgJmk
t1jzPvYvMirFepZH/VyBHTAxQ46XTP2L0CRE6JmgStIuQ0Wox1Ji1pZRMfbNPf3w
Gb2TMjP05a1YWmQV/CqX52Rq8eknszKutx9AuT8EJuq8ROiUh7yBkO1UizcqonKW
+Iti3IolVddemvn8EUdNXuJ4X//OoaPLn2IOVjxP+/m7+C+kqzVsKufYLLNuZHVC
dC3/nyy0Jvwq2eIehccmYsDelw7f4R6/2tVJB5mfZPUTxsK6uW5WtpsIDGREaURU
AJJ1ClFXebLFjAlyTAphwIA+xtP3m6KC4yJxrTvr0vnG+eJZQA9cF2DkNRgAwDwk
nP9YPUTO/Wwhccf40R1o
=RmwX
-----END PGP SIGNATURE-----

--fbglzKaagM3twbm3--

--===============2017369964686965432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2017369964686965432==--
