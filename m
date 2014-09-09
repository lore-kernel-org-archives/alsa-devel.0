From: Ilya Dmitrichenko <errordeveloper@gmail.com>
Subject: am335x+tlv320aic3x
Date: Tue, 9 Sep 2014 01:33:57 +0100
Message-ID: <CAPhDKbHgUcCWsdc7peSe7UdWdu68sqfObcP_fQw7bWPxJhZEPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 4358326262D
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 02:33:59 +0200 (CEST)
Received: by mail-ie0-f169.google.com with SMTP id rl12so3165269iec.28
 for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2014 17:33:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi List,

I am trying to get Beaglebone workign with the audio extension board
(aka cape) that is using tlv320aic3x codec. I want it to run 3.14 and
use vanilla kernel without dynamic DT overlay patches.

So I have take the current overlay DT [1] and made converted it [2].
The result is that it boots and detects the Davinci module, but
doesn't get the codec.

[1]: https://github.com/beagleboard/devicetree-source/blob/d46bcc20ef98d69eea34cd6ae3897a329559ebb2/arch/arm/boot/dts/BB-BONE-AUDI-01-00A0.dts
[2]: https://gist.github.com/errordeveloper/cba5145960bdeb0126d5

My kernel config includes this:

CONFIG_SND_OMAP_SOC=m
CONFIG_SND_OMAP_SOC_MCBSP=m
CONFIG_SND_OMAP_SOC_OMAP_TWL4030=m
CONFIG_SND_SOC_TWL4030=m
CONFIG_SND_DAVINCI_SOC=m
CONFIG_SND_AM33XX_SOC_EVM=m
CONFIG_SND_DAVINCI_SOC_MCASP=m
CONFIG_SND_HRTIMER=m
