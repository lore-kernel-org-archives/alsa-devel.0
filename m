From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: New PCM API extension
Date: Mon, 24 Feb 2003 00:15:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E59562F.62929578@libero.it>
References: <Pine.LNX.4.44.0302232154250.1263-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp1.cp.tin.it (vsmtp1.tin.it [212.216.176.221])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id AAA11516
	for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2003 00:16:21 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> I think that I have one present problem. It was not possible to write,
> something like the dmix plugin does (in the server/client model): Transfer
> data to different areas in the ring buffer. Imagine that client1 wants to
> write data at the end of the ring buffer (assume that server don't change
> the r/w pointer). Then client2 comes with some data to be placed at the
> start of the buffer later (server rewinds the stream position). Then
> hardware processed a period and client1 wants to continue (server forwards
> the stream position at the end of the ring buffer).
> 
> I can imagine more examples where "later" samples might be wanted to be
> processed before "quick" ones.

Your examples appears a little confused at my eyes, but if I've
understood correctly don't you think this might be solved by
snd_pcm_rewind done by server?

At least this is how it works in pcm_share.

> > > I'm also going to propose next extension: Actually, the appl_ptr managing
> > > routines - snd_pcm_reset(), snd_pcm_rewind(), snd_pcm_forward() always
> > > uses an ioctl for it's operation. I think that it wouldn't be a bad idea
> > > to implement these function in the lightweight variant, too. I mean that
> > > they will operate only with the actual hw_ptr without calling the kernel
> > > code. We have already functions to synchronize the hw_ptr with the
> > > hardware (snd_pcm_delay(), snd_pcm_hwsync()). Because it's late to change
> > > this behaviour in alsa-lib, I propose to create a function
> > > 'snd_pcm_fast_rw_change()' (better name?) which tells the alsa-lib that no
> > > accurate operation is required. Especially lowlatency applications will
> > > benefit that we removed more 'user<->kernel' switches.
> >
> > Note that the assumption of monotonic direction of appl_ptr is spread
> > everywhere so I doubt that this is feasible for snd_pcm_rewind.
> 
> I don't understand here. I've looked to the ioctl implementation and there
> are no problems to change appl_ptr in the user space only as well.

Have you thought what happens if appl_ptr is changed backward during
interrupt handler?

Lock free ring buffer absolute precondition is monotonic direction.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
