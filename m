From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/2] ALSA: oxfw: discontinue MIDI substream
 for scs1x at transaction failure
Date: Sat, 20 Feb 2016 00:51:55 +0900
Message-ID: <56C73A1B.3040008@sakamocchi.jp>
References: <1455843350-10156-1-git-send-email-o-takashi@sakamocchi.jp>
 <1455843350-10156-3-git-send-email-o-takashi@sakamocchi.jp>
 <s5hpovt1599.wl-tiwai@suse.de> <56C6DF18.3080708@sakamocchi.jp>
 <s5hh9h5t4lv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id CC3AB2614CB
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 16:51:58 +0100 (CET)
In-Reply-To: <s5hh9h5t4lv.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Feb 19 2016 18:46, Takashi Iwai wrote:
> On Fri, 19 Feb 2016 10:23:36 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> On Feb 19 2016 17:19, Takashi Iwai wrote:
>>> On Fri, 19 Feb 2016 01:55:50 +0100,
>>> Takashi Sakamoto wrote:
>>>>
>>>> With a previous commit, ALSA oxfw driver retries transferring MIDI
>>>> messages at transaction failure for scs1x. On the other hand, there're
>>>> fatal transaction error. Then, MIDI messages never reach to the unit
>>>> anymore. In this case, MIDI substream should be discontinued.
>>>>
>>>> This commit stops MIDI transferring after the fatal error occurs.
>>>> Unfortunately, unlike ALSA PCM functionality, ALSA rawmidi core has no
>>>> feature to discontinue MIDI substream in kernel side, thus this commit
>>>> just stops MIDI transferring without notifying it to userspace.
>>>
>>> It's fine to take this, and I would take it as is for now.
>>
>> OK.
>>
>>> But we can extend the rawmidi somehow to deal with such an error, too.
>>> Maybe just having "error" flag in the rawmidi runtime and adding a
>>> helper function to set the error and stop the stream should work
>>> easily.
>>
>> You forgot ALSA sequencer.
> 
> This is a different layer.  The sequencer stuff may check the error
> and handle more gracefully than as of now, but it's a different story
> from the extension of rawmidi itself.
> 
> What you're working on is the rawmidi, and what it can give is just
> returning an error at the right moment.

I don't think so. I think the work is heavier than your expectation.

I pushed 'rawmidi-epipe' branch to my repository.
https://github.com/takaswie/sound/tree/rawmidi-epipe

You can see four commits just to show my concerns.
(They're not tested yet. Don't use them for actual work ;)
41f499b ALSA: rawmidi: add a helper to set runtime error
4164edb ALSA: rawmidi: handle EPIPE
5e7348ed ALSA: seq: handle EPIPE for rawmidi input
58d9008 ALSA: seq: handle EPIPE for rawmidi output

In the top-most commit, you can see userspace applications need to
close/open character devices to recover from EPIPE state of rawmidi
substream runtime. Furthermore, this also means that kernel
implemenation such as ALSA sequencer also need to destroy/create rawmidi
substream.

The main reason of them is ALSA rawmidi core has no functionality for
recovery feature. In ALSA PCM core, 'struct snd_pcm_ops.prepare' has a
role for it.

>> I had considered about it when working for snd-firewire-digi00x (Mar 
>> 2015), and realised that it may take much time. At least, we work for:
>>   - ALSA rawmidi core
>>   - ALSA rawmidi interface for userspace
> 
> We don't need to extend rawmidi user-space API so much.  Again, what
> needed is to return an error at read/write, probably -EPIPE, right
> after the driver got a hardware error.  For that, just adding
> runtime->error flag and checking it appropriate should suffice (in
> theory).  The read/write in rawmidi is pretty simple.  And we don't
> have to reset the flag until the stream is reopened.  There is no
> setup/preparation phase for rawmidi unlike PCM.
> 
>> Additionally, users mostly use rawmidi devices via ALSA sequencer:
>>   - ALSA sequencer core
>>   - ALSA sequencer interface for userspace
>>
>> Furthermore, regression test is required for:
>>   - ALSA drivers with MIDI functionality
>>   - ALSA rawmidi/sequencer applications in userspace
>>
>> It's not 2000s. I guess that little developers are attracted for this 
>> work. In my option, the work is really cost-expensive than actual merit. 
>> So currently I'm negative for the idea.
> 
> A regression test is needed of course, but a simple error check
> can't regress except for the driver that really supports it.


Regards

Takashi Sakamoto
