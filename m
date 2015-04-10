From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/2] ALSA: ctl: refactoring for read
	operation
Date: Fri, 10 Apr 2015 19:52:47 +0900
Message-ID: <5527AB7F.4010702@sakamocchi.jp>
References: <1428512108-1852-1-git-send-email-o-takashi@sakamocchi.jp>
 <1428622981-9747-1-git-send-email-o-takashi@sakamocchi.jp>
 <1428622981-9747-3-git-send-email-o-takashi@sakamocchi.jp>
 <s5h61945spk.wl-tiwai@suse.de> <5527A6DA.50800@sakamocchi.jp>
 <s5h7ftkl0v4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id A136D265DAA
 for <alsa-devel@alsa-project.org>; Fri, 10 Apr 2015 12:52:51 +0200 (CEST)
In-Reply-To: <s5h7ftkl0v4.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Apr 10 2015 19:43, Takashi Iwai wrote:
>> I'm unaware of it... These code should be:
>>
>> if (copy_to_user(buffer, &ev, sizeof(struct snd_ctl_event))) {
>>     if (result == 0)
>>         result = -EFAULT;
>>     break;
> 
> Well, it's not much better than the original code, IMO.

OK. I dropped this patch.

>> And I realize sound/firewire/fireworks/fireworks_hwdep.c has the same
>> bug. I'll post another patch for this bug.
> 
> This is an implementation detail and I believe it rather depends on
> each driver.  (But I should reread POSIX definition again before
> concluding it.)
> 
> That said, it isn't wrong to return -EFAULT immediately, per se.
> The problem here is that you change the existing behavior.  Especially
> a core code like this should be treated carefully even for such a
> small behavior change.

Thanks

Takashi Sakamoto
