From: Hsin-yu Chao <hychao@google.com>
Subject: Re: [PATCH] ASoC: rt5514: Use the local variable to
 get the data from SPI device
Date: Tue, 25 Jul 2017 22:47:55 +0800
Message-ID: <CANyK0SmAVH2GBBA_69D-omT_pJuHA_v2oE9ExbPYEe_WbFxi9Q@mail.gmail.com>
References: <1500624047-21492-1-git-send-email-oder_chiou@realtek.com>
 <20170721105105.4lsehuw6an7oclqd@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694023B5FB9@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f169.google.com (mail-ua0-f169.google.com
 [209.85.217.169])
 by alsa0.perex.cz (Postfix) with ESMTP id E2D0A266CC3
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 16:47:57 +0200 (CEST)
Received: by mail-ua0-f169.google.com with SMTP id d29so95387033uai.2
 for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2017 07:47:57 -0700 (PDT)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694023B5FB9@RTITMBSV02.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>, Mark Brown <broonie@kernel.org>, =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>, Bard Liao <bardliao@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

The original cause seems to be in spi driver.
I tested setting enable_dma flag to false in spi-pxa2xx driver and that
fixes the problem.
Will investigate in spi driver side. Thanks!

Hsin-yu



On Mon, Jul 24, 2017 at 11:06 AM, Oder Chiou <oder_chiou@realtek.com> wrote:

> > On Fri, Jul 21, 2017 at 04:00:47PM +0800, Oder Chiou wrote:
> > > The patch uses the local variable to get the data from SPI device to
> > > prevent to get all zero data.
> >
> > How do you end up with all zero data from reading directly into rxbuf?
> >
> While the "runtime->dma_area" put into the rxbuf directly on the Intel
> platform, it seemed that had the limitation to let the memory cannot be
> written the data using the driver of the SPI controller. We verified the
> original code on the platforms of Nvidia and Rockchip, and these are
> working fine.
>
