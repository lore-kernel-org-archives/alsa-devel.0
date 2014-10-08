From: Tobias Hoffmann <smilingthax@googlemail.com>
Subject: Re: [WIP PATCH] Scarlett mixer interface for 6i6, 18i6,
 18i8 and 18i20.
Date: Thu, 09 Oct 2014 00:06:09 +0200
Message-ID: <5435B551.9050302@googlemail.com>
References: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>
 <54358AA6.7040205@zonque.org> <5435AAF2.5040909@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ED402604CC
 for <alsa-devel@alsa-project.org>; Thu,  9 Oct 2014 00:06:19 +0200 (CEST)
Received: by mail-lb0-f171.google.com with SMTP id z12so13288lbi.30
 for <alsa-devel@alsa-project.org>; Wed, 08 Oct 2014 15:06:18 -0700 (PDT)
In-Reply-To: <5435AAF2.5040909@gareus.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robin Gareus <robin@gareus.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, David Henningsson <david.henningsson@canonical.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

On 08/10/14 23:21, Robin Gareus wrote:
> Thanks David for picking this up.
>
> On 10/08/2014 09:04 PM, Daniel Mack wrote:
>>> +
>>> +/* #define WITH_METER */
>>> +/* #define WITH_LOGSCALEMETER */
>> These should either be converted to module parameters, or removed
>> alltogether. Why are they configurable, anyway?
> Mainly because I lost interest in Focusrite devices before finishing the
> work. They were handy during initial development and the idea was to
> just enable them by default at some point.
>
> Last I checked they both worked fine for the 18i6, but it seems support
> other Scarlett devices is missing and/or untested, so I guess they're
> commented out for that reason.

AFAIR in the latest version something crashes when opening such 
"channels" with (I think) alsamixer.
I didn't even try to debug that, because no Mixer-GUI could actually 
display "realtime" metering data by periodically polling channel values, 
IIRC. The even bigger problem is, that the Scarlett HW returns all 
metering data at once (for a given metering point), e.g. all 18 inputs 
together, in contrast to the mixer-channels, where each value can be set 
separately.
Naively mapped, one would get three snd_kcontrols (metering points: 
input, mix, pcm) with snd_ctl_elem_info::count = 18, 6, 18 (e.g.). 
Alternatively, the driver would have to read all values, cache them 
internally and expose them as separate snd_kcontrols. In either case, a 
mixer GUI probably still has to have special knowledge about the card to 
display the values in a helpful way.

Other drivers seem to use the hwdep-API for things like metering.
I do not understand the hwdep-API enough to implement it as such.
And as trrichad wrote a GUI [1], that can be used to display the hwdep 
data correctly.

The one reason why the metering code is still in the driver (and 
disabled), is because it basically documents how to read the metering 
values...

>
>> +#define CTL_SWITCH(cmd, off, no, count, name) \
>> +	do { \
>> +		err = add_new_ctl(mixer,&usb_scarlett_ctl_switch, cmd, off, no, 2,
> count, name, NULL,&elem); \
>> +		if (err<  0) \
>> +			return err; \
>> +	} while (0)
> curious, why "do { } while (0)" and not just  "{ }" ?

I didn't even have { }, it was just
     err = ...;
     if (err<0) return err;

I would guess checkpatch suggested to add "do {} while(0)" for style 
reasons?


>
>> Hmm, I don't really like the style of magically returning from macros
> Yes, same here. I'm initially responsible for one such macro and wanted
> to get rid of it. I'm sorry if that lead Tobias to adding more in that
> style.

No, it's not your fault. I tried other ways, but the code only became 
less readable:
  - each operation can return an error, which has to be checked. Adding 
the error checks everywhere (i.e. inlining the macros) just clutters the 
code.
  - CTL_ENUM, INIT and CTL_MIXER are called in a loop, based on data in 
the static sXiY_info device info structs. And you don't want arrays with 
 >100 entries *for each supported Scarlett type*.
  - also add_output_ctls() calculates some of the values from the 
function arguments.
  - In many places the same macro (e.g. CTL_SWITCH) isn't actually 
repeated that often, but different CTL_* are used.

Still, some macros can probably be inlined, and esp. the device-specific 
scarlett_sXiY_controls init functions now turn out to be similar enough 
that a static struct entries per device and a generic init  function 
based on these entris seem to make sense.

   Tobias

[1] https://github.com/trrichard/ScarlettMixer
