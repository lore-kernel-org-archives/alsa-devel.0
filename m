From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: atomicity in linked streams
Date: Mon, 21 Jul 2003 19:19:17 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030721191918.18068.h006.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Hi,
> 
> so far, some pcm operator callbacks are assumed to be atomic.
> but looking at the code, this restriction seems coming only from the
> rwlock of linked streams.
> 
> there are some hardwares which need (idally) the non-atomic operations
> for prepare and trigger.  they usually require the ack as the command
> completion.  and we implemented it in the busy loop or by ignoring the
> ack.

Can you point me to an example...

I would be very glad if operators were non-atomic (I could handle .pointer being
atomic).  
I have had to replace a semaphore with a spinlock around my card access code
because there are a few paths that come from atomic context.
Maybe it is a big picture design flaw...
 
> i think the stream-link lock can be replaced with rw_semaphore, so
> that prepare and trigger callbacks can be non-atomic.  the only
> critical part is, as far as i see, that  snd_pcm_stop() may be called
> from interrupt handler when  xrun/suspend happens.  this cannot handle
> the semaphore, of course.
> 
> i have still no concrete idea how to solve this...  any suggestions?

Is it possible that semaphores can be used in atomic context if down_trylock()
is used in a loop?  Really what is not allowed is for process to try to sleep
when in atomic context.

Now I think about it it would cause a deadlock.  How about have the interrupt
flag the need to stop after the competing process relinquished the semaphore?

This doesn't seem worse that having the spinlock, which effectively disables the
interrupt altogether until the competing process has finished.
 
> btw, if the trigger can take too long time, we should implement this
> into two seprate parts: the trigger and the post-trigger.  the trigger
> would be issued and return immediately, and the post-trigger would
> take care of the completion of commands.

- Eliot

Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
