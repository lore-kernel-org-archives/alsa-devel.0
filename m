From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: spin_lock_irqwhat ?
Date: Mon, 10 May 2004 16:51:24 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040510165124.pochini@shiny.it>
References: <s5h3c68hbvc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3c68hbvc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>Alsa-devel <alsa-devel@lists.sourceforge.net>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


On 10-May-2004 Takashi Iwai wrote:

>> > Some drivers use spin_lock_irq() a lot, while others always use
>> > spin_lock_irqsave(). I can't see the difference. When it's safe
>> > using the _irq() version ?
>>
>> Only when you know that you are not in interrupt context.
>
> also, not in the context which already disabled irq.

Yes, I read the famous Rusty's unreliable guide. My question
was ALSA-specific. The point is that I don't know when those
conditions are true. Can and_pcm_period_elapsed() call anything
other than the pcm callbacks ?  Does the ALSA middle layer ever
disable interrupts before calling a driver function ?  If it
doesn't, I can replace spin_lock_irqsave() with spin_lock_irq()
almost everything. Some callbacks are atomic according to the
tutorial, but it doesn't say if interrupts are disabled too.
Are irq (and preempt) disabled before calling .prepare and
.trigger callbacks ?



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
