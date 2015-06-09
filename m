From: Adam Goode <adam@spicenitz.org>
Subject: Re: Scarlett 18i8 hardware out of sync with AlsaMixer
Date: Tue, 9 Jun 2015 17:44:36 -0400
Message-ID: <CADN=WdqTjFPeFeTsEHxwbqR8YmTwqhNvp6d3eJP3BPgCNeUGnw@mail.gmail.com>
References: <CADN=WdobTC9qdHjKD3PyPW99f2pX-j82vVzZ32zp4ed-C0Gbgg@mail.gmail.com>
 <s5h8ucaed12.wl-tiwai@suse.de>
 <CADN=WdpM_gUD=TpxP9cJmS3VXRwzgODgNeNE0Z2EwC71mZ8yAw@mail.gmail.com>
 <s5hzj4q9mri.wl-tiwai@suse.de> <20150527135325.GA12862@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 20CD12657A5
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 23:44:58 +0200 (CEST)
Received: by oigz2 with SMTP id z2so20227951oig.1
 for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2015 14:44:57 -0700 (PDT)
In-Reply-To: <20150527135325.GA12862@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chris J Arges <chris.j.arges@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Robin Gareus <robin@gareus.org>
List-Id: alsa-devel@alsa-project.org

I haven't tried the patch yet, but I will try to this week.

Non-enum settings are affected.

What firmware are you running? I have the newest beta firmware
(Scarlett MixControl 1.9b4)
http://beta.focusrite.com/releases/scarlett_mixcontrol/


The other thing to try is to use Mixcontrol and save some settings
into the hardware. I did this once on Windows to use the device before
ALSA supported its mixer.


Adam



On Wed, May 27, 2015 at 9:53 AM, Chris J Arges
<chris.j.arges@canonical.com> wrote:
> On Wed, May 27, 2015 at 03:24:17PM +0200, Takashi Iwai wrote:
>> [Added more people to Cc]
>>
>> At Wed, 27 May 2015 08:55:21 -0400,
>> Adam Goode wrote:
>> >
>> > The settings were not reset across a mem sleep (echo mem > /sys/power/state).
>> >
>> > Hard power off / power on does make the settings get out of sync.
>>
>
> Ok did some testing on my Scarlett 18i8:
>  suspend/resume -> settings not reset
>  poweroff/poweron -> settings not reset
>  unplug/replug usb -> settings not reset
>  powercycle unit -> settings not reset
>
> Is there a more consistent method to trigger this issue?
> In addition are you manually triggering 'alsactl restore/save' in this process?
>
> I'll do some additional testing to see if I can trigger this.
>
>> Then maybe the problem is that the device keeps the old setting while
>> the driver resets to the default.  I vaguely remember that scarlett
>> could save the default state in a persistent area, and the original
>> driver patch had a kctl to trigger it.  We didn't take it because it
>> might be dangerous.
>>
>>
>
> The original issue was this:
>   Hey, as Tobias mentioned this is a HW saving (to the mixer's NVRAM)
>   function used for using the mixer disconnected from a computer. We
>   wouldn't want to continually write the NVRAM on every control update as
>   I'm unsure of how many write-cycles the device is capable of.
>
> So if we wrote to NVRAM on each control update we might wear out the memory
> very quickly. I think this functionality is more for using the device
> disconnected from a computer.
>
>> Takashi
>>
>>
>> > Adam
>> >
>> >
>> > On Wed, May 27, 2015 at 2:43 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > > At Tue, 26 May 2015 21:39:22 -0400,
>> > > Adam Goode wrote:
>> > >>
>> > >> Linux 4.0.2-300.fc22.x86_64
>> > >>
>> > >> Hi,
>> > >>
>> > >> I have the Scarlett 18i8 USB device that is supported by the new
>> > >> scarlett_mixer.c code. I am happy to say that the mixer code works in
>> > >> most cases. But under some conditions, I cannot get any sound out of
>> > >> the device until I go and toggle the "Matrix 01 Input" and "Matrix 02
>> > >> Input" enums up and then down (from PCM 1 and PCM 2). This appears to
>> > >> me to be some kind of cache invalidation bug, where the device is out
>> > >> of sync with kernel mixer state.
>> > >>
>> > >> I will take a look at the code myself at some point, but not for a
>> > >> while. But I am happy to try patches if anyone comes up with anything
>> > >> in the mean time.
>> > >
>
> Does this change anything (untested)? And are non-enum settings affected?
>
> diff --git a/sound/usb/mixer_scarlett.c b/sound/usb/mixer_scarlett.c
> index 7438e7c..ad4a452 100644
> --- a/sound/usb/mixer_scarlett.c
> +++ b/sound/usb/mixer_scarlett.c
> @@ -438,11 +438,9 @@ static int scarlett_ctl_enum_put(struct snd_kcontrol *kctl,
>
>         val = ucontrol->value.integer.value[0];
>         val = val + opt->start;
> -       if (val != oval) {
> -               snd_usb_set_cur_mix_value(elem, 0, 0, val);
> -               return 1;
> -       }
> -       return 0;
> +       /* always set cur mix value */
> +       snd_usb_set_cur_mix_value(elem, 0, 0, val);
> +       return 1;
>  }
>
>  static int scarlett_ctl_enum_resume(struct usb_mixer_elem_list *list)
>
> --chris
>
>> > > Does it happen after some S3/S4 or even during a normal operation
>> > > without power-saving?  The USB-audio device supports autopm, so this
>> > > needs to be checked, too.
>> > >
>> > >
>> > > Takashi
>> >
>>
