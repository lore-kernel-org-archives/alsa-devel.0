From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: cs42xx8: Add regcache mask dirty
Date: Fri, 17 May 2019 03:11:42 +0000
Message-ID: <VE1PR04MB6479CA711EF5D796EEA9DA55E30B0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>, "brian.austin@cirrus.com" <brian.austin@cirrus.com>, "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi

> Add regcache_mark_dirty before regcache_sync for power of codec may be
> lost at suspend, then all the register need to be reconfigured.
>=20
> Fixes: 0c516b4ff85c ("ASoC: cs42xx8: Add codec driver support for
> CS42448/CS42888")

The Fixes tag is split, will send v2.

Best regards
Wang shengjiu
