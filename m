From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: Using codec pins to configure part of audio
	routing subsystem
Date: Tue, 16 Sep 2014 16:36:49 -0700
Message-ID: <CAOMFOmXk1-B187ewDJDsQ6=UXd2mXyifF=87vFFnVrrdZk8CKQ@mail.gmail.com>
References: <CAOMFOmXQtGe38_=vcjyAgt8RgEhCJ4ik4jShsGp2DtyJjbd=qQ@mail.gmail.com>
 <loom.20140916T055333-865@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com
 [209.85.220.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 27C84264F22
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 01:36:51 +0200 (CEST)
Received: by mail-vc0-f178.google.com with SMTP id hy4so599748vcb.23
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 16:36:50 -0700 (PDT)
In-Reply-To: <loom.20140916T055333-865@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: JongHo Kim <furmuwon@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi JongHo

On Mon, Sep 15, 2014 at 9:39 PM, JongHo Kim <furmuwon@gmail.com> wrote:
> Anatol Pomozov <anatol.pomozov <at> gmail.com> writes:
>
>>
>> Hi
>>
>> Here is reiteration from my previous question [1]
>>
>> I have following task. I have realtek rt5677 codec. Codec has 6 pins.
>> Some of the pins are configured as output and used to manipulate part
>> of audio routing subsystem. In my case one pin enables headphones amp,
>> another pin gates DMIC clock.
>>
>> I can easily do it by hard-coding this logic to rt5677 driver. Now I
>> an trying to pull this board-specific logic out of the codec driver
>> code and move it to device tree.
>>
>> I was told (without much explanation) to do it either 2 ways:
>>
>> 1) export codec pins as gpio and then create fixed regulator and tie
>> it to codec via SND_SOC_DAPM_REGULATOR_SUPPLY. I sent a question [1]
>> to clarify if it is the right way.
>>
>> 2) create ALSA controls for pins. I believe it means I need to create
>> controls with names "GPIO1", "GPIO2"..."GPIO6" and then use as part of
>> audio_routing list.
>>
>> What is the right way to achieve my goal. Are there examples of
>> configuration similar to mine? I am sure it is an easy task that was
>> already implemented by someone, but I can't google any useful result.
>>
>> [1] http://comments.gmane.org/gmane.linux.alsa.devel/127508
>>
>
> Hi.. I think..
>
> 1. RT5677 codec driver have to support kernel gpiolib driver(gpio kernel
> framework)
>    that similar to the arizona-gpio.c(http://lxr.free-
> electrons.com/source/drivers/gpio/gpio-arizona.c)
>
>    You are lucky guy, RT5677 author(Oder Chiou <oder_chiou@realtek.com>) has
> update gpiolib function today.
>    (http://thread.gmane.org/gmane.linux.alsa.devel/127626/focus=127625)
>    (http://thread.gmane.org/gmane.linux.alsa.devel/127658)
>    You can use the gpio lib(kernel gpio function)
>
> 2. Make the switch function or dapm_widget of the amp or the dmic clock
>    using gpio lib in your ASoC machine driver
>    refer to this function "tegra_wm8903_event_hp" or
> "tegra_wm8903_event_int_spk"
>    (http://lxr.free-electrons.com/source/sound/soc/tegra/tegra_wm8903.c)
>
> 3. Connect the DAPM widget maps or Make kcontrol switch(refer to the
> "tegra_wm8903_controls")
>    If you connect the dapm, amp or dmic is automatically turn on/off.
>    If you make the kcontrol switch, you have to turn on/off using the alsa
> library on userspace.


Thanks for your instructions. It works!

One more thing I had to do is to add "gpio-controller" DTS property to
codec configuration.
