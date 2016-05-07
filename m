From: Paulo Sergio <pstglia@gmail.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Sat, 7 May 2016 00:19:01 -0300
Message-ID: <CAJcYhpbdr-3qBSdaLX-=MCSGX7VC0XGz6tKbzJ3K3RHeGMhs7g@mail.gmail.com>
References: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
 <20160505091122.GE1646@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id E17DA2606D2
 for <alsa-devel@alsa-project.org>; Sat,  7 May 2016 05:19:02 +0200 (CEST)
Received: by mail-ig0-f179.google.com with SMTP id bi2so62569940igb.0
 for <alsa-devel@alsa-project.org>; Fri, 06 May 2016 20:19:02 -0700 (PDT)
In-Reply-To: <20160505091122.GE1646@localhost.localdomain>
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
Cc: alsa-devel@alsa-project.org, Christian Hartmann <cornogle@googlemail.com>, vinod.koul@intel.com, broonie@opensource.wolfsonmicro.com, pierre-louis.bossart@linux.intel.com, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi Charles, how are you?

> A quick look through your machine driver looks like the parts
> relating the CODEC look ok.
>
> I am not so sure about the AP side routing but for the CODEC,
>
> 'HPOUT1L Input 1' AIF1RX1
> 'HPOUT1R Input 1' AIF1RX2
> 'HPOUT1 Digital Switch' 1
>
> Should be enough to route some audio out the headphones, assuming
> AIF1 is connected to the AP and HPOUT1L is the headphones (it is
> very rare for people to not wire things up that way so its quite
> a good bet, and your machine driver suggests this is how it is
> connected).

Tried these cmds/routes to enable headphones (got from Raspberry PI
wolfson card), but we got no output (except static noise and some
"clicks")

alsa_amixer -Dhw:0 cset name='HPOUT1 Digital Switch' on
# Set path gain to -6dB for safety. ie mav 0.5Vrms output level.
alsa_amixer -Dhw:0 cset name='HPOUT1 Digital Volume' 116
# do we want to clear the HPOUT mixers inputs?
alsa_amixer -Dhw:0 cset name='HPOUT1L Input 1' None
alsa_amixer -Dhw:0 cset name='HPOUT1R Input 1' None
alsa_amixer -Dhw:0 cset name='HPOUT1L Input 2' None
alsa_amixer -Dhw:0 cset name='HPOUT1R Input 2' None
alsa_amixer -Dhw:0 cset name='HPOUT1L Input 1' AIF1RX1
alsa_amixer -Dhw:0 cset name='HPOUT1L Input 1 Volume' 32
alsa_amixer -Dhw:0 cset name='HPOUT1R Input 1' AIF1RX2
alsa_amixer -Dhw:0 cset name='HPOUT1R Input 1 Volume' 32
alsa_amixer -Dhw:0 cset name='Headset Mic Switch' on

Tried also some other controls for speakers, but no audio output

>
> If you provide some kernel logs with the LOG_DEVICE in
> drivers/base/regmap/regmap.c set to the CODEC spi device, I am
> happy to sanity check what is going to the CODEC. Although at the
> moment I think your issue looks mostly like getting through the
> AP side.

Appreciate your help. Thanks in advance

Here's dmesg with LOG_DEVICE set (in this case to "spi-WM510204:00") [1]

[1] - https://drive.google.com/file/d/0BxO6THtB865fS2NxUkdOa18zUlE/view?usp=sharing

Regards
Pstglia
