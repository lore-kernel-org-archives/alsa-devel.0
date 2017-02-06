From: =?UTF-8?Q?Andrej_Krut=C3=A1k?= <dev@andree.sk>
Subject: Re: Fwd: Regression: Line6 Toneport stops working on
	4.10-rc5
Date: Mon, 6 Feb 2017 12:04:29 +0100
Message-ID: <CAFnc+wX6cNcsDp9Mmx2PrxBVj3+rjdtHgFtV4-qGvUVxqFMPjQ@mail.gmail.com>
References: <CAH7_RC8_i0id7YRqzW37qtq3B7BrWfwDU-fXmBADBx0Mej7vsw@mail.gmail.com>
 <CAH7_RC8NA5KJ=eB63fxXnUwk7kkgJAT=p6K29EncrYcgE-utTg@mail.gmail.com>
 <20170126074724.GA9837@kroah.com>
 <CAH7_RC9RmhF0eBf7phh_2NROL65_Rw=8Jd2Wf9TsURhkASOuMw@mail.gmail.com>
 <20170126093002.GA787@kroah.com>
 <CAH7_RC8Ma6c+VHvQ8i0BHDmA_B5qdrPXNQkBAy2Z0MbCHumrnQ@mail.gmail.com>
 <20170127165429.GA19745@kroah.com>
 <CAH7_RC-Lvjyr8o8By27enPNzumigSRFbHEiLp4v+Qmg5if73Xg@mail.gmail.com>
 <20170206101844.GA10982@kroah.com> <s5h37fr7fco.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb0-f196.google.com (mail-yb0-f196.google.com
 [209.85.213.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BD8E2667FE
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2017 12:04:50 +0100 (CET)
Received: by mail-yb0-f196.google.com with SMTP id j82so3355595ybg.2
 for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2017 03:04:50 -0800 (PST)
In-Reply-To: <s5h37fr7fco.wl-tiwai@suse.de>
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
Cc: Greg KH <gregkh@linuxfoundation.org>, Igor Zinovev <zinigor@gmail.com>, linux-usb@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 6, 2017 at 12:01 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 06 Feb 2017 11:18:44 +0100,
> Greg KH wrote:
>>
>> On Mon, Feb 06, 2017 at 01:01:56PM +0300, Igor Zinovev wrote:
>> > Hello again!
>> >
>> > Thanks for the advice, but bisecting the whole tree took me quite a
>> > while and I ended up stuck because booting on some bisect states has
>> > led my system to run without some devices, like wireless and sound. So
>> > I tried to bisect the sound/usb/line6 path. It turns out that this
>> > commit is the point where it breaks for me:
>> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/sound/usb/line6?id=f6a0dd107ad0c8b59d1c9735eea4b8cb9f460949
>> >
>> > In fact, when I apply the reverse patch on top of 4.10-rc7, it fixes
>> > the problem for me.
>>
>> Wonderful, thanks so much for tracking this down!
>>
>> > Should I bring some of the people that are mentioned in the commit
>> > into this conversation?
>>
>> I've done so now.  Andrej and Takashi, the above patch causes a
>> regression for Igor, any thoughts?  Should we just revert it?
>
> Yeah, the patch looks wrong, the function line6_get_interval() should
> be called unconditionally.
>
> I'm going to queue a revert for 4.10-final.
>

Yep, on the first look it's suspicious. I'll have a look on it in the
evening - not sure simple revert is the ideal solution... I'll get
back to you.

PS: Thanks for the bisecting, Igor!
PPS: Maybe this should go also to 4.9 stable, once resolved...


-- 
Greetings,

Andrej
