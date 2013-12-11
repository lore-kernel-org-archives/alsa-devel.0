From: Monty Montgomery <xiphmont@gmail.com>
Subject: Re: emi62 (may be slightly off-topic)
Date: Tue, 10 Dec 2013 19:04:22 -0500
Message-ID: <CACrD=+9r4LAiYYsQUSRSm5K=gFpkTp5Z3agfa--msGpF9FKWOg@mail.gmail.com>
References: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
 <4D821A18.30407@ladisch.de>
 <AANLkTi=0SKc+2vUH=DV+c1Vm5NwoeAcHMac=tdyi4E8w@mail.gmail.com>
 <4D894196.4040002@gmail.com>
 <1360657074.2790.71.camel@chello084112006029.chello.at>
 <s5hboblr611.wl%tiwai@suse.de>
 <CACrD=+8-kHTX0AVW5KLHG73mDp4+eccz4LqanpOzNGeCRZ+hRA@mail.gmail.com>
 <CACrD=+9P6Gj51HMRb-rdZeoQ7yjzpu2J=pkq9eNj-ZH8HGAe+A@mail.gmail.com>
 <s5hmwv5imqy.wl%tiwai@suse.de>
 <CACrD=+-aXYKoLdrMw+xOzqhyY9mdpDzLfMTB-06CHYiBqEQOxw@mail.gmail.com>
 <s5hfw0xilwk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f176.google.com (mail-ve0-f176.google.com
 [209.85.128.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 36ECC265347
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 01:04:23 +0100 (CET)
Received: by mail-ve0-f176.google.com with SMTP id oz11so5441680veb.35
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 16:04:22 -0800 (PST)
In-Reply-To: <s5hfw0xilwk.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Karl Grill <kgrill@chello.at>
List-Id: alsa-devel@alsa-project.org

Karl just reminded me that I never sent a link to my up-to-date out of
tree eMagic driver update.  Here's the latest version:

http://people.xiph.org/~xiphmont/emagic/emi-20131209.tgz

This includes the latest/correct firmware for the 2|6 and 6|2m (not
the same as shipped in the kernel).  It builds a single emi.ko that
functions as a loader for both devices.
There's the usual make and make install target, as well as a
'remove-old' target that kills off the old installed firmware and
emi26/62 modules.

The Makefile is a bit slapdash, hopefully it doesn't misbehave.

I've mentioned it before, but the current in-kernel loader (and
official firmware) are both outright broken. I'm happy enough to
maintain this out of kernel (since there were objections to updating
the firmware), but the in-tree / mainline stuff should be either
updated or removed.  It simply doesn't work.

Monty

On Fri, Feb 15, 2013 at 11:26 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 15 Feb 2013 11:14:46 -0500,
> Monty Montgomery wrote:
>>
>> > Do you still have the patch for async load?
>>
>> Oh yes.  I should check it against 3.7
>>
>> And for the record, it's a complete new loader, one module for both
>> eMagic boxes,  so the patch consists of removing several files and
>> adding new ones.
>
> This makes more sense, indeed.
>
>> > The fix patch on the blog
>> > entry isn't that.
>>
>> Correct. There were other [minor] problems in the old loader, but
>> without fixing the deadlock, it's all sort of moot.  Also, the 6|2
>> loader is currently trying to use firmware for some other device--
>> it's not 6|2 firmware.  if you do succeed in loading what's currently
>> shipping, the device simply crashes.
>>
>> So, I came to the conclusion a few years ago i was the last person
>> using eMagic boxes (though people since then have sent me mail for the
>> driver, so I know that's not quite true).
>
> Or people just had used the old kernel :)
>
>
> Takashi
