From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 2/3] sound: dummy, use del_timer_sync
Date: Mon, 19 Jan 2015 10:59:14 +0100
Message-ID: <54BCD572.7060203@suse.cz>
References: <1421660576-8435-1-git-send-email-jslaby@suse.cz>	<1421660576-8435-2-git-send-email-jslaby@suse.cz> <s5hvbk3qeq9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hvbk3qeq9.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/19/2015, 10:52 AM, Takashi Iwai wrote:
> At Mon, 19 Jan 2015 10:42:55 +0100,
> Jiri Slaby wrote:
>>
>> Wait for the timer to really quit, not only by ensuring it is not in
>> the critical section.
>>
>> BTW the spin_lock in here does not disable BH, so that it could
>> deadlock.
> 
> The stop function is called from the PCM trigger callback which is
> irq-disabled.  So, you can't use del_timer_sync() here.

The same as 3/3 I was looking at compr* :(. Ignore this one, then.

thanks,
-- 
js
suse labs
