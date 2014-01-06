From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 00/11] ASoC/MFD: twl4030 codec local register cache
 removal
Date: Mon, 6 Jan 2014 16:10:01 +0000
Message-ID: <20140106161001.GJ30156@lee--X1>
References: <1388755676-16036-1-git-send-email-peter.ujfalusi@ti.com>
 <20140106131920.GT31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140106131920.GT31886@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 06 Jan 2014, Mark Brown wrote:

> On Fri, Jan 03, 2014 at 03:27:45PM +0200, Peter Ujfalusi wrote:
> > Hi,
> >=20
> > After the twl6040 codec, now it is time for the twl4030 codec drive=
r to loose
> > it's local reg cache and let the MFD core's regmap to take care of =
the caching.
>=20
> This all looks good to me - Lee/Samuel how do you want to handle this=
,
> are you OK with merging the MFD bits via ASoC or something else?

Are you planning on taking this in for v3.14? Only we're on -rc7 alread=
y.

It also depends how closely knit the MFD changes are to the ASoC ones.

Are they completely dependant?=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
