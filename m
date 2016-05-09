From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Mon, 9 May 2016 15:22:10 +0100
Message-ID: <20160509142210.GH1646@localhost.localdomain>
References: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
 <20160505091122.GE1646@localhost.localdomain>
 <CAJcYhpbdr-3qBSdaLX-=MCSGX7VC0XGz6tKbzJ3K3RHeGMhs7g@mail.gmail.com>
 <CAJcYhpZ1NRUa_7nu5kT6yJ_NTbDxRtK5Uy0H1fxMBEHhvA1fxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E171265AF6
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 16:22:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAJcYhpZ1NRUa_7nu5kT6yJ_NTbDxRtK5Uy0H1fxMBEHhvA1fxw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paulo Sergio <pstglia@gmail.com>
Cc: alsa-devel@alsa-project.org, Christian Hartmann <cornogle@googlemail.com>, vinod.koul@intel.com, broonie@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, mika.westerberg@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Sun, May 08, 2016 at 08:44:09AM -0300, Paulo Sergio wrote:
> Hi Charles, how are you?

Good thanks.

> 
> > A quick look through your machine driver looks like the parts
> > relating the CODEC look ok.
> >
> > I am not so sure about the AP side routing but for the CODEC,
> >
> > 'HPOUT1L Input 1' AIF1RX1
> > 'HPOUT1R Input 1' AIF1RX2
> > 'HPOUT1 Digital Switch' 1
> >
> > Should be enough to route some audio out the headphones, assuming
> > AIF1 is connected to the AP and HPOUT1L is the headphones (it is
> > very rare for people to not wire things up that way so its quite
> > a good bet, and your machine driver suggests this is how it is
> > connected).
> 
> Tried these cmds/routes to enable headphones (got from Raspberry PI
> wolfson card), but we got no output (except static noise and some
> "clicks")
> 
> alsa_amixer -Dhw:0 cset name='HPOUT1 Digital Switch' on
> # Set path gain to -6dB for safety. ie mav 0.5Vrms output level.
> alsa_amixer -Dhw:0 cset name='HPOUT1 Digital Volume' 116
> # do we want to clear the HPOUT mixers inputs?
> alsa_amixer -Dhw:0 cset name='HPOUT1L Input 1' None
> alsa_amixer -Dhw:0 cset name='HPOUT1R Input 1' None
> alsa_amixer -Dhw:0 cset name='HPOUT1L Input 2' None
> alsa_amixer -Dhw:0 cset name='HPOUT1R Input 2' None
> alsa_amixer -Dhw:0 cset name='HPOUT1L Input 1' AIF1RX1
> alsa_amixer -Dhw:0 cset name='HPOUT1L Input 1 Volume' 32
> alsa_amixer -Dhw:0 cset name='HPOUT1R Input 1' AIF1RX2
> alsa_amixer -Dhw:0 cset name='HPOUT1R Input 1 Volume' 32
> alsa_amixer -Dhw:0 cset name='Headset Mic Switch' on

>From your machine driver I would have expected this last control
to be "Headphone Switch", although I do appear to see things
turning on in your log so I guess that switch is already on?

> 
> Tried also some other controls for speakers, but no audio output
> 
> >
> > If you provide some kernel logs with the LOG_DEVICE in
> > drivers/base/regmap/regmap.c set to the CODEC spi device, I am
> > happy to sanity check what is going to the CODEC. Although at the
> > moment I think your issue looks mostly like getting through the
> > AP side.
> 
> Appreciate your help. Thanks in advance
> 
> Here's dmesg with LOG_DEVICE set (in this case to "spi-WM510204:00") [1]
> 
> [1] - https://drive.google.com/file/d/0BxO6THtB865fS2NxUkdOa18zUlE/view?usp=sharing

[   52.859420] arizona spi-WM510204:00: 173 <= a8d
[   52.859451] arizona spi-WM510204:00: 174 <= c35
[   52.859458] arizona spi-WM510204:00: 176 <= 40
[   52.859466] arizona spi-WM510204:00: 179 <= 10
[   52.871213] arizona spi-WM510204:00: 172 <= 8007
[   52.871245] arizona spi-WM510204:00: 171 <= 1

Your FLL setting here look right, assuming a 25MHz MCLK1 and a
48k playback and no sign that the FLL failed to lock, so we very
likely have a clock.

[   52.873069] arizona spi-WM510204:00: 500 <= b
[   52.873082] arizona spi-WM510204:00: 505 <= 20
[   52.873089] arizona spi-WM510204:00: 506 <= 20
[   52.873096] arizona spi-WM510204:00: 507 <= 1010
[   52.873104] arizona spi-WM510204:00: 508 <= 1010

The audio interface looks like it is setup for 16bit 48k I2S.

Looks like both the HPOUTs are being unmuted:

[  157.115973] arizona spi-WM510204:00: 411 <= 280
[  157.126963] arizona spi-WM510204:00: 415 <= 280

The left headphone output appears to be powering up:

[  280.668563] arizona spi-WM510204:00: 400 <= 2

The mixer source appears to be applying (HPOUT1L <= AIF1RX1)

[  280.686634] arizona spi-WM510204:00: 680 <= 20

Overall, I would say it looks good. One thing I would perhaps
try, connect up this path as you have been doing, but whilst the
audio is playing (or attempting to at least) connect the route:

'HPOUT1R Input 1' 'Tone Generator 1'

This will hook the right headphone channel up to the chips
internal 1k tone generator. Careful it will be loud, but its
a good check to make sure the clocks are all happy inside the
chip. If you hear that tone, I would say the CODEC side looks
happy, but let me know how you get on.

Thanks,
Charles
