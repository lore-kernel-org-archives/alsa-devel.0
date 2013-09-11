From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2][RFC] ASoC: simple-card: add Device
 Tree support
Date: Wed, 11 Sep 2013 11:12:14 +0100
Message-ID: <20130911101214.GK29403@sirena.org.uk>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87eh94xab2.wl%kuninori.morimoto.gx@renesas.com>
 <87d2ooxa9o.wl%kuninori.morimoto.gx@renesas.com>
 <87ob80i45a.wl%kuninori.morimoto.gx@renesas.com>
 <87li34i41w.wl%kuninori.morimoto.gx@renesas.com>
 <CAOMZO5A7jByAmXKp6=gy+oJRcCzhGXyn7sT=zpK+crqpiiTWiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4642835373473270628=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 44CBA261703
 for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2013 12:12:24 +0200 (CEST)
In-Reply-To: <CAOMZO5A7jByAmXKp6=gy+oJRcCzhGXyn7sT=zpK+crqpiiTWiA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4642835373473270628==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TVV7VGRNo/84vqgt"
Content-Disposition: inline


--TVV7VGRNo/84vqgt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 10, 2013 at 09:52:12PM -0300, Fabio Estevam wrote:
> On Tue, Sep 10, 2013 at 9:40 PM, Kuninori Morimoto

> > +       simple-audio,codec {
> > +               sound-dai = <&ak4648>;
> > +               bitclock-master;
> > +               frame-master;
> > +               system-clock-frequency = <11289600>;

> Wouldn't it be better to pass a real clock here instead?

So, ideally.  However we have to consider the fact that the clock API
isn't reliably available makes this harder than it should be.  Even
among the DT using platforms at least PowerPC still uses a custom clock
API.  We could just use this as a carrot to push people to convert
though.

--TVV7VGRNo/84vqgt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSMEH7AAoJELSic+t+oim9D1wP+wYdAKo0b1SIOF/O4oWC3Dmk
byirYGSttdNWgQd77tnxpgyTROtr/FwLsbg3tTHazxeXHXvwWQhMk7DhKB6mqcBr
JYVIJQT9tHqgABbIlJeH2LxszW2P8nonqMoYfVcUrFvtUU9hP8ZDSQAiJBn9rqEc
giEiz47rogz9ZUqi+tM5I1YEuh+UQeMCVSqApCipCXc/3qFITVzYIp7yQcuEB3R7
zZT+S3T+wmyV9vb0edfsw6mUsxccFgbjjawdl3YBHKBzGhuT8TOGi9nnQBp4Qvy3
tfOvgM2T3V1TQ2KipSBa2sVMuPHUj9WmEVm4UBNFOuA5RVvKxy3TVn79sWoiRYrr
j/+ag5ROUIQlTMflJLIBt7eMTLHszCrWnuhx2MlnC8TpP9TCfuAn0m+5yljT1EFN
WUntixPGjg9rwxLBF4226cZyd1GIF9rCs7th5seCH0Or1fGcZWVGmhKSVK50I5Md
TiNEyQiiXh5sTNd0v8DLe2ypogCj882c2ZNoaX9iTYhYyGEi8TwQLA6C8NrKD0vr
tCiaephqfHGmxUyoroVcR7Fj1og6Yn42fA65Pv3f8BMymbbRbmpl3AwqzK/WXz7r
qJqmTr3xi3/TFEFxZN4/CP4x/0+D4gMDGVuWwcqpSg8KgeNXS8fjCcszn/WUxMRu
2I6o4ojFDeeG/TZz9iuw
=E9uI
-----END PGP SIGNATURE-----

--TVV7VGRNo/84vqgt--

--===============4642835373473270628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4642835373473270628==--
