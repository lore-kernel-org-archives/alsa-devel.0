From: Dmitry Baikov <dsbaikov@gmail.com>
Subject: Re: RME HDSP rev 37 does not work on 64-bit linux
Date: Sun, 8 Feb 2009 01:11:16 +0300
Message-ID: <70a871c80902071411qec480baq8fd9223767d1562d@mail.gmail.com>
References: <70a871c80902010708s2a10ff8bobe79622949da62fe@mail.gmail.com>
	<200902011616.49454.faber@faberman.de>
	<70a871c80902010846i1059ab26t63c1d7e530126caf@mail.gmail.com>
	<200902020935.35530.faber@faberman.de>
	<70a871c80902030358x469723c4t9eb4af574370d289@mail.gmail.com>
	<s5hhc396xlx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f19.google.com (mail-fx0-f19.google.com
	[209.85.220.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 196E61037ED
	for <alsa-devel@alsa-project.org>; Sat,  7 Feb 2009 23:11:18 +0100 (CET)
Received: by fxm12 with SMTP id 12so1875908fxm.8
	for <alsa-devel@alsa-project.org>; Sat, 07 Feb 2009 14:11:17 -0800 (PST)
In-Reply-To: <s5hhc396xlx.wl%tiwai@suse.de>
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
Cc: Florian Faber <faber@faberman.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 5, 2009 at 12:28 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue, 3 Feb 2009 14:58:41 +0300,
> Dmitry Baikov wrote:
>>
>> On Mon, Feb 2, 2009 at 11:35 AM, Florian Faber <faber@faberman.de> wrote:
>> > Dmitry,
>> >
>> >> I just revived my 64-bit Gentoo partition, and vanilla 2.6.28.2 says
>> >> No Multiface or Digiface found, disabling the card.
>> >
>> > Ok, you are using a notebook. I have seen problems with notebooks when the
>> > period between powering up the cardbus socket and trying to access the card
>> > wasn't long enough, the interface card isn't initialized fast enough.
>> Actually, this is desktop with pci-pcmcia adapter card.
>> I just tried it in my laptop with 64-bit Ubuntu 8.10 and everything
>> works perfectly.
>>
>> > Please try the following: Go to line 5059 in /sound/pci/rme9652/hdsp.c and
>> > change the line
>> >        ssleep(2);
>> > to
>> >        ssleep(5);
>> >
>> > Compile it and try again.
>>
>> It waits for 5 seconds according to dmesg, but the result is the same:
>> card disabled.
>>
>> The summary of my experiments so far:
>> everywhere Ubuntu is 8.10, kernel 2.6.27-11
>>
>> laptop + cardbus + 64-bit ubuntu: WORKS
>>
>> desktop + pci-pcmcia adapter:
>> ubuntu 32: WORKS
>> ubuntu 64: can't upload firmware
>> gentoo 64 + vanilla kernel 2.6.28.2: can't recognize external box,
>> disables the card.
>
> Increasing HDSP_SHORT_WAIT doesn't help, too?

No, I tried several values up to 300 (from original 30), result is the same:
No Digiface or Multiface connected.

This is weird.


Dmitry.
