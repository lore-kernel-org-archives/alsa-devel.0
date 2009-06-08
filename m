From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [alsa-devel] [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio support.
Date: Mon, 8 Jun 2009 14:21:18 +0200
Message-ID: <f861ec6f0906080521y4443b888gb81a78305dfca5e2@mail.gmail.com>
References: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
	 <20090608092521.GA7858@sirena.org.uk>
	 <f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com>
	 <20090608102018.GA6547@rakim.wolfsonmicro.main>
	 <f861ec6f0906080425i388a99a1kb89667c749a815c8@mail.gmail.com>
	 <20090608115336.GA25827@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20090608115336.GA25827@rakim.wolfsonmicro.main>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark,

> You should convert the DAI drivers to probe as normal platform device=
s
> and attach the resources used by the CPU to those devices rather than
> attaching the data to soc-audio. =A0pxa2xx-ac97 does this, as do the
> PowerPC drivers and the s3c64xx-i2s driver. =A0The DaVinci drivers
> currently on the davinci branch of my git for merge after the merge
> window do this too.

I see now what you mean, but this is ugly as sin:
I now need to register 2 platform devices in the board code: 1 for the =
DAI
(with resources mmio + irq) and 1 for the DMA engine (with ddma id reso=
urces),
or register the DMA engine device from within the AC97/I2S drivers.

This is in my opinion even worse than the current scheme, which at leas=
t allows
me to group all PSC resources into one struct resource which all audio-=
related
drivers can share without too much uglyness.

       Manuel Lauss
