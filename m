From: Scott Bahling <sbahling@suse.com>
Subject: Re: Controlling the Tascam FW-1884
Date: Fri, 16 Nov 2018 18:37:36 +0100
Message-ID: <e8df325ccd3984420e90c340b03d93dbae87a520.camel@suse.com>
References: <9cec059e1ff1a558f21a3f0729c5a69a3d506573.camel@suse.com>
 <0e469670-0520-5953-230b-8d2da5e4c357@sakamocchi.jp>
 <985b1f6dc5b0af2aae049e0b6fcf976ab400d34d.camel@suse.com>
 <55afba82-ad24-fe70-b784-d28a38e291c9@sakamocchi.jp>
 <7a0f35eea26ce475bc3f6953db97f83205ad0a58.camel@suse.com>
 <fc278639-12da-02b8-685d-681e06b044e4@sakamocchi.jp>
 <10a99ea9c672ac6d0c9d5536e9d85a15f5a32d95.camel@suse.com>
 <47f66c7d-4337-52da-72da-cdb3f0638dc4@sakamocchi.jp>
 <d63527a1ab830c50c621664946ad9eafdb37d578.camel@suse.com>
 <f4537970-775e-6480-acc4-6b5dd050d597@sakamocchi.jp>
 <fed5ab3a-c39a-4de9-6802-c064a33140eb@sakamocchi.jp>
 <246b8baaa3c415a0accdb76d3b524dec5e0429f9.camel@suse.com>
 <97e54edf-1e47-d422-e438-a2c859083fd3@sakamocchi.jp>
 <58ef33b1fffec178217044e0f0d5f2b6aecfc31d.camel@suse.com>
 <4a971bd3716ddf43662b637904209f5230ccbf02.camel@suse.com>
 <daf2b08b-dfdf-b4a3-8820-0a5f3ab78fc4@sakamocchi.jp>
 <bd6c69dbb0cb7347f9023728a598e65f0b297323.camel@suse.com>
 <d3bdd2c0-1737-cf75-2d7d-53639127ab00@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7079790892524704810=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 03694267947
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2018 18:37:37 +0100 (CET)
In-Reply-To: <d3bdd2c0-1737-cf75-2d7d-53639127ab00@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org


--===============7079790892524704810==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-URUufo7UKzHc3PjwhAjA"


--=-URUufo7UKzHc3PjwhAjA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Fri, 2018-11-02 at 21:05 +0900, Takashi Sakamoto wrote:
> Hi Scott,
>=20
> On 2018/11/02 18:26, Scott Bahling wrote:

> >=20
> > I have tested and the patch above works as expected.
>=20
> Thanks for your check. I pushed the above patch into my remote branch.
>=20
> Well, soon, merge window for v4.20 (or v5.0) kernel will be closed, then
> we start working for next v4.21 (or v5.1) kernel. I have a plan to
> include changes required for the status and control message in this
> development period (not prepare yet) and the changes are the same in
> the remote branch. I'll add you to C.C list when posting patches for it.

Thanks!

> If you require more functionality, please inform it to me in this
> development period.

I have been testing the patches for a while now and they work without
issue. I'm also testing the libhinawa and hinawa-utils code in the
process. I haven't tested the channel level values from the isochronous
packets as I haven't a need for that so far. I see that the data
changes as expected, but I have not verified if the values are
accurate.

But my primary need was the control surface. Between what you already
had hinawa-utils and the kernel patches to pass the isochronous data to
userspace, I'm able to react on all input from the controls as well as
set the fader positions and light the LEDs. I will submit a pull
request to hinawa-utils for controlling the LEDs and Fader positions
for the FW-1884.

Thanks for your help!

Regards,

Scott

--=-URUufo7UKzHc3PjwhAjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQjvzoZ9RLbHiUT/sAst8aI6UpxIFAlvvAGAACgkQAst8aI6U
pxI4rw//WJCiVIHT88fw3Uep/eUPnM9dVn3RHM8VlsU5VuXi4OC7aAEdaswDrl35
gYQTePP/3hkHxiFocVJHTPXQPQfGCwEywRFOD+XHo7NxUKz4BmXq/kjXQ0FrKDNb
omj3qFa2EiURp9nDivBHTUPVsWQ0uHl4pRVaff3B/YJY+c6Mfkbqosu5xOePGZ4s
25+4egwVquxEp5RUNQRVOugwxKFVXlBXczlgoSqsJN9Z57RXLQ5bpdJ0Fk76ohQn
VGV6F3Slb+hYpQg8VJMgaVcYLBdJNdkAhipr6rMug4xa3q3F+zThbrWNTCCiUIqE
yQCqi1SoMz45bKSV2/HPslNsvzfgxmkFNCh2I1fcpoPhrzhG9VHGFvnnSLT5DXE/
tQphQmXQgTWaRCMfnKHyFIlb2izjBPmhPDVSWr3TBmm+LbQb9/QFr8zqfnhtqLe9
xfdTtNGW48fVtNtKPq19OuQCCTkMDiFKNx2L08Dzor09Kr30tRzAZ9pfDwbz0vXV
igWap77SYHHTbQ88raqW44Xmj9UefI9Fvp+kdqcvVQdLsW9fN0LDgSH26oRv+X6B
+qvENAPPhJUn5+cyfE7NBQpPlqJCocxgC+i9s16gDvkjM4nONnPoXufGkJMJbKpC
FHColSpmeGt9A4hoY7nEM5SkorKTfkQocaDc3sTXR409dzdHoZY=
=Ws4T
-----END PGP SIGNATURE-----

--=-URUufo7UKzHc3PjwhAjA--


--===============7079790892524704810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7079790892524704810==--
