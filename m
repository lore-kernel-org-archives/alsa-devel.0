From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: sgtl5000: clean up
	sgtl5000_enable_regulators()
Date: Tue, 17 Dec 2013 12:46:57 +0000
Message-ID: <20131217124657.GW3185@sirena.org.uk>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
 <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
 <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131216112910.GB30671@S2101-09.ap.freescale.net>
 <20131217015939.GM3185@sirena.org.uk>
 <20131217021610.GA7172@S2101-09.ap.freescale.net>
 <20131217113705.GP3185@sirena.org.uk>
 <20131217123946.GN6691@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1684094695941018945=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 637FF26109E
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 13:47:03 +0100 (CET)
In-Reply-To: <20131217123946.GN6691@S2101-09.ap.freescale.net>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============1684094695941018945==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="90dcdHIige6KdqvY"
Content-Disposition: inline


--90dcdHIige6KdqvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2013 at 08:39:48PM +0800, Shawn Guo wrote:

> Hmm, I do not quite follow.  The regulator core needs to know whether a
> regulator device is present or absent, before the regulator is
> registered, so that regulator core can decide to return -EDEFER_PROBE
> or -ENODEV when consumer calls regulator_get_optional() to get the
> regulator.  Are you saying platform can call
> regulator_has_full_constraints() to help regulator core to make this
> decision?  I do not understand how it works.

It tells the core that it now knows about all regulator mappings so it
knows if it's not got a mapping none will ever appear.

--90dcdHIige6KdqvY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsEe9AAoJELSic+t+oim9FuEP/iDAv2fp7bVn/6Yk+R+vAjWU
dO+WIA3FDFbzWFQuU8Oy70/ErXzJekmO68z8c46RTAIVCz5FCpgxXYoPi7gNWXyi
D4MFca3QDywh0RcRax4xzAEM72aGIEnRstD+agWZSRr2l6+QtK4Z/S2SRAjfTWFQ
8xB1T2AyxMdKwTkOkM0zm5ent/1RxmybjQdJHoXEPs53l+YhZ50lYASRVGRtIbon
0wqhXgej5O6/SLgr/KtMcqsNTtL171AK5rcBvaBzUzQBmTna+n7kKVpBockxm3V0
VisL2IbqZtF5C8kzjGfF0V+u7WTaGDXF8kOCKY+Dzjjeu7I4uhtxU/LrglA/zBCz
A1xsS1h4xNXGkVQ4c2cyeBnufqGmYg1oYcWLDAp141XDhg9QgpgeSzFf447mnHx1
vnfcJ+4xSfaEmrAIhr6dL3Y6LfFjC7ogKBtH+54bkqCOIwm+nk1/WGolCOSCc4I2
0pYpq5Fi8lxmU53FH3dgtjAdCqD6traNa/eBhU9CJGv4v+ay8kqOHHUOrKLUWOcY
gQYML28db0VpiEEhI6NNzGhnuPEYhlEBw6vqtfGQSNS0I0jIE/iptwtdiZxDE1H8
7ek8480gxIRxBD8/pfbzF8RV2YU6+PpbvLoMllTbefkZPs0wi0glUJ5Hw+prVBUN
fs+W0Wil3k8h4lOTLLkK
=xNXU
-----END PGP SIGNATURE-----

--90dcdHIige6KdqvY--

--===============1684094695941018945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1684094695941018945==--
