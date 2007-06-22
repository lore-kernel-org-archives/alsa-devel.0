From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: at91 SoC Modifications
Date: Fri, 22 Jun 2007 12:49:25 -0400
Message-ID: <467BFD95.3080707@endrelia.com>
References: <61c0054e0706201421x3725f809g80822d32d78d216e@mail.gmail.com>	
	<61c0054e0706210747gc83f1dx2a6ee8bc5cf346f9@mail.gmail.com>
	<61c0054e0706220853x5502066ck8765365df9b3abf0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tomts47-srv.bellnexxia.net (tomts47.bellnexxia.net
	[209.226.175.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 7835A24528
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jun 2007 18:49:32 +0200 (CEST)
Received: from toip35-bus.srvr.bell.ca ([67.69.240.36])
	by tomts47-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070622164925.KUUT13220.tomts47-srv.bellnexxia.net@toip35-bus.srvr.bell.ca>
	for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2007 12:49:25 -0400
In-Reply-To: <61c0054e0706220853x5502066ck8765365df9b3abf0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Kavan <pkavan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Kavan wrote:
> I just don't think it is a hardware problem. I a polling ssc driver that
> works very nicely for this codec. However, it is polling and I do not
> want to rely on it when I have more of a load on the processor.
> 
> I have the machine/codec code and at91-ssc.c configured so that the
> registers and gpio should be set up identical to what I had before and
> it is not generating a proper sync signal with arecord. When I do strace
> on arecord it hangs at this first line before finishing.
> 
> 
> ioctl(4, 0x800c4151, 0xbed9cc34)        = -1 EIO (Input/output error)
> write(2, "arecord", 7arecord)                  = 7
> write(2, ": ", 2: )                       = 2
> write(2, "pcm_read", 8pcm_read)                 = 8
> write(2, ":", 1:)                        = 1
> write(2, "1346", 41346)                     = 4
> write(2, ": ", 2: )                       = 2
> write(2, "read error: ", 12read error: )            = 12
> write(2, "Input/output error", 18Input/output error)      = 18
> write(2, "\n", 1
> )                       = 1
> exit(1)                                 = ?
> 
> 
> Does anyone know what this line is doing? I think it might give a clue.
> The sync line still ripples at about .3V peak to peak with f=256k (Bit
> Clock Rate).

Sorry, I have no idea what that line is doing.

> Frank: I modified the machine code so that RF0 and RK0 are set in the
> gpio. The only differences are that the sync line no longer tri-states
> after going trying to record and instead of seeing the ripple around 3V
> it is now around 200 mV.

Now that I think about, if you are using RK0 as an input and driving it
from TK0, then you should be initializing the RK0 GPIO.  On our board,
the RK2 GPIO pin is not used since RK2 is generated internally from the
TK2 clock signal (AT91_SSC_CKS_CLOCK), so there was no need to
initialize it.

Also, the RF2 GPIO is not used on our board, because there is a single
sync signal sent to the codec, and this is supplied by TF2.

Perhaps it would be useful to see a diagram of the connections between
the SSC and codec on your board, including directions.

../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
