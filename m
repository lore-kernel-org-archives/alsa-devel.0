From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Delta 1010LT: S/PDIF clock source not
	working
Date: Thu, 11 Apr 2013 09:23:54 +0200
Message-ID: <5166650A.7080506@gmail.com>
References: <515EEF10.1020007@gmail.com> <5160C35A.8020403@gmail.com>
 <5161A6D3.3060602@gmail.com> <201304072135.45811.gineera@aspect135.co.uk>
 <51634B17.3050907@gmail.com> <516423F0.9020409@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 17368264F3D
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 09:23:56 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id e19so648917bku.12
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 00:23:55 -0700 (PDT)
In-Reply-To: <516423F0.9020409@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 09.04.2013 16:21, schrieb Pavel Hofman:
> On 9.4.2013 00:56, Jonas Petersen wrote:
>> Am 07.04.2013 22:35, schrieb Alan Horstmann:
>>> On Sunday 07 April 2013 18:03, Gabriel M. Beddingfield wrote:
>>>> On 04/06/2013 05:52 PM, Jonas Petersen wrote:
>>>>> It seems it's related to the ICE1712... I now tried the Audiophile
>>>>> 2496.
>>>>> Same behaviour! There is no way to clock from external (S/PDIF). The
>>>>> 'Multi Track Internal Clock Default' setting will always override the
>>>>> external clock rate and mess up the capturing.
>>>> Well, it /should/ work -- according to the 1010's manual.  I'll bet it's
>>>> some register setting that's missing on the ice1712 -- but I have no
>>>> access to the specs/datasheets/schematics on these things.
>>>>
>>>> I wonder -- did this ever work on Linux?
>> Yes! I while ago I was doing stuff with the Delta 66 and things were
>> fine. That was back with Ubuntu 10.04 and Alsa 1.0.22 and also 1.0.23.
>> I just grabbed an old Ubuntu 10.04 ISO which contains Alsa 1.0.22 and
>> live booted it on my machine. Tests show that it's working as expected
>> with the 1010LT: It's properly externally clocked.
>>
>>
>>> However I do seem to remember some relatively recent changes related
>>> to external wordclock on the 1010; maybe it has been broken?
>> I found commit b8b1a4cb6842fb33769be1ad636f062d31d588c3 from Jan 17
>> 23:20:03 2011. It's a patch on delta.c and it's regarding a clock issue
>> (though not exactly wordclock). I reverted that patch and recompiled but
>> no success.
>>
>> I'm going to continue later on that topic. At least there must have been
>> some change that broke it since 1.0.23.
> Hi Jonas,
>
> first - did you try with "Multi Track Rate Locking" on and off? This
> control is a bit clumsy.

I havn't tried so far, but did now. It has been 'off' all the time, but 
setting it to 'on' makes no difference.


> How about
> http://git.alsa-project.org/?p=alsa-kmirror.git;a=blobdiff;f=pci/ice1712/ice1712.c;h=fb61943fc4dc9631853d76fa2524cd51880bcd9a;hp=c7cff6f8168a2d0159a0df20ea2c97550dafd6db;hb=b125bc8783367e3eb65312039a29bf2f25e931db;hpb=3e3911eb86fc7016c9cfef0525b9568c3106c4e4
> ?
>
> It is from about that time.

Yeah, that's getting closer I guess. When I undo that commit, then it's 
possible to capture with the external rate!

*But*... I'm afraid it's still clocked from internal. Because it's not 
capturing cleanly. It's got glitches sometimes (without having xruns).


> pro_rate_locked is both when locked explicitly as well as when switched
> to spdif clock
>
> http://git.alsa-project.org/?p=alsa-kmirror.git;a=blob;f=pci/ice1712/ice1712.c;h=5be2e120a14e25a03744b873e690f765eecb9545;hb=ec10d549379e10b38fe365fbf6bc13bf44f965ac#l133

How strange.. but there's probably a reason for rate locking on spdif 
clock..

> Please check ice1712 register values, specifically MT RATE to make sure
> ice1712 is switched to internal clocks when it should be clocked
> externally instead (
> http://ftp.sunet.se/pub/Linux/alsa/manuals/icensemble/envy24.pdf ). Or
> just dump  ice1712 in proc here, I will check with the datasheet.

I'm not sure, is it 'Codec' in ice1712 that's 'PCI60: System 
Configuration Register' in the datasheet? From that the clock source 
would be '00: XIN2: 22.5792MHz crystal (44.1kHz*512)'.

Here's my ice1712:
-------------------------------------------
M Audio Delta 1010LT at 0xd040, irq 20

EEPROM:
   Subvendor        : 0x12143bd6
   Size             : 29 bytes
   Version          : 1
   Codec            : 0x1f
   ACLink           : 0x80
   I2S ID           : 0x72
   S/PDIF           : 0x3
   GPIO mask        : 0x4
   GPIO state       : 0x7e
   GPIO direction   : 0xfb
   AC'97 main       : 0x0
   AC'97 pcm        : 0x0
   AC'97 record     : 0x0
   AC'97 record src : 0x44
   DAC ID #0        : 0x3
   DAC ID #1        : 0x3
   DAC ID #2        : 0x3
   DAC ID #3        : 0x3
   ADC ID #0        : 0x3
   ADC ID #1        : 0x3
   ADC ID #2        : 0x3
   ADC ID #3        : 0x3
   Extra #28        : 0x0

Registers:
   PSDOUT03         : 0x0000
   CAPTURE          : 0x00000000
   SPDOUT           : 0x0000
   RATE             : 0x10
   GPIO_DATA        : 0x5a
   GPIO_WRITE_MASK  : 0x04
   GPIO_DIRECTION   : 0xfb
-------------------------------------------

With "Multi Track Internal Clock" on "IEC958 Input" the content of 
ice1712 has not changed at all, no matter what ("Default") rate I select 
or rate I capture. Also before and after reverting the patch it's the 
same content.

When I change "Multi Track Internal Clock" to some specific rate then 
(only) RATE and GPIO_DATA change. E.g.:

44100:
   RATE             : 0x08
   GPIO_DATA        : 0x52

48000:
   RATE             : 0x00
   GPIO_DATA        : 0x52

96000:
   RATE             : 0x07
   GPIO_DATA        : 0x53

For some reason GPIO_DATA will now stay on 0x53 when I switch to "IEC958 
Input" (before it was fixed on 0x5a).


> Unfortunately there is no /proc register dump coded for cs8427 yet. If
> you want to investigate further, you can add it to i2c/cs8427.c in a
> manner similar to e.g.
> http://git.alsa-project.org/?p=alsa-kmirror.git;a=blob;f=i2c/other/ak4114.c;h=fdf3c1b65e388414c995a597ef2b351b4ec2a220;hb=HEAD#l451

I'm working on it...


- Jonas
