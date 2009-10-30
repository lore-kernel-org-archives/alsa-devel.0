From: Stas Sergeev <stsp@aknet.ru>
Subject: Re: [patch] snd-pcsp fixes
Date: Fri, 30 Oct 2009 17:23:09 +0300
Message-ID: <4AEAF6CD.7030706@aknet.ru>
References: <4ADF4827.8060608@aknet.ru>	<s5heiolyvyx.wl%tiwai@suse.de>	<4AEADA8F.8030408@aknet.ru>
	<s5hy6mtxe11.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BE9B243B8
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 15:23:23 +0100 (CET)
In-Reply-To: <s5hy6mtxe11.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>> But, I still don't understand why it has to be zero.  The first
>>> bit-flip is done inside the trigger-start, so the next wakeup should
>>> be after the calculated ns.  Isn't it?
>> That was the logic you invented, but
>> initially, and with my patch, there
>> is no bitflip on start trigger. Or,
>> at least, not supposed to be - there
>> was only a timer mode setup, or if not -
>> that was a bug. :)
> OK, then we should revert the zero-delay logic again.
> The zero-delay start means to do the bitflip again immediately.
> This is wrong, of course.
What do you mean? As I said above, there
seems to be no first bitflip on a start trigger,
neither initially, nor with my current patch.
There was only the timer _mode_ setup, the
GATE input of the timer was not supposed to
be touched. The logic you invented, OTOH,
does the first bitflip there, and then
advances the timer, which is also correct,
but is more complicated. Do you think there
was a bug that actually did the first
bitflip anyway?

> It's for speeding up.  We should minimize any calculations in the
> hrtimer callback.
Ok but snd_pcm_format_signed() and
snd_pcm_format_width() are really trivial
functions, so I just thought this is not
worth an efforts. But if you think this
have to be optimized, then fine.
