From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] MPU-401 fixes
Date: Mon, 05 May 2003 13:19:34 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0305051303360.18233-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.44.0305051224080.4749-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.44.0305051224080.4749-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Mon, 5 May 2003, Clemens Ladisch wrote:
>
> > - fix deadlock: when snd_mpu401_uart_input_trigger() is interrupted
> >   immediately after the call to spin_unlock_irqrestore(), the interrupt
> >   handler won't clear the interrupt condition because the RX_LOOP bit is
> >   still set
>
> Thanks. The RX_LOOP bit is cleared before unlock now.

The same thing will happen when the interrupt occurs immediately before
the call to spin_lock_irqsave().

The real problem is that the interrupt handler _must_ read the data from
the device to clear the MPU401's interrupt condition. Therefore, there
must not be any condition which can prevent the handler from reading data.

> > - abort the tx loop when the FIFO is full; otherwise, the inner loop would
> >   be executed 25600 times
>
> Fixed.

Without the "if (timeout == 0)" test, the loop will be aborted after the
first byte written.


BTW: Where did my patches from Friday go?


Regards,
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
