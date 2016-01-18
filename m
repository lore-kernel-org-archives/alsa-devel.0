From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: ALSA: bebob: Could I still put some patches to
	4.5-rc1?
Date: Mon, 18 Jan 2016 21:36:33 +0900
Message-ID: <569CDC51.4050103@sakamocchi.jp>
References: <569C4D3B.4030500@sakamocchi.jp> <s5hbn8js8kw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D1B6260506
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 13:36:36 +0100 (CET)
In-Reply-To: <s5hbn8js8kw.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jan 18 2016 15:30, Takashi Iwai wrote:
> On Mon, 18 Jan 2016 03:26:03 +0100,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> Currently I got a help to add support of a new model into ALSA BeBoB driver.
>> http://sourceforge.net/p/ffado/mailman/ffado-devel/thread/CAKKsO5CYHVRvgo6AV%3D%3DZRJ2it53cF7UGHnnDyCLZY_jzJYHpSA%40mail.gmail.com/#msg34751986
>>
>> I've already created the patch candidate and users test them.
>> https://github.com/takaswie/snd-firewire-improve/tree/soundcraft
>>
>> If the test finished in a few days, could I put them to 4.5-rc1 or not
>> in time?
>
> In general, the development phase is already over when a merge window
> is opened.  That means, only fix patches should be merged after that.
> As a rule of thumb, I'd take patches to stable kernels at any time,
> but the rest depends on urgency (or it has been already submitted /
> reviewed but I forgot to merge, etc).

Thanks for the clear instruction about your maintenance policy. I mostly 
agree with the policy, so stopped posting my patches during merge window 
opening (at least in recent releases).

While, the patches allow users to handle their unit. I think it valuable 
to add the patches in this merge window and increase supported devices 
in ALSA, as long as the changes is quite small (i.e. just adding device 
entry).

Today, a tester reports that snd-bebob cannot drive his unit just with 
the patches. As a result of additional investigation, I conclude that 
there may be quirks on the sequence of packets from the unit. This means 
that the changes may become larger, unfortunately.

I give up to request adding the patches into Linux 4.5, and postpone it 
to next merge window.


Thanks

Takashi Sakamoto
