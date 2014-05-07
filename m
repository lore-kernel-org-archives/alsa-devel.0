From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Wed, 7 May 2014 18:21:13 +0100
Message-ID: <20140507172113.GI22111@sirena.org.uk>
References: <1397455170-2701-1-git-send-email-bardliao@realtek.com>
 <20140415120428.GU12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC302@RTITMBSV03.realtek.com.tw>
 <20140416211145.GC12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73AC511@RTITMBSV03.realtek.com.tw>
 <20140418103715.GJ12304@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73D68A0@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3542372015094908977=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73282261AE7
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 19:22:09 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D73D68A0@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3542372015094908977==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/KyuVX2Jeo6C4NIo"
Content-Disposition: inline


--/KyuVX2Jeo6C4NIo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2014 at 12:04:27PM +0000, Bard Liao wrote:
> > -----Original Message-----
> > From: Mark Brown [mailto:broonie@kernel.org]

As I'm fairly sure has been requested before please fix your mailer to
word wrap within paragraphs, it is very hard to read your mails since
the lines are longer than 80 columns.

> Virtual controls assume there is no related register related to the controls, so codec
> doesn't need to set anything when the control's value is changed in general cases.
> But rt286 need to do something when the control's value is changed especially mux
> settings.

...

> Do you have any suggestion for setting corresponding registers of a
> virtual control?

Please extend the APIs for virtual controls if you find they are missing
things you need, they've not been widely used in this sort of context -
I think this is the first substantial device anyone has tried to merge
without a register map so it's likely there are gaps.

--/KyuVX2Jeo6C4NIo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTamuBAAoJELSic+t+oim9SSUQAIRIcTSQguB8DEypFmVPxBtc
tca0DqTX/UyP96i+NpZ5+ki/HMVJuwedo7ZC8H1FEFZ+obPMQhZALkA+8rfmZ/hc
JNrEWMvD0b+HCu6n73AsE4XFKykdRldyWfdHUW1kWvSbgplwD/vNlr9/OFDsAGpz
qkiQS+Tw3xTVG6Oz8CPVn/rLMjFD9+5zNtY3YhpxBuaENIuYuYbIk+a0jZOSuHTX
7QR8N0L2yZg/VlL1A0bjDKxtqpa1Hob+i6cjrdvQV63L9LxJm+h54WFLMWzDG6bk
eOIfEHyNcvXlYd/F/X58DlcIHg5kBvo2fh/mW6cEWoqaSFdZyXChTr9cuXWhE5xL
veRzrZY+MZuCzp2m7n1b8rv8RWkfGpHdl6pN9HgO7cS7LIFYxt1Mn20HVGl0v3us
47QxRDQJ1dClMS+E5hQHJea+SIp26vmt/QCZxjMQhH4mStoypsu+Dk5tCT491s6S
Jk0GPcck5WUx74onkblKS9c17quHsJ97WzmsV2s+2uXTKJ/Sw8YDVja5rNh9R7xC
NxqzTR5r/EAKr+xEF44+67et2DrTktGxi4ZzmmTe+lbfAvGRCY9WhtqCRDjmKV5L
lHxdgGgjPZBZGU2Rk3p2eBFcF2EcAgsSLfnVb0BBAM1qN4WUI6II4wVviy46IbV8
esx597PGSbibCHp0x0yt
=QWv9
-----END PGP SIGNATURE-----

--/KyuVX2Jeo6C4NIo--

--===============3542372015094908977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3542372015094908977==--
