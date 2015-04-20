From: Kevin Cernekee <cernekee@chromium.org>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: tas571x: New driver for TI TAS571x
 power amplifiers
Date: Mon, 20 Apr 2015 13:56:46 -0700
Message-ID: <CAJzqFtbxKJirP9=hzHzQ=6KM=OayPmEDhJfkSx25DH4fu-gVgg@mail.gmail.com>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <1429134141-17924-2-git-send-email-cernekee@chromium.org> <552FB1CD.3040401@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <552FB1CD.3040401@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Andrew Bresticker <abrestic@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dgreid@chromium.org, Olof Johansson <olofj@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2015 at 5:57 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 04/15/2015 11:42 PM, Kevin Cernekee wrote:
>>
>> Introduce a new codec driver for the Texas Instruments
>> TAS5711/TAS5717/TAS5719 power amplifier chips.  These chips are typically
>> used to take an I2S digital audio input and drive 10-20W into a pair of
>> speakers.
>>
>> Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
>
>
> Looks pretty good. Comments inlune.

Thanks for the review.  I'm working on a V2 incorporating the feedback
from you and Mark.

>> +static int tas571x_i2c_probe(struct i2c_client *client,
>> +                            const struct i2c_device_id *id)
>> +{
>> +       struct tas571x_private *priv;
>> +       struct device *dev = &client->dev;
>> +       int i;
>> +
>> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
>> +       i2c_set_clientdata(client, priv);
>> +
>> +       priv->mclk = devm_clk_get(dev, "mclk");
>> +       if (PTR_ERR(priv->mclk) == -EPROBE_DEFER)
>> +               return -EPROBE_DEFER;
>
>
> If you want to make the clock optional use
>
>         if (PTR_ERR(priv->mclk) == -ENOENT)
>                 return PTR_ERR(priv->mclk);
>
> This makes sure that the case where the clock is specified, but there is a
> error with the specification (e.g. incorrect DT cells) is handled properly.

Did you mean:

>         if (PTR_ERR(priv->mclk) != -ENOENT)
>                 return PTR_ERR(priv->mclk);

I don't see this in other codec drivers, but I do see the explicit
EPROBE_DEFER check in max98090, max98095, pcm512x, and wm8960.
