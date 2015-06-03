From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH v3 6/6] ASoC: zx: add zx296702 hdmi codec
Date: Wed, 3 Jun 2015 09:47:46 +0800
Message-ID: <CABymUCOWiHERfvw9c5ihsvgXXko1HLwv+7ectLOiQd3rGSHHPQ@mail.gmail.com>
References: <CABymUCNvM=k4tWJutpzoK-VFvKhBC4EGjh_OzWYMMRppUqvSOA@mail.gmail.com>
 <20150602181326.GB14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f52.google.com (mail-la0-f52.google.com
 [209.85.215.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 187A1265850
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 03:47:47 +0200 (CEST)
Received: by laei3 with SMTP id i3so51044081lae.3
 for <alsa-devel@alsa-project.org>; Tue, 02 Jun 2015 18:47:46 -0700 (PDT)
In-Reply-To: <20150602181326.GB14071@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

2015-06-03 2:13 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Mon, Jun 01, 2015 at 09:42:34AM +0800, Jun Nie wrote:
>
>> So I need implement dai link in machine audio card driver, while not
>> use simple card and device tree initialization. In this way, I surely
>> can embed HDMI audio codec in HDMI driver. Is that right?
>
> I'm sorry, I don't entirely follow what you're saying here.
I am guessing you suggest me to implement a ASoC board driver, like
sound/soc/omap/omap3pandora.c. I can link HDMI codec with DAI with
snd_soc_dai_link structure to avoid specify the connection in dts.

>
>> I had try to initialize audio all from dts, so need a HDMI codec dt
>> node to connect with DAI. However, I cannot find a way to create an
>> independent HDMI CODEC dt node because it is brought up from HDMI
>> driver. If my above understanding is correct, a machine level DAI link
>> shall resolve this issue with dropping simple card and DAI link in
>> dts. Thanks for your comments!
>
> If the HDMI encoder is simple I'd expect it to be possible to use it
> with simple-card.  If it isn't then we can look at why.

Most of devices is initialized from devicetree if not all on my board.
So I need fill CODEC/DAI dt node for imple-card in dts. I experience
the difficulty that I cannot create HDMI CODEC dt node. Because HDMI
CODEC shall be part of HDMI driver and be brought up with direct call
to snd_soc_register_codec in HDMI driver probe function per my
understanding. Then I do not have an independent dt node for HDMI
CODEC, thus cannot link the CODEC to DAI with dts information. Do you
see any chance to connect a DAI to an embedded CODEC of HDMI video
device? Thank you!

>
>> BTW: HDMI driver is far from mature, so you did not see HDMI function
>> implementation in this patch serial.
>
> Sure, no problem.
