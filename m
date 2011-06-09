From: Sangbeom Kim <sbkim73@samsung.com>
Subject: RE: [alsa-devel] [PATCH 2/4] ASoC: SAMSUNG: Add I2S0 internal dma
	driver
Date: Fri, 10 Jun 2011 08:41:45 +0900
Message-ID: <04be01cc26fe$cb08ec10$611ac430$@com>
References: <1307606950-8310-1-git-send-email-sbkim73@samsung.com>
 <1307606950-8310-3-git-send-email-sbkim73@samsung.com>
 <BANLkTikUe7MV7EHc7CN4WECs0oLrQBAs4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <BANLkTikUe7MV7EHc7CN4WECs0oLrQBAs4g@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Kyungmin Park' <kmpark@infradead.org>
Cc: alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org, jassisinghbrar@gmail.com, kgene.kim@samsung.com, ben-linux@fluff.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 9, 2011 at 9:33 PM, Kyungmin Park  wrote:
> > +#ifndef __S3C_IDMA_H_
> > +#define __S3C_IDMA_H_
> > +
> > +#ifdef CONFIG_ARCH_EXYNOS4
> > +#define LP_TXBUFF_ADDR =A0 =A0(0x02020000)
> > +#else
> > +#define LP_TXBUFF_ADDR =A0 =A0(0xC0000000)
> > +#endif
>=20
> Are there more fancy way to define the internal DMA address?
> Are you sure new EXYNOS4 series will use the same address?

I'm not sure that the new Exynos4 series will have a same address.
I will try to find more fancy way to define idma address in the next
version.

Thanks
SB Kim.
