From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: memory leak in mmap ops
Date: Thu, 4 Aug 2011 15:09:29 +0800
Message-ID: <CAHG8p1A86TGZSH75xTQbV9Q=Zg4oAmm4c==wsRrOycffQL+kNw@mail.gmail.com>
References: <CAHG8p1CQHHi=G6mevNdxDU5h_4NW4tZ+nSO1hnC5K2JX2nT+aw@mail.gmail.com>
	<s5h39hktky1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5ABE12440D
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 09:09:33 +0200 (CEST)
Received: by qwf7 with SMTP id 7so927607qwf.38
	for <alsa-devel@alsa-project.org>; Thu, 04 Aug 2011 00:09:29 -0700 (PDT)
In-Reply-To: <s5h39hktky1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thanks for your replay.

2011/8/2 Takashi Iwai <tiwai@suse.de>:
> At Sat, 30 Jul 2011 11:15:41 +0800,
> Scott Jiang wrote:
>>
>> Hi all,
>>
>> I found there is a memory leak about 128K every time in linux-2.6.34,
>> but it doesn't exist in linux-3.0.
>
> What does "every time" mean, and how did you detect it?

That means using aplay command every time.
Actually the customer told us if you didn't close the handle(in your
app), there was no memory leak.
If you didn't write data, only opened and closed the handle, there was
no memory leak.

>
>> If I use mmap ops in driver the bug will come out, while use copy ops
>> no memory leak. This driver is based on asoc.
>> I tested with aplay to play a wav file.
>> Because there is a lot of changes in ALSA between 2.6.34 and 3.0, so
>> can anyone who familiar with the change history tell me which patch
>> has solved this bug?
>
> I don't remember such a bug fix, so wonder whether it's the ALSA core
> part or a driver-specific issue. =A0You can try other driver (e.g.
> snd-dummy) to see whether the problem happens.
>

My driver based on asoc, I am not sure it is caused by asoc or alsa core.
I have tried to search the change log to find something but nobody
mentioned this just as your reply.
I tested these drivers on blackfin bf537 and I am sure I didn't modify
audio driver and the bug disappears with the alsa update.
Then I modified drivers using mmap ops to copy ops, they works fine,
no memory leak. But dmix plug can't be used.
One more thing, 128K is a big buffer and audio device driver only
allocate dma at such size. But dma size can't be seen by free command
on blackfin. So I think the framework allocate the buffer using
kmalloc or get_free_pages but forget to release. If codec only has one
channel such as ad73311, the memory leak size is 64K.

Scott
