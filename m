From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/13] ASoC: generic-dmaengine-pcm: Clear slave_config
 memory
Date: Thu, 7 Nov 2013 11:36:11 +0000
Message-ID: <20131107113611.GV2493@sirena.org.uk>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-9-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3466782868241986982=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1383732985-18928-9-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linus.walleij@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3466782868241986982==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L7QcuKEPlEDqpLxW"
Content-Disposition: inline


--L7QcuKEPlEDqpLxW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2013 at 10:16:20AM +0000, Lee Jones wrote:
> We currently assume that the DMA Slave Config will be fully populated
> by the platform, however some DMA Engines make decisions based on zero
> (default) flags such as DMA_SLAVE_BUSWIDTH_UNDEFINED and as this is a
> static declaration we need to memset it to clear the data area.

Applied, thanks - given how near we are to the merge window the whole
series isn't going to go in for v3.13 but this ought to do so.

--L7QcuKEPlEDqpLxW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSe3soAAoJELSic+t+oim9oMoP/jiczpygUVwN4NKHW6y4HsEs
9Zlb0PM6MhSJ3tME3rrqeqVgXx3W3YEEh5QGzzaBO0JxBIobwBjNuWrZPRW5T/qO
jAj2R+c0Q+Fy5FXuFebsa+9DaQA2gI4Zh/6UXVWhPmKqNWJirViId+HKX7XtQUAg
/lv1c+myIju/yRa72ftQhTN4WlfVadr12VqjbNZMUtF22opQm68Jl1+Nuiv4I665
xBF4ekFCQvG80p4jo6OZeiR0rkuOYE9JWXBWLrTLCHuLtVxhYUQ+8EkUdd82hzy1
kLS7fGfluQ749xUuQev/vvvnKUkYL/4xeyDrR2JFOUOE9I0Z7fclaLXH+Tnsc72M
UEKy7d3lQGepxP4/ufQ92k4gTdFN+HObp0PZYjwxTC3FS6FOYlBznYkmVLbF5PYz
Qoc1qNfyLxoh+eSS4QpcT9EA9/NbisIS7MuGx1WuV8NcWrEy4LzWCIrWCGz8Cnzm
rYtRfogWPuYWErAKR9OLbWNWgNmr82HHjXx7X6aQ+ZUmQhzni5zjDG1e97StgmnX
R34Yz4/0GHR4pls0YrpxLpH1bJKBFZ66ppWfU9YwqabRhHfqHILvCGfk5+iVDgZY
dTYXf1QxTGZQnBeQ8nS9e1QgyYU568U3ZGxbN0Rr+nX1QnaZGnFzqiNstQZgXOpc
XwYo8Pnbi7K8LDv+Qfjr
=Y9mU
-----END PGP SIGNATURE-----

--L7QcuKEPlEDqpLxW--


--===============3466782868241986982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3466782868241986982==--
