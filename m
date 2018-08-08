From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: Spectre x360 fixing the top speakers (again)
Date: Tue, 7 Aug 2018 22:55:42 -0500
Message-ID: <b0769dfe-6954-6dac-37b6-d11073a8d801@gmail.com>
References: <b34c110f-b5a0-6c02-4ad6-efb1990492bd@gmail.com>
 <s5h600ou4x8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 by alsa0.perex.cz (Postfix) with ESMTP id B72EA267898
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 05:55:45 +0200 (CEST)
Received: by mail-it0-f68.google.com with SMTP id d10-v6so1762782itj.5
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2018 20:55:45 -0700 (PDT)
In-Reply-To: <s5h600ou4x8.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: tom@decompile.me.uk, alsa-devel@alsa-project.org, Kailang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 08/05/2018 11:57 AM, Takashi Iwai wrote:
> On Sun, 05 Aug 2018 18:28:57 +0200,
>   Alex G.  wrote:
>>
>> It's only been since 4.18-rc2 that the speaker issue on the x360 [1]
>> was resolved. I didn't even know I had four speakers until seeing that
>> bug report. My HP Spectre x360 (13-ae0xx) has the same issue as the
>> original x360 with Bang speakers.
>>
>> The subsystem PCI ID is different [103c:83b9]. Of the two fixes
>> developed in [1], only the mute led fix works when the PCI id is added
>> to patch-realtek. If I try to add the full ALC295_FIXUP_HP_X360 fix,
>> there's no audio coming out at all.
>>
>> One thing I tried was to boot W10 virtual machine and redirect the
>> audio PCI device to the VM:
>> 0:1f.3 Audio device: Intel Corporation Sunrise Point-LP HD Audio (rev 21)
>> It all worked in the VM, but as soon as I shut it down and tried to
>> play audio from linux, the top speakers still didn't work. The
>> difference being that PAVUcontrol could see a "4.0 output"
>> configuration. The same issue: audio sent to the bottom speakers was
>> heard, but audio sent to the top speakers was not.
>>
>> Since I'm likely going to have to change _everything_ anyway, here's
>> what I'm trying to achieve:
>>
>>
>> 1) Make the top speakers great again. Whether they produce the same
>> sound as the bottom speakers, or have their own audio channel, I don't
>> care that much.
> 
> Well, "again" -- you have never got it working on Linux, right?

"Again" in the sense that HP f'd it up again, the same way they did with 
the original x360. And I say f'd instead of messed up, because even in 
windows, two outputs show up, but only one of them produces any sound 
(out of all four speakers).

> The top speaker thing is likely the missing initialization of I2S amp,
> EQ or DRC, which seem to be done via vendor-specific COEF verbs.

I2S amp? I was under the impression the codec has a DAC for that. This 
isn't really making much sense.

> The Windows VM work just because these initializations are done in
> Windows side.  You'd need to get these init verbs, but it's a tough
> issue.  The best would be to get the proper data from the vendor.
> Unfortunately HP seems have zero interest in supporting the device on
> Linux at all.  Luckily we've got the data kindly from Realtek at the
> previous time for one x360 model after Tom's great effort.

If the VM configures the magic to a working state, shouldn't it stay 
working after the VM is killed and linux takes over? I don't see 
anything to to de-init the work the windows driver has done.

> Hopefully Kailang (Cc'ed here) may ask his colleagues and get some
> info...
> 
> 
>> 2) Be able to use the speakers when something is plugged in the
>> headphone jack. Right now it's stupid. I try to plug in a microphone
>> (with the proper TRRS jack), and the speakers die. I haven't seen this
>> before. I was playing with HDA-Analyzer and was able to get speaker
>> sounds with a dummy plugged in the jack, so I know it's possible. I
>> don't remember how I did it, and it only worked once.
> 
> The TRRS handling is again very much vendor-specific, and most likely
> one of the existing methods may fit.  Check the headset-related
> helpers and callbacks in patch_realtek.c.

Ah. I was hoping it might be as simple as figuring out how to drive the 
EAPD lines. I did have this somewhat working messing around with 
HDA-analyzer, but... and here's the rub... I haven't found a consistent 
way to do it.

Alex

> Takashi
> 
>> 3) (optional) see if there's a way to use the jack as a line in or
>> stereo mic in.
>>
>> I'm not sure where to start.
>>
>> Alex
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=189331
>>
