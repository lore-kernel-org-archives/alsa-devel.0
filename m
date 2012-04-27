From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/8] ASoC: codecs: Add AB8500 codec-driver
Date: Fri, 27 Apr 2012 12:11:24 +0100
Message-ID: <20120427111123.GD18260@opensource.wolfsonmicro.com>
References: <1334914402-27554-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120423185936.GW8318@opensource.wolfsonmicro.com>
	<4F9A649E.4000300@stericsson.com>
	<20120427093516.GB18260@opensource.wolfsonmicro.com>
	<4F9A7B03.5040802@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1100971463518805329=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4C95B2439C
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 13:11:26 +0200 (CEST)
In-Reply-To: <4F9A7B03.5040802@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1100971463518805329==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 27, 2012 at 12:54:59PM +0200, Ola Lilja wrote:
> On 04/27/2012 11:35 AM, Mark Brown wrote:

> > What are these regulators?  Are they internal PGA supplies or are they
> > microphone biases?

> These are mic-biases.

OK, then why aren't they hooked up in the board anyway (probably fixed to
a specific configuration there, though there are some use cases for
changing)?  This is what other CODEC drivers do with their MICBIASes...

> > Normally the clocking control is under the control of the machine driver
> > and if the machine driver wants to offer any options to userspace it'd
> > provide its own control - usually there's way more stuff going on here
> > than just selecting a source and much more coordination needed with the
> > drivers involved.

> Yes, we are only selecting what clock to request to the clock-driver-code, which
> then does its magic and taking decisions related to the whole platform.
> More specifically, in my context (that is audio) we will act upon being in
> voicecall or not, and in these cases requesting these two different clocks. By
> design this request comes from audio-code in userspace down to the audio-driver
> in the kernel. The clock-code will then turn of the clock not needed by us
> (audio) or any other party.

So what one would expect there would be that the machine driver would
figure things out - usually for something like the voice call case the
machine driver would be doing something like switching to the voice call
clock when the baseband DAI comes up.

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmn6+AAoJEBus8iNuMP3dGyAP/1dLpISDsSYB2ktwVOxy5PGu
53uHiCEFovvT778E36A6b+X6p8MZhiMAyhGIagR33Lx80A1bp9ODXpCNUk543j4B
btXouuVofoNjs/HXmvXu1VaaK7o1Z/HZAE0OjUyLUwCU0QWDpXSSMzCB4xu4cqn5
CZJ0qiP/w53IsGdRIWah6wzIXcVS8Lg2k/v4Ue5b5ieA32OcG/xIIHPavR+LtV1J
RgaM1Nvs56tcskkzwtqUc05WVZuJhEowpBN3xBMe51th3652kFqycQ5Gr3JI/y4H
AJP37AjOH3szhoaPP6qpbwsRcMZg6j32lzA8BgjfrPFP0YuFXG6ClbcIBn6WtIax
Xp1VeQw9m5ovCyHoJjqJP0VAjqIsFfukdGC6fig+7C7unPQ/tqzsFm8PV4Rrzho9
RUVxnKMoKtBnsTAw6Vbt+PuK1gonkor+R81RXyh6izw5iekUXHcpbT6Ost18a1ik
Gewpga58MmSIWPFZXsxf0e+7tAlRLqI4zKP3d9Eci6/6IXjLbtMoUi36jdrLVP2S
bvu+oAbMgMdsRNqkzfFgATerQxDFJpIPjbeEK9CnBsn4Zzc6cFLgmz0VcksATa6h
SP7bJ0MNuEmfUFr/8dsXEbNmzRnW2FCZex2hXnvJ3eJ2C6/mNKicCgd34Cq+stmE
AJExqvhJpfJNw1D+gxzx
=nOeN
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--

--===============1100971463518805329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1100971463518805329==--
