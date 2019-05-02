From: Curtis Malainey <cujomalainey@google.com>
Subject: Re: [PATCH] ASoC: RT5677-SPI: Disable 16Bit SPI
	Transfers
Date: Thu, 2 May 2019 16:58:26 -0700
Message-ID: <CAOReqxjD4DxPqc4rOrZpQHu5+Yn2i07goUg58uXhsaRDpObo7A@mail.gmail.com>
References: <20190502222016.241729-1-cujomalainey@chromium.org>
 <CAEQjanM3geN7us7ZqmGqX_68csCtQK9qwOwrnZ_fCXRgy4QymQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 160EDF8075A
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2019 01:58:39 +0200 (CEST)
Received: by mail-lj1-x241.google.com with SMTP id s7so3818779ljh.1
 for <alsa-devel@alsa-project.org>; Thu, 02 May 2019 16:58:39 -0700 (PDT)
In-Reply-To: <CAEQjanM3geN7us7ZqmGqX_68csCtQK9qwOwrnZ_fCXRgy4QymQ@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ben Zhang <benzh@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 2, 2019 at 4:25 PM Ben Zhang <benzh@chromium.org> wrote:
>
> On Thu, May 2, 2019 at 6:20 PM Curtis Malainey
> <cujomalainey@chromium.org> wrote:
> >
> > The current algorithm allows 3 types of transfers, 16bit, 32bit and
> > burst. According to Realtek, 16bit transfers have a special restriction
> > in that it is restricted to the memory region of
> > 0x18020000 ~ 0x18021000. This region is the memory location of the I2C
> > registers. The current algorithm does not uphold this restriction and
> > therefore fails to complete writes.
> >
> > Since this has been broken for some time it likely no one is using it.
> > Better to simply disable the 16 bit writes. This will allow users to
> > properly load firmware over SPI without data corruption.
> >
> > CC: Ben Zhang <benzh@chromium.org>
> > CC: Oder Chiou <oder_chiou@realtek.com>
> > Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
> > ---
> >  sound/soc/codecs/rt5677-spi.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
> > index 167a02773a0b..b296e62fdbb4 100644
> > --- a/sound/soc/codecs/rt5677-spi.c
> > +++ b/sound/soc/codecs/rt5677-spi.c
> > @@ -58,13 +58,15 @@ static DEFINE_MUTEX(spi_mutex);
> >   * RT5677_SPI_READ/WRITE_32:   Transfer 4 bytes
> >   * RT5677_SPI_READ/WRITE_BURST:        Transfer any multiples of 8 bytes
> >   *
> > - * For example, reading 260 bytes at 0x60030002 uses the following commands:
> > - * 0x60030002 RT5677_SPI_READ_16       2 bytes
> > + * Note:
> > + * 16 Bit writes and reads are restricted to the address range
> > + * 0x18020000 ~ 0x18021000
> > + *
> > + * For example, reading 256 bytes at 0x60030004 uses the following commands:
> >   * 0x60030004 RT5677_SPI_READ_32       4 bytes
> >   * 0x60030008 RT5677_SPI_READ_BURST    240 bytes
> >   * 0x600300F8 RT5677_SPI_READ_BURST    8 bytes
> >   * 0x60030100 RT5677_SPI_READ_32       4 bytes
> > - * 0x60030104 RT5677_SPI_READ_16       2 bytes
> >   *
> >   * Input:
> >   * @read: true for read commands; false for write commands
> > @@ -79,15 +81,13 @@ static u8 rt5677_spi_select_cmd(bool read, u32 align, u32 remain, u32 *len)
> >  {
> >         u8 cmd;
> >
> > -       if (align == 2 || align == 6 || remain == 2) {
> > -               cmd = RT5677_SPI_READ_16;
> > -               *len = 2;
> > -       } else if (align == 4 || remain <= 6) {
> > +       if (align == 4 || remain <= 4) {
> >                 cmd = RT5677_SPI_READ_32;
> >                 *len = 4;
> >         } else {
> >                 cmd = RT5677_SPI_READ_BURST;
> > -               *len = min_t(u32, remain & ~7, RT5677_SPI_BURST_LEN);
> > +               *len = (((remain - 1) >> 3) + 1) << 3;
> > +               *len = min_t(u32, *len, RT5677_SPI_BURST_LEN);
>
> Since it already handles the case where remain&7 != 0 here, I think we
> can remove len_with_pad in rt5677_spi_write and replace it with len in
> the for loop to make it simpler.
>
Tested that and it works, I'll send the updated patch tomorrow with
any more reviews that come in overnight. Thanks.
> >         }
> >         return read ? cmd : cmd + 1;
> >  }
> > @@ -108,7 +108,7 @@ static void rt5677_spi_reverse(u8 *dst, u32 dstlen, const u8 *src, u32 srclen)
> >         }
> >  }
> >
> > -/* Read DSP address space using SPI. addr and len have to be 2-byte aligned. */
> > +/* Read DSP address space using SPI. addr and len have to be 4-byte aligned. */
> >  int rt5677_spi_read(u32 addr, void *rxbuf, size_t len)
> >  {
> >         u32 offset;
> > @@ -124,7 +124,7 @@ int rt5677_spi_read(u32 addr, void *rxbuf, size_t len)
> >         if (!g_spi)
> >                 return -ENODEV;
> >
> > -       if ((addr & 1) || (len & 1)) {
> > +       if ((addr & 3) || (len & 3)) {
> >                 dev_err(&g_spi->dev, "Bad read align 0x%x(%zu)\n", addr, len);
> >                 return -EACCES;
> >         }
> > @@ -159,8 +159,8 @@ int rt5677_spi_read(u32 addr, void *rxbuf, size_t len)
> >  }
> >  EXPORT_SYMBOL_GPL(rt5677_spi_read);
> >
> > -/* Write DSP address space using SPI. addr has to be 2-byte aligned.
> > - * If len is not 2-byte aligned, an extra byte of zero is written at the end
> > +/* Write DSP address space using SPI. addr has to be 4-byte aligned.
> > + * If len is not 4-byte aligned, then extra zeros are written at the end
> >   * as padding.
> >   */
> >  int rt5677_spi_write(u32 addr, const void *txbuf, size_t len)
> > @@ -178,7 +178,7 @@ int rt5677_spi_write(u32 addr, const void *txbuf, size_t len)
> >         if (!g_spi)
> >                 return -ENODEV;
> >
> > -       if (addr & 1) {
> > +       if (addr & 3) {
> >                 dev_err(&g_spi->dev, "Bad write align 0x%x(%zu)\n", addr, len);
> >                 return -EACCES;
> >         }
> > --
> > 2.21.0.593.g511ec345e18-goog
> >
