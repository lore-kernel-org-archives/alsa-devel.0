From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Ensure we generate a driver name
Date: Wed, 21 Sep 2011 13:41:21 +0100
Message-ID: <20110921124120.GE4374@opensource.wolfsonmicro.com>
References: <1316524563-22407-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CAHG8p1C28+d5NeyxQ0zCPAqgQ5ZtBNej+Az3PTnNFr==o9Ls=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3D3962448D
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 14:41:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAHG8p1C28+d5NeyxQ0zCPAqgQ5ZtBNej+Az3PTnNFr==o9Ls=A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 21, 2011 at 01:09:30PM +0800, Scott Jiang wrote:
> 2011/9/20 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(card->snd_card->driver); i++=
) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (card->snd_card->driver[i]) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case '_':
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case '-':
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case '\0':
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!isalnum(card->snd_ca=
rd->driver[i]))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->snd=
_card->driver[i] =3D '_';
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }

> If '\0', we should break out of loop?

It's really not worth the code complexity, we only run this once during
probe and the array is fixed size and small.
