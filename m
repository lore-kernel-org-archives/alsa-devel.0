From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: codecs: Enable AB8500 CODEC for
	Device Tree
Date: Tue, 21 Aug 2012 14:40:13 +0100
Message-ID: <20120821134013.GG7995@opensource.wolfsonmicro.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-9-git-send-email-lee.jones@linaro.org>
 <s5h628lu0q9.wl%tiwai@suse.de> <20120820113427.GN8450@gmail.com>
 <20120820143653.GE26991@opensource.wolfsonmicro.com>
 <20120821115123.GE26899@gmail.com>
 <20120821123951.GC7995@opensource.wolfsonmicro.com>
 <20120821125811.GA931@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2542874568855073082=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7D68F265B59
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 15:40:15 +0200 (CEST)
In-Reply-To: <20120821125811.GA931@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2542874568855073082==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2012 at 01:58:12PM +0100, Lee Jones wrote:
> On Tue, Aug 21, 2012 at 01:39:51PM +0100, Mark Brown wrote:

> > The bit I quoted is the main example, you're including random mail
> > headers in the body of the mail.

> They're not mail headers per-say, they're `git format-patch` headers.
> I thought this was acceptable for single patches, hence why I've done
> it lots of times and had no complaints (until now).

> If there are some changes required in a single patch, I usually fix
> it up, create a patch with `git format-patch` and send it as a reply
> to either the original patch in the series or the mail containing the
> suggestion. If this is wrong please educate me as I thought this was

If you're going to do this send the patch properly in the same way
patches are normally sent.  Take a step back and think about this for a
minute - why would it be a good idea to send these incremental patches
in a different format which requires the person applying the patch to
hand edit things to strip out the noise?

> acceptable, as I thought it would be less pain than sending the
> entire patch-set again for just one change?

It makes it harder to work out which versions of things to apply and
causes issues for tools when doing things like applying from a mailbox.

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM4+uAAoJEFJkBDiqVpZ4zPMP/RQ2saQWRmxUdo181YJH4oci
sNDM35Hhhc+mW+hIfvgX0dJIqCLFW7iS1Xek5vLtlcuM3xURL1w/uJPJIonBD9QR
rla7XOs5LLZlD9u2I4cEzzGRoK/JhrZHuhbdAGcfd0jufnbCBPTgIEwnUHNNkR4I
VdgAAmKhkdqp1qT7+WjJmtfSS/KOMTWcKwFzPdPXV41o0TSpBiXKs8EaGp8goX8g
0AAUhV5JzwpfRA7oXVDIgN2iZOyae90PIPldhFhKg4jm9DJtqaftjP87+KW8b45P
hAXeIpsGZwPnXr5v+PEOLbfA4tVEzN8yWl7C7c3zl/zZPLQmpsv3UvHNU0TA0YF8
NNmj4rIchhOPHVpbG7F84fZi426VynS1K681MOXQFqFecIBJpeyMgl/w/MINZlrU
fuqm78fdOs4Vtp5GdQGDBSQW4ZZYKu5z0ap0Pj2TUr4VBettVZJTyAzftgNrv3OC
0FA77r8FvvlKskD6D6QVS+pPn+5/8uDENAkAK93ds7InJS0AK88YbMfiH/pNwQEB
ZFOQe0ojJ3oMGN+7OPLKJIjClLdJJrAyqkCdF5R8HkzhMqdVrm64WSUEH+VIubVn
Y7aTan1xUVcboX3i5G9QFi3L91q95Wfqvu6eqgLQ7rTWl60PbmecWh08Xf3rnlg5
KasLmCIPEIWX3iAsvvfV
=ied/
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--

--===============2542874568855073082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2542874568855073082==--
