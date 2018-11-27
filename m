From: David Ulricht <david.ulricht434@gmail.com>
Subject: Re: CS8409 Macbook Pro 2016 2017
Date: Tue, 27 Nov 2018 04:42:17 +0200
Message-ID: <CALbf9MwJRupXwTL4r_6FcMkp1jho5tmurSHdUVoa9g-0+Bhadg@mail.gmail.com>
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
 <CALbf9MxxzmFzWLydOxFH8jx_Z4t-HMq6jEhP7cwhWTG86RXj3A@mail.gmail.com>
 <s5h4lcchpk2.wl-tiwai@suse.de>
 <CALbf9MwDv9tUzBeef0NTvaH_Hbr+9NW_q=UFj7HUH3L3zp7RnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 61A6C26784E
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2018 03:42:31 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id g27so18756028oth.6
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 18:42:30 -0800 (PST)
In-Reply-To: <CALbf9MwDv9tUzBeef0NTvaH_Hbr+9NW_q=UFj7HUH3L3zp7RnA@mail.gmail.com>
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

 One thing to note on all I2C interfaces is that when GPIO is driven high
(IN direction,dir=0) on the master (e.g. CS8409), SDA should be a constant
HIGH, e.g. data=1.
No matter if there is any I2C device connected to the bus, if you have a
pull-up it will always pull-up the constant value 1. This 1 is usually a
NACK that get received if you dont find the address.

So far I couldn't get the IO[7] (SDA) with dir=0 (in,also known as HIGH
direction) to deliver a data=1. IO[7] is with constant data=0.  This means
the pull-up is not pulling 1, and the I2C interface is not enabled by
default after reset of the CS8409 codec.
this is expected value for enabled I2C:
  IO[7]: enable=1, dir=0, wake=0, sticky=0, data=*1*, unsol=0
but what I get is:
  IO[7]: enable=1, dir=0, wake=0, sticky=0, data=0, unsol=0  which means
I2C mode not initialized.

I was just going to give up totally, and i looked up into one of my emails
where i found the following:
  IO[7]: enable=1, dir=0, wake=0, sticky=0, data=1, unsol=0
after using my amateur send_sequence script (when i had no idea how I2C
works) or some random sequence of events i executed and I had at this point
IO[7] data as HIGH which means I2C was working at that exact moment.

tho i did decipher the GPIO1ExtAmpCFG=hex:01,00,00,01 which if you check
the schematics, the daisy-chained  CS42L83A codec is powered by GPIO1 on
CS8409 by keeping data=1, because there is pull-down on the CS42L83A's
CODEC_RESET_L.
There is also CODEC_INT_L which is the interrupt line, which is directly
tied to GPIO[0] on CS8409. This actually returns a constant data=1, which
gives some hope as well.
  IO[0]: enable=1, dir=0, wake=0, sticky=0, data=*1*, unsol=1


Opening AppleHDA in IDA reveals AppleHDAFunctionGroupCS4208::enableI2C(bool)
Anyone knowing anything about TDM Config in Cirrus Logic ? Enabling I2C ?
Is it Vendor specific verb ? Maybe it's some general way on most HDA's ?
The reason to have I2C disabled on reset is that some of the devices like
the amps and the speakers need to be configured in a specific order to save
power and to avoid sound glitches.

On Fri, Nov 23, 2018 at 7:26 PM David Ulricht <david.ulricht434@gmail.com>
wrote:

>
> Once when it's confirmed to work from user-space, we can think of the
>> kernel-side implementation, too.  Instead of setting up the whole
>> complex i2c subsystem, we may wire up the existing stuff in
>> sound/i2c/*, too.
>>
> Okay
>
> You should try to initialize over i2c over HD-audio GPIO pins using a
>> user-space program at first.  The GPIO pins can be read/written via
>> hda-verb as I already mentioned, hence you can access to i2c bus from
>> the user-space directly.
>
>
> I have written the following bash script,
>
>> #!/bin/bash
>> # DIR              0 (low) = out   40 (high) = in
>> #            low to write,      high to read
>> # SCL == 0x40      SDA == 0x80
>> function send() {
>> str1=$1
>> str2=$2
>> str3=$3
>> hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x$str1
>> # we send 0 to bus by enabling gpio_dir
>> hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x$str2
>> # we send data=0 to send to the bus
>> hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x$str3
>> }
>> # reads the values I set, no different return value from i2c/codec
>> function recv() {
>> hda-verb /dev/snd/hwC0D0 0x01 GET_GPIO_MASK 0x$str1
>> hda-verb /dev/snd/hwC0D0 0x01 GET_GPIO_DIR 0x$str2
>> hda-verb /dev/snd/hwC0D0 0x01 GET_GPIO_DATA 0x$str3
>> }
>>
>>
>> function send_sequence() {
>>     data=$1
>>         #split hexes by coma to be able to send 1 by 1
>>     hexes=$(echo $data|tr "," "\n")
>>     for hex in $hexes; do
>>         echo 'sending hex: ' $hex
>>         send 40 0 0 # 0 to scl
>>
> mask of SCL enabled, data 0 , dir 0, is that correct ?
>
>>         sleep 0.003
>>         send 80 0 $hex # send 0x28 to sda if $hex=28
>>
> mask of SDA enabled, direction 0, hex to data
>
>>         sleep 0.003
>>         send 0 40 40 # 1 to scl
>>
> mask of SCL disabled, direction 1, data 1
>
>>         sleep 0.003
>>         echo sent
>>     done
>> }
>>
> below i'm sending the hexes from Win10ini but in the exact same order,
> which worries me a bit, maybe they need to be reversed 4by4?
> like 01,90,02,00,11,01,02 could become: 00,02,90,01,02,01,11 .. because
> for the InitVerbs i did that reversing 4by4 and it works only correctly if
> the hexes are reversed 4by4. (at the end of the email i am attaching the
> exitverbs conversion which is perfect).
>
>> #initi2c
>> send_sequence
>> "01,90,3a,00,10,10,b0,00,1d,01,00,02,06,00,11,07,01,00,10,09,02,07,03,00,12,01,00,08,13,05,ff,06,00,07,20,02,0d,00,2a,02,02,03,00,04,00,05,02,06,00,07,20,08,02,09,00,0a,80,0b,02,0c,00,0d,a0,01,0c,00,29,02,01,03,02,04,00,05,00,01,01,00,11,01,0a,02,84,00,23,01,00,03,00,02,3f,00,20,01,03,00,1b,75,b6,73,c2,00,11,29,01,21,f3,03,20,05,00,12,00,13,80,00,1c,03,c0"
>> #streamstarti2c
>> send_sequence "01,90,02,00,11,01,02"
>> #powerup-amps
>> send_sequence
>> "04,28,2a,2c,2e,07,00,81,01,11,02,32,03,48,04,11,05,10,00,80"
>> send_sequence
>> "01,28,01,05,00,01,2a,01,05,02,01,2c,01,05,01,01,2e,01,05,03"
>> #streamstopi2c
>> send_sequence "01,90,02,00,11,01,0a"
>> #echo read
>> #recv 0 0 0
>>
>
> For example something that works is
>
> "ExitVerbs"=hex:00,05,17,00,01,00,75,04,00,00,74,04,82,00,75,04,00,00,74,04,03,\
>
> 00,75,04,00,80,74,04,04,00,75,04,01,28,74,04,06,00,75,04,00,80,74,04,07,00,\
>   75,04,01,28,74,04,65,00,75,04,00,00,74,04,00,03,77,04,03,05,17,00
>
>> hda-verb /dev/snd/hwC0D0 0x01 0x705 0x00
>> hda-verb /dev/snd/hwC0D0 0x47 0x500 0x01
>> hda-verb /dev/snd/hwC0D0 0x47 0x400 0x00
>> hda-verb /dev/snd/hwC0D0 0x47 0x500 0x82
>> hda-verb /dev/snd/hwC0D0 0x47 0x400 0x00
>> hda-verb /dev/snd/hwC0D0 0x47 0x500 0x03
>> hda-verb /dev/snd/hwC0D0 0x47 0x480 0x00
>> hda-verb /dev/snd/hwC0D0 0x47 0x500 0x04
>> hda-verb /dev/snd/hwC0D0 0x47 0x428 0x01
>> hda-verb /dev/snd/hwC0D0 0x47 0x500 0x06
>> hda-verb /dev/snd/hwC0D0 0x47 0x480 0x00
>> hda-verb /dev/snd/hwC0D0 0x47 0x500 0x07
>> hda-verb /dev/snd/hwC0D0 0x47 0x428 0x01
>> hda-verb /dev/snd/hwC0D0 0x47 0x500 0x65
>> hda-verb /dev/snd/hwC0D0 0x47 0x400 0x00
>> hda-verb /dev/snd/hwC0D0 0x47 0x703 0x00
>> hda-verb /dev/snd/hwC0D0 0x01 0x705 0x03
>>
>> Also InitVerbs from windows10ini and ExitVerbs from windows10ini reversed
> hexes 4by4 sent with hda-verb work perfect. They initiate the CS8409 codec
> or shut it down properly as i can see in the codec#0 status changing from
> D3 to D0 and D0 to D3.
> But the above exitverbs are sent to the widgets AFG node and the 0x47
> widget, (InitVerbs have a few more widgets).
>
> I tried to do the same for the InitI2C hexes, but apperently they are not
> supposed to be send as hexes directly to the widgets like InitVerbs or
> ExitVerbs. All the I2C related stuff are strictly I2C related for executing
> on the SDA/SCL GPIO7/6.
>
> So my idea is, do I need to reverse the hexes 4 by 4, when sending to the
> SDA ?
> And if you have any examples how can i get a read value from the SDA
> please.
>
>
> Btw:
> root@debian:~# cat /proc/asound/card0/codec#0 |head -n 25|tail -n 8
>   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[5]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[6]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[7]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
> the default values are IO7 which is GPIO7 which is SDA. is enabled=0 dir=0
> data=0
>
> root@debian:~# hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_MASK 0x80
> nid = 0x1, verb = 0x716, param = 0x80
> value = 0x0
> root@debian:~# hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DIR 0x0
> nid = 0x1, verb = 0x717, param = 0x0
> value = 0x0
> root@debian:~# hda-verb /dev/snd/hwC0D0 0x01 SET_GPIO_DATA 0x28
> nid = 0x1, verb = 0x715, param = 0x28
> value = 0x0
> After i send the above, data becomes data=1  but i sent 0x28.
>
> root@debian:~# cat /proc/asound/card0/codec#0 |head -n 25|tail -n 8
>   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[5]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[6]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
>   IO[7]: enable=1, dir=0, wake=0, sticky=0, data=1, unsol=0
>
> But if i read GPIO_DATA,
> root@debian:~# hda-verb /dev/snd/hwC0D0 0x01 GET_GPIO_DATA 0x0
> nid = 0x1, verb = 0xf15, param = 0x0
> value = 0x80
>
> the value returned is 0x80.
> Which leads me to the idea the only type of data you can send is either
> 0x40 for 1 on SCL, 0x80 for 1 on SDA, or 0x00 for 0 on both( if you enable
> mask of SCL it will send 0 to SCL only, and if you enable mask of SDA it
> will send 0 to SDA only).
>
> If thats true, you can only send 0/1 to the GPIOs, which means if i have
> to send the address of 1st SSM3515 "0x28", I have to send it as "101000" to
> the SDA.
>
> How could I try to read register 0x00 of I2C address 0x28  (one of the
> four SSM3515 amplifier) ? It should return value 0x83 according to the
> documentation of SSM3515 as a "reset value for register 0x00".
>
> If it is true that I can read data with GET_GPIO_DATA will it return as
> well only one bit of data like 0/1  at a time? If I need get a value of
> 0x83 thru the GPIO7 its binary value should be 10000011 , so this means
> that If i execute GET_GPIO_DATA   8 times in a row i will receive this
> piece by piece 1, 0 , 0 , 0 , 0 , 0 , 1, 1. Meanwhile I try to execute 8
> times GET_GPIO_DATA  should i be sending to the SCL (GPIO6) each time a
> clock value 0 ? or also a SET_GPIO_DATA value to the GPIO7 with value 0 for
> reading?
> Please advise.
>
