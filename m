From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 21/23] ASoC: qdsp6: dt-bindings: Add
 apq8096 machine bindings
Date: Wed, 25 Apr 2018 17:21:41 +0100
Message-ID: <20180425162141.GG24769@sirena.org.uk>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
 <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
 <655a593b-021c-3bf2-35c2-eb77cb0a4b95@linaro.org>
 <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4545431337761465758=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C861426772B
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 18:21:45 +0200 (CEST)
In-Reply-To: <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>, rohkumar@qti.qualcomm.com, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Patrick Lai <plai@codeaurora.org>, spatakok@qti.qualcomm.com, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, David Brown <david.brown@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gross <andy.gross@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============4545431337761465758==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kjpMrWxdCilgNbo1"
Content-Disposition: inline


--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2018 at 10:04:54AM -0500, Rob Herring wrote:
> On Tue, Apr 24, 2018 at 11:49 AM, Srinivas Kandagatla

> If you don't have the values, then how does one validate a DT is correct?

> Honestly, a single property like this seems insufficient to describe
> audio routing.

It's perfectly fine, it's a list of source to sink mappings which can
handle any set of N:M links.

--kjpMrWxdCilgNbo1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrgqxQACgkQJNaLcl1U
h9DELAf/bORYkD4n6wKwrpVkFfB9Xu31idq7TNuMrLMWf6VecnyTH8rYs9U556Ju
sS21UxQb4ogZ3cVAT8gq1ZRWPDbovgrbkWoVpXo6CFYzEZQA3x1MUDCJbb4w4tvg
DuN0TN1xlwIcdeKR+uGItmSepTcuqgCpCVklDTSPNr6yRMtfRHsAg3YBb8HCle0M
kDUTxt6tJ0lHd9O+z8zLUOoYfZWyh74max9hD0GJ6wC/ACxw1k4t9u3c1wRLl2OB
QWbwdukau5ZtSL38ZUQpW4w+bUpbn7aHQc/bb6z70+sPET/e3g/PPK+e8OZmAyAU
9xKbQpMGVLKqPANICZl7GBFGzJ1+bg==
=VFT4
-----END PGP SIGNATURE-----

--kjpMrWxdCilgNbo1--

--===============4545431337761465758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4545431337761465758==--
