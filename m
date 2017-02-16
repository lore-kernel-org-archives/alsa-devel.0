From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: Re: [PATCH v1 3/3] ASoC: zx-96p22: add zte's aud96p22
	controller driver
Date: Thu, 16 Feb 2017 08:24:17 +0800
Message-ID: <CA+DQWkwjCYsKYW-THWHr=qZTRe-f+m_PnX4fM+6tRuQKwkWxWA@mail.gmail.com>
References: <1487156110-12840-1-git-send-email-baoyou.xie@linaro.org>
 <1487156110-12840-3-git-send-email-baoyou.xie@linaro.org>
 <20170215112425.GC30007@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 328412666EA
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 01:24:18 +0100 (CET)
Received: by mail-it0-f47.google.com with SMTP id 203so82844969ith.0
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 16:24:18 -0800 (PST)
In-Reply-To: <20170215112425.GC30007@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, bardliao@realtek.com, lars@metafoo.de, Axel Lin <axel.lin@ingics.com>, Paul.Handrigan@cirrus.com, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, devicetree <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, anish kumar <yesanishhere@gmail.com>, "xie.baoyou" <xie.baoyou@zte.com.cn>, nh6z@nh6z.net, Rob Herring <robh+dt@kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, oder_chiou@realtek.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, petr@barix.com, broonie@kernel.org, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi, Charles:

On 15 February 2017 at 19:24, Charles Keepax <
ckeepax@opensource.wolfsonmicro.com> wrote:

> On Wed, Feb 15, 2017 at 06:55:10PM +0800, Baoyou Xie wrote:
> > This patch adds aud96p22 controller driver for zte's SoC family.
> >
> > Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> > ---
> <snip>
> > +static int zx_aud96p22_i2c_write(struct i2c_client *i2c_client,
> > +                              const void *data, size_t count)
> > +{
> > +     int xfer;
> > +
> > +     xfer = i2c_master_send(i2c_client, data, count);
> > +     if (xfer == count)
> > +             return 0;
> > +     else if (xfer < 0)
> > +             return xfer;
> > +     else
> > +             return -EIO;
> > +}
> > +
> > +static int zx_aud96p22_i2c_read(struct i2c_client *i2c_client,
> > +                             unsigned char addr)
> > +{
> > +     int xfer;
> > +
> > +     xfer = i2c_smbus_read_word_data(i2c_client, addr);
> > +     if (xfer < 0)
> > +             dev_warn(&i2c_client->dev, "transfer error %d\n", xfer);
> > +
> > +     return xfer;
> > +}
> > +
>
> Is there any reason this isn't using regmap? It looks like it
> should be, have a look at any of the other mainline CODECs for an
> example.
>
> We can not read the i2c register directly, cause of the i2c is responded
asynchronous, and involves i2c irq.

I suggest that we access i2c through general i2c interface.


> Thanks,
> Charles
>
