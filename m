From: =?UTF-8?Q?Emmanuel_Fust=c3=a9?= <emmanuel.fuste@laposte.net>
Subject: Re: [PATCH v8] ASoC: bcm2835: Add 8 channel
 (multitrack) capability
Date: Sat, 25 Feb 2017 01:08:23 +0100
Message-ID: <27367161-11c6-2d62-cea0-f8936d8477e8@laposte.net>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <1487746600-11065-1-git-send-email-flatmax@flatmax.org>
 <20170224121832.GA19227@camel2.lan>
 <3b693ff9-b3a6-1c10-5b1a-78be04006113@flatmax.org>
 <20170224202553.GA28529@camel2.lan>
 <501e4af5-51b7-c124-4a29-ef5804d8a03c@flatmax.org>
 <20170224230159.GA30456@camel2.lan>
Reply-To: emmanuel.fuste@laposte.net
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.laposte.net (smtpoutz25.laposte.net [194.117.213.100])
 by alsa0.perex.cz (Postfix) with ESMTP id CA0772668C0
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 01:08:25 +0100 (CET)
Received: from smtp.laposte.net (localhost [127.0.0.1])
 by lpn-prd-vrout013 (Postfix) with ESMTP id 8084B104C40
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 01:08:24 +0100 (CET)
Received: from smtp.laposte.net (localhost [127.0.0.1])
 by lpn-prd-vrout013 (Postfix) with ESMTP id 71CBF104C6B
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 01:08:24 +0100 (CET)
Received: from lpn-prd-vrin003 (lpn-prd-vrin003.laposte [10.128.63.4])
 by lpn-prd-vrout013 (Postfix) with ESMTP id 70879104C4F
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 01:08:24 +0100 (CET)
Received: from lpn-prd-vrin003 (localhost [127.0.0.1])
 by lpn-prd-vrin003 (Postfix) with ESMTP id 5F99748E9E8
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 01:08:24 +0100 (CET)
In-Reply-To: <20170224230159.GA30456@camel2.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Reichl <hias@horus.com>, Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Phil Elwell <phil@raspberrypi.org>, Eric Anholt <eric@anholt.net>, Mark Brown <broonie@kernel.org>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Le 25/02/2017 =E0 00:02, Matthias Reichl a =E9crit :
> On Sat, Feb 25, 2017 at 08:30:03AM +1100, Matt Flax wrote:
>>
>> On 25/02/17 07:25, Matthias Reichl wrote:
>>
>>> I'd put it in another way: it seems to me that the bcm2835 I2S
>>> won't reliably sync in DSP mode A.
>>>
>>>
>> What you are explaining here is the nature of the BCM2835 responding to a
>> codec master. The hardware setup you are describing is elegantly simple,=
 but
>> TOO simple.
> Your patch only changes the CPU DAI driver. At this point it doesn't
> matter if the codec or an external source is driving the clocks.
>
> If the clock timing adheres to DSP mode A timing and you add code
> to the the CPU DAI driver so it can operate in DSP mode A then
> that should also work. If not, it's broken.
>
> The (rather brief) publically available bcm2835 datasheet only
> mentions I2S mode and my tests lead me to the conclusion that the
> bcm2835 is actually expecting I2S timing, not DSP A - at least with
> the current code.
After reading this long thread and gluing all info together, my guess is =

that the "real" thing he's trying to do is to introduce a new DPS mode =

which is nothing more than a multichannel capable I2S mode or a "DSP I" =

mode : DSP A with data_delay 1.
As it is basically an I2S (2 channel) encapsulation of multichannel =

stream, the real question is alsa plugin or new bastardized DSP mode ?

>
>> Measurements on a system which uses a codec master don't represent a rob=
ust
>> implementation of multichannel with the BCM2835. My experiments (and now
>> yours) have shown that the system has a bit shift and an uncontrollable
>> channel drift.
>>
>> Multichannel simply can't be done (on the BCM2835) without control at the
>> hardware level - this requires an intermediate master control chip.
>>
>> The Audio Injector Octo machine driver, sets both the codec and the BCM2=
835
>> as slaves - the FPGA is master because it has to control both the BCM2835
>> and the codec's systems to get reliability. You can see the machine driv=
er
>> on github :
>> https://github.com/flatmax/linux/blob/rpi-4.4.y/sound/soc/bcm/audioinjec=
tor-octo-soundcard.c
>>
>> It has taken month to implement a robust solution to this problem using =
an
>> FPGA and the result is a fantastic (Audio Injector Octo) sound card. I am
>> almost certain this hardware technique can be used on all stereo I2S SoC
>> chips.
> Can you please provide details about the timing / protocol you are
> actually using?
I suspect that the FPGA act as an I2S <=3D> DSP A translator, taking care =

of data_delay difference translation relative to the falling edge of LRCLK.
It could translate the duration of the one BCLK duration of LRCLK DSP A =

pulse to standard I2S LRCLK even if most codecs works with I2S fs LRCLK =

timing as the sync point is the falling edge.
As the FPGA has to deals with the clocks of the two sides, it's more =

simple if it's the master.
If I'm right, the real used mode from the soc point of view is I2S and =

all of this is valid for all I2S IP, there is nothing BMC2835 specific =

here. It is not the right place to do the mod.

Emmanuel.
