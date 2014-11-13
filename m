From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH v2] ASoC: add TI ts3a227e headset chip
	driver
Date: Thu, 13 Nov 2014 11:13:10 -0800
Message-ID: <CAEUnVG7ywcuQ9Ut88K9y3+J98ONo=v14ELtar3f4_+y4fBufRg@mail.gmail.com>
References: <1415837738-22888-1-git-send-email-dgreid@chromium.org>
 <54645C30.7010406@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f42.google.com (mail-oi0-f42.google.com
 [209.85.218.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AA9A2604C3
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 20:13:33 +0100 (CET)
Received: by mail-oi0-f42.google.com with SMTP id v63so1641092oia.1
 for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2014 11:13:30 -0800 (PST)
In-Reply-To: <54645C30.7010406@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Benson Leung <bleung@chromium.org>, "dmitry.torokhov" <dmitry.torokhov@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2014 at 11:22 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 11/13/2014 01:15 AM, Dylan Reid wrote:
>>
>> +static struct snd_soc_codec_driver ts3a227e_codec_driver;
>> [...]
>> +       ret = snd_soc_register_codec(&i2c->dev, &ts3a227e_codec_driver,
>> +                                    NULL, 0);
>> [...]
>
>
> Since the driver doesn't need anything CODEC specific it could be made a
> component driver and then you can also use devm_snd_soc_register_component.
>

Thanks Lars.  That makes registering the jack from the platform driver
simpler too.
