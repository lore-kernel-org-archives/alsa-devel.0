From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: future of sounds/oss
Date: Thu, 11 May 2017 19:01:45 +0900
Message-ID: <7f6490a7-b39f-1294-8c5f-14d6161d28c6@sakamocchi.jp>
References: <20170511082133.GA20304@lst.de> <s5hh90rhjbc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hh90rhjbc.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On May 11 2017 17:46, Takashi Iwai wrote:
> On Thu, 11 May 2017 10:21:33 +0200,
> Christoph Hellwig wrote:
>>
>> Ho Jaroslav, hi Takashi,
>>
>> do you know who still uses the sound/oss drivers and why?  I've
>> recently been looking into getting rid of set_fs for using
>> copy_{from,to}_user and friends on kernel pointers, and the sound
>> code is a big abuser, both ALSA and the legacy OSS code.
>
> Yeah, I also started looking at it after reading the LWN article.
> The removal of set_fs() in ALSA part was already finished, and I'm
> currently brushing up the patches.  It'll be in 4.13 at latest.

Eventually, I'm also working for it[1]. I'm willing to review your 
changes, so please add me into CC list when you post patches.

Instead, In this development cycle, I'll post my patches for tracepoints 
for PCM parameter handling and misc refactoring[2]. (I've already done 
most of the work.)

> But the set_fs() usage in OSS code is hard to get rid of, due to the
> in-kernel ioctl calls, and I really don't want to touch such dusty
> codes, either.  So I wanted to post the very same question, but you
> were faster :)
>
>> But looking at the OSS code it's pretty grotty, and also appears
>> to be pretty much unmaintained except for global cleanups.  Is there
>> any chance we could look into getting rid of it over the next few
>> merge windows or are there people that rely on it?
>
> I don't think there are any active users.  The only slight concern is
> that there are a few ancient devices that are supported only by some
> OSS drivers.  But these are over decades, and very unlikely alive.
>
> That said, I'd love to drop that legacy stuff; or maybe as a
> soft-landing, begin with disabling the build of sound/oss in Kconfig.
>
> The latter can be done even for 4.12, if Linus doesn't mind.

I think we don't need to care of drivers implemented with Open Sound 
System. In my understanding, stuffs in 'sound/core/oss/*' give Open 
Sound System compatibility layer for Open Sound System applications. In 
short, it gives a way for the applications to use drivers in ALSA by 
Open Sound System interfaces. Even if this layer is missing, the 
applications are still available with Open Sound System Proxy Daemon[3] 
with FUSE/CURE assistances. I believe we can get rid of them without any 
actual disadvantages.

[1] https://github.com/takaswie/sound/tree/topic/segment-in-pcm
[2] https://github.com/takaswie/sound/tree/topic/trace+refactor
[3] https://github.com/libfuse/osspd


Regards

Takashi Sakamoto
