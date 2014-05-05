From: Delcypher <delcypher@gmail.com>
Subject: Fwd: Regression Intel Corporation Haswell-ULT HD Audio
	Controller
Date: Mon, 5 May 2014 09:56:28 +0100
Message-ID: <CANNJ_zh7EO8XgZmEivTBVeWQZpckh_aiokhO7Wy=D-mFTY21fw@mail.gmail.com>
References: <CANNJ_zh6HXT-pdkOV9XpDor3J1aFVbi3zbHLyDnpgisu7DdMdA@mail.gmail.com>
 <s5h1tw8irg9.wl%tiwai@suse.de>
 <CANNJ_zj_aTm5qKG-5U4SgwL-vKeJS5c5YYEPsKGiq_UFW8dgZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f171.google.com (mail-ve0-f171.google.com
 [209.85.128.171])
 by alsa0.perex.cz (Postfix) with ESMTP id A01B9261B1A
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 10:56:29 +0200 (CEST)
Received: by mail-ve0-f171.google.com with SMTP id oz11so690199veb.30
 for <alsa-devel@alsa-project.org>; Mon, 05 May 2014 01:56:28 -0700 (PDT)
In-Reply-To: <CANNJ_zj_aTm5qKG-5U4SgwL-vKeJS5c5YYEPsKGiq_UFW8dgZA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Apologies. The alsa-devel mailing list just rejected my last e-mail
due to the large attachments. Here is the same e-mail again without
attachments and links to the relevant files instead. Sorry for the
noise.


---------- Forwarded message ----------
From: Delcypher <delcypher@gmail.com>
Date: 5 May 2014 09:46
Subject: Re: [alsa-devel] Regression Intel Corporation Haswell-ULT HD
Audio Controller
To: Takashi Iwai <tiwai@suse.de>
Cc: David Henningsson <david.henningsson@canonical.com>, Po-Hsu Lin
<po-hsu.lin@canonical.com>, ALSA Development Mailing List
<alsa-devel@alsa-project.org>


Thank you for your suggestions:

If I run

$ amixer -c0 get Capture
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 63
  Front Left: Capture 63 [100%] [30.00dB] [on]
  Front Right: Capture 63 [100%] [30.00dB] [on]

So I think it's currently already on (I think I may of switched it on
after running the script, but it didn't make any difference). I ran ``
amixer -c0 set Capture cap`` and it didn't fix my microphone issue.

I also tried using model=nofixup and that didn't fix the microphone
issue either :(

I just tried doing something different and to my surprise it fixed my
microphone issue, i.e. after doing this the following commands

$ arecord -d 5 test.wav
$ aplay test.wav

work (test.wav isn't complete silence).

There was one mixer control in alsamixer that I hadn't touched with
the name "Digital". I had not played with it before because I presumed
it shouldn't have anything to do with the internal microphone. I
changed it from 0 to some non zero value and to my surprise my
internal microphone now works.

So is this a bug or an intended feature? I've attached the output of
alsa-utlils-alsa-info.sh before and after the mixer adjustment in the
hope that it will help.

**EDIT**: Links to output.
Before: https://gist.github.com/delcypher/d9a05a393c7a36d44dad
After: https://gist.github.com/delcypher/f75c3f8c543866f6a2e0



On 5 May 2014 09:02, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 3 May 2014 12:57:55 +0100,
> Delcypher wrote:
>>
>> Hi,
>>
>> I was told to report my bug here because the ALSA bug tracker is no
>> longer active.
>>
>> I'm having an issue with " Intel Corporation Haswell-ULT HD Audio
>> Controller" card which is inside the Dell XPS13 9333 developer edition
>> [1].
>>
>> I've tried two different distributions
>>
>> * Arch Linux (kernel 3.14)
>> Output of alsa-utlils-alsa-info.sh [2]
>>
>> * Ubuntu 14.04 LTS (kernel 3.13)
>> Output of alsa-utlils-alsa-info.sh [3]
>>
>> The card behaves correctly under Ubuntu but under Arch Linux I've
>> observed the following issues.
>>
>> - The microphone does not work correctly. In alsamixer I select
>> "Internal Mic" as my capture device but when I do
>>
>> $ arecord -d 5 test.wav
>> $ aplay test.wav
>>
>> test.wav contains silence.
>>
>> I've also tried enabling/disabling "CAPTURE" on the Capture channel at
>> the same time - I don't really understand why this channel is here
>> (seems a little bizarre) but enabling/disabling "CAPTURE" on this
>> channel doesn't seem to make any difference anyway. Under Ubuntu the
>> "arecord... aplay" command works correctly.
>>
>> - There probably isn't a way to reproduce this but when I first
>> installed Arch Linux the sound card was put in a state where the
>> headphone jack would not work at all. Sound would continue playing out
>> of the speakers when the headphone jack was inserted and no sound
>> would come out of the headphones. I did notice that if the headphone
>> jack was only partially inserted I would get some sound sent to one of
>> the headphones.
>>
>> My intuition is that the card is probably being incorrectly
>> initialised because if you take a look at the output of
>> alsa-utils-alsa-info.sh and diff them. Two very big differences I
>> noticed were that
>>
>> - The card name (from lscpi) is "Intel Corporation Haswell-ULT HD
>> Audio Controller" under Ubuntu but under Arch Linux it is "Intel
>> Corporation Device 0a0c"
>> - The card codec is "Realtek ALC668" under Ubuntu but is "Realtek
>> ALC3661" under Arch Linux.
>>
>> One interesting I did notice is that under Arch Linux it is possible
>> to use the microphone from the Audacity program by selecting "HDA
>> Intel PCH: ALC3661Analog (hw0:0) Internal mic:0" as the input (this is
>> not the default). Unfortunately I know of no way to make other
>> applications use this.
>>
>> Any thoughts on how to fix this?
>>
>> [1] http://www.dell.com/uk/business/p/xps-13-linux/pd
>> [2] https://gist.github.com/delcypher/11367224
>> [3] https://gist.github.com/delcypher/11367302
>
> The "Capture Switch" is off, according to alsa-info.sh output.
> Try to turn it on.
>    % amixer -c0 set Capture cap
>
> If this doesn't help, it must be a quirk added in 3.14 kernel:
>   commit f47e5dc464251f661da9495fcbf003a0d22c1360
>   ALSA: hda - Add a headset quirk for Dell XPS 13
>
> I added relevant people in Cc.
>
> Meanwhile, you can try to pass model=nofixup to snd-hda-intel module
> for avoiding the added fixup above.
>
>
> thanks,
>
> Takashi
