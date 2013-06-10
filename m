From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Use
	i2c_get_clientdata()
Date: Mon, 10 Jun 2013 15:23:55 +0100
Message-ID: <20130610142355.GC1403@sirena.org.uk>
References: <1370870682-10243-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1268162555869876843=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 691BE2616C1
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 16:24:02 +0200 (CEST)
In-Reply-To: <1370870682-10243-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============1268162555869876843==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2013 at 10:24:41AM -0300, Fabio Estevam wrote:
> We should use i2c_get_clientdata() to get the codec private structure.

Applied both, thanks.

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRteF4AAoJELSic+t+oim9qisQAJqsYdB9OYadwQb9ZiSMQDLK
M7g+HSqDFRh/o1rpUUDGv1rPRgiPiMCRXbbtKfmyj4GnXxbz326L3Q8iUZ6ImRfL
8rCk/bTFk0y6rYSn0YnCmdkqhtvvW+woqxjRdUPLiAEIf4HdhADIT4iZ3W8EEGkU
hcqfLeu7PU9D8kQYi2kbYge8QWIOaSIrYnn2hV2wMHWWjsbOvegZv+9pcX1eA8SO
eONB6cq2Abdd4POsiViyqy9wgcXHhidYH/KlsYjobfCGoSiB8H1fAZI5kbhhKsou
qQCsb7jR1GlamFCUpwEGM0EwAvtCtAJ0RYIltTK3PxgVmNfqHOXvQixdNectQXFE
WQY8e1IbqNMMW3L+GdP1YLaBdrBI2LRY1KhOwaiLF/Mc9X+IvpwDWFltAY0ifanA
TYbd49N+GYqATl38L5VnG2wjVV0Co4yIeFbHdvC7zsyQzhk8IwTUK6kVLGsSDMa7
MCwBKXXJW22TbAaMI01hhIiJ8qod+rEey590o0eleBfXMTHIwfbvWa9sefUyndfu
t08Fl6CixzhQ1toETmfsRXECn6qr4YR+PoiPGp11Jp3CkykHa6NX16xdZfiAcep1
7InAQvDPi42XiuFQJpFwsdmqhKT2FWYhTPazr8yigu3en8pxRj58DvG5uYc67hJa
8d7rakuDlT2uH+GhO1ro
=xklk
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--

--===============1268162555869876843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1268162555869876843==--
