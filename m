From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] MPU-401 fixes
Date: Mon, 5 May 2003 12:32:28 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0305051224080.4749-100000@pnote.perex-int.cz>
References: <Pine.HPX.4.33n.0305050831420.4924-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0305050831420.4924-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 5 May 2003, Clemens Ladisch wrote:

> - fix deadlock: when snd_mpu401_uart_input_trigger() is interrupted
>   immediately after the call to spin_unlock_irqrestore(), the interrupt
>   handler won't clear the interrupt condition because the RX_LOOP bit is
>   still set

Thanks. The RX_LOOP bit is cleared before unlock now.

> - abort the tx loop when the FIFO is full; otherwise, the inner loop would
>   be executed 25600 times

Fixed.

> - clear the output trigger bit when output buffer is exhausted

Not possible. Only the trigger callback can do this thing.

I've added also TX_LOOP protection to the interrupt handler.

Please, could you verify my code? Thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
