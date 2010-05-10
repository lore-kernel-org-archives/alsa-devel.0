From: Thoralf Freitag <thoralf.freitag@cactus-online.de>
Subject: Re: Mute LED on HP Pavilion DV7-1160eg
Date: Mon, 10 May 2010 22:10:23 +0200
Message-ID: <4BE8682F.4010307@cactus-online.de>
References: <4BDC8CC2.5040507@cactus-online.de> <s5h6331tpha.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 470BC24866
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 22:10:30 +0200 (CEST)
In-Reply-To: <s5h6331tpha.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb:
> At Sat, 01 May 2010 22:19:14 +0200,
> Thoralf Freitag wrote:
>   
>> I tried to find a way for switching/control Mute LED on an HP DV 7
>> notebook. I found a solution which is very ugly. According the solution
>> described here
>> (http://mailman.alsa-project.org/pipermail/alsa-devel/2009-April/016126.html)
>> I changed the value for LED control in this manner:
>>
>> diff -u alsa-driver-1.0.23/sound/pci/hda/patch_sigmatel.c
>> alsa-driver-1.0.23_b/sound/pci/hda/patch_sigmatel.c
>> --- alsa-driver-1.0.23/sound/pci/hda/patch_sigmatel.c    2010-04-16
>> 13:10:10.000000000 +0200
>> +++ alsa-driver-1.0.23_b/sound/pci/hda/patch_sigmatel.c    2010-05-01
>> 21:37:36.719063655 +0200
>> @@ -4952,9 +4952,9 @@
>>          }
>>      }
>>      if (muted)
>> -        spec->gpio_data &= ~spec->gpio_led; /* orange */
>> +        spec->gpio_data &= ~0x01; /* orange */
>>      else
>> -        spec->gpio_data |= spec->gpio_led; /* white */
>> +        spec->gpio_data |= 0x01; /* white */
>>  
>>      if (!spec->gpio_led_polarity) {
>>          /* LED state is inverted on these systems */
>>
>> I hate this solution. Maybe someone of the programming experts could
>> give me a way to make it better. On which position should I make which
>> changes ?
>>     
>
> The mute LED is set up in find_mute_led_gpio().
> If your BIOS doesn't give the proper information, you can add the device
> statically in hp_blike_system().
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>   
Takashi, thanks for your advice. Maybe I found the problem. Adding my
card to hp_blike_system() doesn't change anything. The driver identifies
the card (laptop) successfully as a HP DV7 (because the bass speaker is
usable and can switched on or off with tools like Alsamixergui), with or
without an entry in hp_blike_system() like this: case 0x103c30fc: .

As I identified, the problem is located in set_hp_led_gpio. This
function assumes, if it counts more than 3 io's, the GPIO 3 is
responsible for controlling of mute LED. Maybe it is right in some
cases, but not in all. For the HP7-1160eg (and  probably not only on
this notebook) GPIO 0 controlls the mute LED, but the counter is

I could fix it by changing the value from 3 to 8 in static void
set_hp_led_gpio(struct hda_codec *codec). I don't know, there the value
of 3 comes from. But I afraid, it could causing a lot of side effects.
Who knows, why the threshold value is set greater then 3 ?

kaktus@elefant-lin:~$ diff
alsa-driver-1.0.23_a/alsa-kernel/pci/hda/patch_sigmatel.c
alsa-driver-1.0.23_b/alsa-kernel/pci/hda/patch_sigmatel.c

4769c4769
<     if (gpio > 3)
---
>     if (gpio > 8)


This is the function:

static void set_hp_led_gpio(struct hda_codec *codec)
{
        struct sigmatel_spec *spec = codec->spec;
        unsigned int gpio;

        gpio = snd_hda_param_read(codec, codec->afg, AC_PAR_GPIO_CAP);
        gpio &= AC_GPIO_IO_COUNT;
        if (gpio > 8)
                spec->gpio_led = 0x08; /* GPIO 3 */
        else
                spec->gpio_led = 0x01; /* GPIO 0 */
}


Here are some information about my sound-card. hda_analyzer shows:

Codec: 0x111d76b2
Address: 0
Function Id: 0x101
Vendor Id: 0x111d76b2
Subsystem Id: 0x103c30fd
Revision Id: 0x100302
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
GPIO: io=8, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=1, dir=1, wake=0, sticky=0, data=0, unsol=0
  IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[5]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
  IO[6]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[7]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0


What should I do for for making a reliable patch. Any ideas ?

Thanks.

TF
