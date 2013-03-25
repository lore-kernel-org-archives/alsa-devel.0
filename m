From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: imx-sgtl5000: use of_node to match
	cpu dai
Date: Mon, 25 Mar 2013 10:22:47 +0000
Message-ID: <20130325102243.GL18316@opensource.wolfsonmicro.com>
References: <1364181552-29521-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7486420294387390313=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9DB11261692
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 11:22:53 +0100 (CET)
In-Reply-To: <1364181552-29521-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7486420294387390313==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KIbT1ud6duwZIwNL"
Content-Disposition: inline


--KIbT1ud6duwZIwNL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 25, 2013 at 11:19:12AM +0800, Shawn Guo wrote:
> Since imx-sgtl5000 is only used on DT platform, it makes more sense to
> use cpu_of_node rather than cpu_dai_name to match cpu dai.

Applied, thanks.

--KIbT1ud6duwZIwNL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUCViAAoJELSic+t+oim9KFAP/jAuJGb11Yn70L6pQ5EkcehA
mQSs05sD0gWoAxxwIqzYcSP3yXqe+w2ImeTFfU0vfDthGcIxIrgPW91jz8sQTh7n
ngYS1SZmzq4KDbwi+vOjsQmhwbaVv4VY9MqkPORZywDhHbseEKVjxEw+D8xGVXxk
VZpPaRZkBhhg6kfk8sjUA6zXrpThlmyEa6jlxfI0tqFIvajqlwiU2Es1UEbKCSD/
Zlec40L81jCIOWEFwLgaFzgGeGQi0JGUGnzDZp4ifVAiEwGF5zaZbRxBxbODilHl
X9nWetjdsuovpSeXoDc10RuZXKLBXTwcLMdyYtGDlvHUXjpNEeA1eS/fThaLrbMT
QB3GBYMMPi38AHkG7GsQlhH/2goo3fF1ipesH6r5Dm2BTnDFKxKtxeOrBShc02bF
5EEUgsLpyLlDu78wVUqx4coSMpIZwyePT1zctPJB/lxHU8Nv6ve8s9xE9DU1ssOO
L1KEEEsxc7ynOCyN6VxLLVMmotkyyck63OjU66vcVOuGPPwoq+VpXk/XnAl/E2wg
4DRBVelYYLwx5Xzp3dlKSyAFVxtJrxwVlGRVlVOffvc853WlcvSyrHw+lwwUrPE0
DidRoC0IZlO+WzKAu5yTb4Pal2AWRf8h5FkwTiOKtTOFTrqhNmesRu7CZlaLveRF
Km0Yo4FD4Be6hkG/Kbj4
=ZVMG
-----END PGP SIGNATURE-----

--KIbT1ud6duwZIwNL--

--===============7486420294387390313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7486420294387390313==--
