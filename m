From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix the channel swap issue after xrun
Date: Thu, 23 May 2019 09:53:42 +0000
Message-ID: <VE1PR04MB647934199C3AA60759BED888E3010@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi

> > +     /*
> > +      * Add fifo reset here, because the regcache_sync will
> > +      * write one more data to ETDR.
> > +      * Which will cause channel shift.
>=20
> Sounds like a bug to me...should fix it first by marking the data registe=
rs as
> volatile.
>=20

The ETDR is a writable register, it is not volatile. Even we change it to
Volatile, I don't think we can't avoid this issue. for the regcache_sync
Just to write this register, it is correct behavior.

Best regards
Wang shengjiu
