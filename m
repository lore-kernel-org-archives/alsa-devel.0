From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: mid-x86: Remove redundant
 platform_set_drvdata()
Date: Fri, 3 May 2013 10:37:27 +0100
Message-ID: <20130503093727.GK4945@sirena.org.uk>
References: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
 <1367572164-19523-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7849856339672835854=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 2478926530A
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 11:37:43 +0200 (CEST)
In-Reply-To: <1367572164-19523-3-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============7849856339672835854==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bX/mw5riLlTkt+Gv"
Content-Disposition: inline


--bX/mw5riLlTkt+Gv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2013 at 02:39:21PM +0530, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.

Applied, thanks.

--bX/mw5riLlTkt+Gv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRg4VUAAoJELSic+t+oim9ghgP/iHkcH/OtyEgCLkBOwP044DB
ZMRLdlABhan0ihy55tox9jlMzIyFWSQqcJS0oOsdDWZfCH52cyaC2Emdv+oSNHmX
sQJxsYgNdxLOd/eF2lrk+FDM2vVmk7TGgNaNRjXDVTaFXOQfp+AOCSFxI4aveBAW
x/h2YY26XIK791Qjgq3C3uKDe/I3eIiB1kHoHG8WAU8dpjYpverPbKJr9Fba28PQ
/+uYQoSXZ21JdX/M7U4zUj9yU5xXmvKm1dvxVCkSZwK3iuDl9aRO+Mci+xcN/xY/
+f8vTe28PdmlZj3PqfXBiFdJcnt7o+ejmv268TFrnwzyOTcYXgULbFWUCZy4yn3+
AC+mf00FJUqiAZgP3A3xkMqocw07tjf7fWuodNBY6wVTNPCDOdAJvibIUQDsadDY
u8QWk/8Oj2Shd4QCTw5Nd8KYhDffy5+dhkJ/STqpGQ4REL/JygHdg/z1XL8bxYnN
+3C5oQR9AIGUKzi4k+DbNU5ICwE/Hnn0+RGjmqTxK1Tvv6HfArVvx+JrNEdvWrIS
DTB9PIeDwr7Xkvhf0PcQjUNNrlzLCVJlDIDhhimIE0gqZsLUN9EWCgsW/dY3neSz
6HFeA9BrDycDauUfRSRa/+r7aMAm+dDfTi5B+5lt+kEfsNZZp+3WSce02n/39fPu
faMLI4Tm3LqMyaxlZzA+
=vQR8
-----END PGP SIGNATURE-----

--bX/mw5riLlTkt+Gv--

--===============7849856339672835854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7849856339672835854==--
