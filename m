From: David Ulricht <david.ulricht434@gmail.com>
Subject: Re: CS8409 Macbook Pro 2016 2017
Date: Mon, 19 Nov 2018 19:30:15 +0200
Message-ID: <CALbf9MxxzmFzWLydOxFH8jx_Z4t-HMq6jEhP7cwhWTG86RXj3A@mail.gmail.com>
References: <CALbf9MzcxBqkBP4mbUKht72Ga6VnTubeiHcTr2joEf7i-enxFQ@mail.gmail.com>
 <s5h7el6vd91.wl-tiwai@suse.de>
 <CALbf9Mw=Y5ddFZDZQ4_mfYCHxKb9XFHN3v5ge0JaTca7NLMM7A@mail.gmail.com>
 <s5hzhy2t7ww.wl-tiwai@suse.de>
 <CALbf9MwN4pEk26R9c2-UMxzvLXQ3OOBTcqgdSvXeFb-dw7-Wnw@mail.gmail.com>
 <s5hwot6t5qz.wl-tiwai@suse.de>
 <CALbf9MzYvcz+d0HKmvc60WhTHVpiuTK8O66qNH3Xcuo5j3uU9Q@mail.gmail.com>
 <s5h1sbcu1t1.wl-tiwai@suse.de>
 <CALbf9MyfhiE73gLsimw4XS3pJyD1N+w6NMD5KzH-dSPAA3qbFg@mail.gmail.com>
 <s5h5zwxhyxh.wl-tiwai@suse.de>
 <CALbf9Myg=XJqiRN2YJAwYqP6hHDGnCwYptQvUT8WMqGmnN_XRQ@mail.gmail.com>
 <s5hr2flgc8y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 877E6267837
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2018 18:30:28 +0100 (CET)
Received: by mail-oi1-f178.google.com with SMTP id b141so16898063oii.12
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2018 09:30:28 -0800 (PST)
In-Reply-To: <s5hr2flgc8y.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 I have found the schematics of the board its model A1708:
http://sualaptop365.edu.vn/threads/apple-macbook-pro-13-a1708-820-00875-051-02265-x502-mlb_catz-schematic-boardview.19646/
page 48 CS8409 audio codec GPIO7 is SDA GPIO6 is SCL.
page 50:  the four SSM3515B amplifiers connected to CS8409's I2C SDA/SCL
have found the datasheet of SSM3515 amplifiers as well:
https://www.analog.com/media/en/technical-documentation/data-sheets/SSM3515.pdf
Documentation says: If the REG_EN pin is tied to the PVDD the power-up
sequence is performed internally.
According to the SSM3515B REG_EN is also called C2.
According to the 1708 schematics(page 50) REG_EN also called C2, is
connected to ground. This means if REG_EN is connected to ground, it uses
an external 1.8V regulator (page 19 of SSM3515 pdf). e.g. the device needs
to be initialized via i2c commands. This means the 4 amplifiers SSM3515B
need to be initialized via i2c, because simply apple decided to disable
them by default for some reason probably save power while booting for
example.
Now I need to figure out how to send the i2c commands i have from windows10.
page 21: describes the I2C control which should be of help

The following windows 10 registry about i2c maybe of help, it has the
slaves addresses, the start/stop the powerup2c commands, everything
needed...:
"I2CSpeedMode"=dword:00000001
"I2CPolledMode"=dword:00000001
"I2CQuickMode"=dword:00000001
"I2CBusClear"=dword:00000006
"I2CSlave90Config"=dword:01002090
"InitI2C"=hex:01,90,3a,00,10,10,b0,00,1d,01,00,02,06,00,11,07,01,00,10,09,02,\

07,03,00,12,01,00,08,13,05,ff,06,00,07,20,02,0d,00,2a,02,02,03,00,04,00,05,\

02,06,00,07,20,08,02,09,00,0a,80,0b,02,0c,00,0d,a0,01,0c,00,29,02,01,03,02,\

04,00,05,00,01,01,00,11,01,0a,02,84,00,23,01,00,03,00,02,3f,00,20,01,03,00,\
  1b,75,b6,73,c2,00,11,29,01,21,f3,03,20,05,00,12,00,13,80,00,1c,03,c0
"n0AStreamStartI2C"=hex:01,90,02,00,11,01,02
"n0AStreamStopI2C"=hex:01,90,02,00,11,01,0a
"I2CSlave28Config"=dword:00004028
"I2CSlave2AConfig"=dword:0000402a
"I2CSlave2CConfig"=dword:0000402c
"I2CSlave2EConfig"=dword:0000402e
"n02PwrUpI2C"=hex:04,28,2a,2c,2e,07,00,81,01,11,02,32,03,48,04,11,05,10,00,80
"n03PwrUpI2C"=hex:01,28,01,05,00,01,2a,01,05,02,01,2c,01,05,01,01,2e,01,05,03
"ExitI2C"=hex:04,28,2a,2c,2e,01,00,83
"EQ1S1R7"=hex:1e,b2,9a,1a,df,15,c6,f4,11,19,91,ae,c6,f4,11,16,3b,23,16,3b,23,\
  d3,89,b9,1f,88,d9,c0,78,b8
"EQ1S2R7"=hex:16,3d,23,16,3d,23,d3,85,bb,1f,8e,8e,c0,73,03,14,62,da,12,94,45,\
  d9,23,c2,1d,b9,a4,c2,61,3d

Now comes the problem that I cannot write my own i2c driver to power up the
4 SSM3515B amps via the I2C on GPIO7/6 on CS8409.
I have no idea how to get a pointer to the i2c interface knowing the
GPIO7/6 are the i2c interface.
If someone helps me to get a C pointer to the i2c bus, I might be able to
read/write to it and test and figure it out.
I have only experimented with real i2c bus on Raspberry Pi with C code, and
it is completely different. I have there an /dev/i2c-l device that I can
write to file handle the bytes.
Please advise.

On Fri, Nov 16, 2018 at 7:31 PM Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 16 Nov 2018 17:50:24 +0100,
> David Ulricht wrote:
> >
> >     The stuff in sound/i2c/* are mostly for the i2c bus on a PCI sound
> >     cards, an implementation independent from the standard i2c stuff.
> >
> >     And, in your case, it's hard to know how the i2c bus is connected.
> >     If it's controlled over HD-audio GPIO pin (one for clk and one for
> >     data), then some stuff in sound/i2c can be re-used.  Or, if it's on
> >     another i2c bus, the story will be completely different...
> >
> > I have the schematics of the CS8409. the i2c is connected to the GPIO of
> the
> > HDA.
> >
> > MAX98374 has a Reset Low pin which is connected to GPIO 5 on the HDA
> > controller CS8409.  This must
> > be driven high, then wait for 1.5 ms.  Only then will the amps be out of
> > device shutdown.
> > GPIO6 is  8409_I2C_SCL
> > GPIO7 is  8409_I2C_SDA
> >
> > GPIO5 is AUD_SPKRAMP_RESET_L
> >
> > Knowing GPIO6 is the clock and GPIO7 is the data, how can I use them?
> > Can I use hda-verb /dev/snd/hwC0D0 0x01 XXX YYY ? what XXX YYY would be ?
>
> You need to set GPIO mask, direction then data.
>   0x01 SET_GPIO_MASK 0xXX
>   0x01 SET_GPIO_DIR 0xXX
>   0x01 SET_GPIO_DATA 0xXX
>
> The value to be pass is the bits.  GPIO0=0x01, GPIO1=0x02, GPIO3=0x04,
> ...
>
> You can read the data after setting mask and dir by 0x01
> GET_GPIO_DATA.  Pass 0 for the value, and you'll get a byte value as a
> read result.
>
>
> Takashi
>
