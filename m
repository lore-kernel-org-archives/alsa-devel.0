From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: future of sounds/oss
Date: Thu, 11 May 2017 19:36:47 +0900
Message-ID: <4da9ce4b-b2dc-800c-ede2-f6c05b286dbe@sakamocchi.jp>
References: <20170511082133.GA20304@lst.de> <s5hh90rhjbc.wl-tiwai@suse.de>
 <7f6490a7-b39f-1294-8c5f-14d6161d28c6@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7f6490a7-b39f-1294-8c5f-14d6161d28c6@sakamocchi.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On May 11 2017 19:01, Takashi Sakamoto wrote:
>> But the set_fs() usage in OSS code is hard to get rid of, due to the
>> in-kernel ioctl calls, and I really don't want to touch such dusty
>> codes, either.  So I wanted to post the very same question, but you
>> were faster :)
>>
>>> But looking at the OSS code it's pretty grotty, and also appears
>>> to be pretty much unmaintained except for global cleanups.  Is there
>>> any chance we could look into getting rid of it over the next few
>>> merge windows or are there people that rely on it?
>>
>> I don't think there are any active users.  The only slight concern is
>> that there are a few ancient devices that are supported only by some
>> OSS drivers.  But these are over decades, and very unlikely alive.
>>
>> That said, I'd love to drop that legacy stuff; or maybe as a
>> soft-landing, begin with disabling the build of sound/oss in Kconfig.
>>
>> The latter can be done even for 4.12, if Linus doesn't mind.
>
> I think we don't need to care of drivers implemented with Open Sound
> System. In my understanding, stuffs in 'sound/core/oss/*' give Open
> Sound System compatibility layer for Open Sound System applications. In
> short, it gives a way for the applications to use drivers in ALSA by
> Open Sound System interfaces. Even if this layer is missing, the
> applications are still available with Open Sound System Proxy Daemon[3]
> with FUSE/CURE assistances. I believe we can get rid of them without any
> actual disadvantages.

Oops. I misunderstand to have discussion about stuffs in 
'sound/core/oss/*', because the compatibility layer also includes abuses 
of set_fs() and I'm interested in it today...

For stuffs in 'sound/oss', we should certainly have care of points which 
Iwai-san mentioned. If we get rid of it, we can also apply diet to 
'soundcore' module which gives 'sound' class but include some helper 
functions just for Open Sound System drivers.


Regards

Takashi Sakamoto
