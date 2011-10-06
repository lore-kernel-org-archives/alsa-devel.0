From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [RFC][PATCH v2] ASoC: ak4535: convert to soc-cache
Date: Thu, 06 Oct 2011 15:11:18 +0800
Message-ID: <1317885078.13399.22.camel@phoenix>
References: <1317884726.13399.19.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317884726.13399.19.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Richard Purdie <rpurdie@rpsys.net>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

=E6=96=BC =E5=9B=9B=EF=BC=8C2011-10-06 =E6=96=BC 15:05 +0800=EF=BC=8CAx=
el Lin =E6=8F=90=E5=88=B0=EF=BC=9A
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> v2: Set codec->cache_sync =3D 1 before calling snd_soc_cache_sync().
>=20
Pls ignore this v2.=20

After commit 7be4ba24 "ASoC: Mark cache as dirty when suspending",
The soc-core will set codec->cache_sync flag now.

Regards,
Axel
