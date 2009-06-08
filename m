From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [alsa-devel] [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio support.
Date: Mon, 8 Jun 2009 15:11:39 +0200
Message-ID: <f861ec6f0906080611i2c03709cg621aeb87d084dd00@mail.gmail.com>
References: <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
	 <20090608092521.GA7858@sirena.org.uk>
	 <f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com>
	 <20090608102018.GA6547@rakim.wolfsonmicro.main>
	 <f861ec6f0906080425i388a99a1kb89667c749a815c8@mail.gmail.com>
	 <20090608115336.GA25827@rakim.wolfsonmicro.main>
	 <f861ec6f0906080521y4443b888gb81a78305dfca5e2@mail.gmail.com>
	 <20090608124411.GA3396@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20090608124411.GA3396@rakim.wolfsonmicro.main>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

>> I see now what you mean, but this is ugly as sin:
>> I now need to register 2 platform devices in the board code: 1 for t=
he DAI
>> (with resources mmio + irq) and 1 for the DMA engine (with ddma id r=
esources),
>> or register the DMA engine device from within the AC97/I2S drivers.
>
>> This is in my opinion even worse than the current scheme, which at l=
east allows
>> me to group all PSC resources into one struct resource which all aud=
io-related
>> drivers can share without too much uglyness.
>
> If you trigger registration the DMA engine from within the I2S and AC=
97
> devices you can still group everything together like you want to so I
> don't really see the problem - they're peering at a different device =
for
> the data but other than that things are unchanged. =A0At the minute y=
ou're
> loosing a lot of sharing by having this in the individual machine
> drivers.

All 3 drivers are now platform_devices -- and now I still have the
same problem as
before: I can't really share the whole struct resource;  i need to allo=
cate
a new resource struct, fill in the dma ids and register the dma device =
with it.

Btw, the davinci-evm in asoc-git also registers mmio and dma from withi=
n
the machine code.

I can't shake the feeling that there's something wrong with the whole a=
soc
device model (and that asoc was designed with pxa2xx devices in mind wh=
ich
have single audio units with fixed resources that the driver code can
hardcode inside it).


> Note that one of the possibilities once multiple sound card support i=
s
> introduced is that DAIs could be shared between multiple cards. =A0Th=
is is

I wrote the au1x audio drivers with this in mind: the DAI really descri=
bes how
to interact with a PSC; I didn't see any point in duplicating the dai
description
for each possible PSC.


To put an end to this thread:  I really don't want to change the machin=
e code
or dai drivers at this time, because I have the feeling that it's a few=
 steps
backwards.  If you don't agree with this then I'll leave the audio part=
s out of
the submission; I don't really care if it goes in or not, I just saw
it as a nice
sample machine driver for both AC97 and I2S on Alchemy.


        Manuel Lauss
