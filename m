From: Ilya Dmitrichenko <errordeveloper@gmail.com>
Subject: Re: am335x+tlv320aic3x
Date: Wed, 10 Sep 2014 10:54:54 +0100
Message-ID: <CAPhDKbHJmBS2B-KH-8VF4UjbDXSzuP2N3ZVyCXhwj+UEZh+n4Q@mail.gmail.com>
References: <CAPhDKbHgUcCWsdc7peSe7UdWdu68sqfObcP_fQw7bWPxJhZEPg@mail.gmail.com>
 <540EA4E0.90209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com
 [209.85.213.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 7186F26072A
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 11:54:55 +0200 (CEST)
Received: by mail-ig0-f169.google.com with SMTP id r2so1024296igi.0
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 02:54:54 -0700 (PDT)
In-Reply-To: <540EA4E0.90209@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Peter,

On 9 September 2014 07:57, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> What is the revision of audio cape you have? The fragment is for RevA, RevB of
> the cape is significantly different.

Sure, I have checked this and my audio cape is of the older revision A1.

> You are missing the CONFIG_SND_SOC_TLV320AIC3X

Sorry, looks like I didn't copy everything here. This is what I have:

$ zcat /proc/config.gz | grep ^CONFIG_SND
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_HRTIMER=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
CONFIG_SND_RAWMIDI_SEQ=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_ARM=y
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_SOC=m
CONFIG_SND_DAVINCI_SOC=m
CONFIG_SND_DAVINCI_SOC_MCASP=m
CONFIG_SND_DAVINCI_SOC_GENERIC_EVM=m
CONFIG_SND_AM33XX_SOC_EVM=m
CONFIG_SND_OMAP_SOC=m
CONFIG_SND_OMAP_SOC_MCBSP=m
CONFIG_SND_OMAP_SOC_HDMI=m
CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
CONFIG_SND_OMAP_SOC_OMAP_HDMI=m
CONFIG_SND_SOC_I2C_AND_SPI=m
CONFIG_SND_SOC_HDMI_CODEC=m
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TWL4030=m

As you can see, the TLV320AIC3X module is enable and I am also able to
load it, but nothing happens.

I also wonder if there is a way of configuring this by means of
passing module params instead of device tree, but couldn't find any
information on this.

After reading the driver source code, I figured I should try changing
the device tree code to use  "ti,tlv320aic3x-hifi", but that didn't
affect anything. I have updated the gist with the effective device
tree obtain from the running system [3] and the respective source code
[4].

[3]: https://gist.github.com/errordeveloper/cba5145960bdeb0126d5#file-effective_device_tree-dts
[4]: https://gist.github.com/errordeveloper/cba5145960bdeb0126d5#file-input_device_tree-dts

Peter, thanks for looking into this! I'll make sure that I get the
results posted online, so the community can use capes without DT
overlay patches. Sorry for my bad english in the last email, was
typing in a hurry.

Cheers,
-- 
Ilya
