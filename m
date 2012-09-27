From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: ASoC on today's linux-next: dma_alloc_writecombine() failing
 at least on OMAP platforms
Date: Thu, 27 Sep 2012 16:25:22 +0300
Message-ID: <506453C2.4030905@ti.com>
References: <506443AD.1060201@ti.com> <20120927125934.GV4428@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20120927125934.GV4428@opensource.wolfsonmicro.com>
Sender: linux-next-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood, Liam" <lrg@ti.com>, linux-next@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/27/2012 03:59 PM, Mark Brown wrote:
> On Thu, Sep 27, 2012 at 03:16:45PM +0300, Peter Ujfalusi wrote:
>=20
>> Can someone try linux-next on non OMAP platform to see if
>> dma_alloc_writecombine() works there?
>=20
>> Meanwhile I'll try to find the reason why it fails for me.
>=20
> Do you have CMA enabled?  There seems to be some breakage there for m=
e
> on Samsung platforms, I saw this affecting all DMA users yesterday al=
ong
> with some other CMA related issues but didn't analyse it enough to
> report it.

I do had CMA enabled (not sure why) It has been enabled in my config fo=
r a
long time.
Without CONFIG_CMA all is fine.

Thank you,
P=E9ter
