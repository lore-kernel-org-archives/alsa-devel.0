From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: Lowest latency: JACK, or ALSA directly?
Date: Fri, 12 Nov 2004 16:28:12 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411121619090.30201@denise.shiny.it>
References: <200411111534.iABFY8UK012314@localhost.localdomain>
 <200411121547.05145.gilles.degottex@net2000.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411121547.05145.gilles.degottex@net2000.ch>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gilles Degottex <gilles.degottex@net2000.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Fri, 12 Nov 2004, Gilles Degottex wrote:

> On Thursday 11 November 2004 16:34, Paul Davis wrote:
> > it doesn't *add* any latency at all. what it might conceivably do is
> > to prevent a given application from reaching the lowest possible
> > latency, because of the extra context switching involved in JACK. so
> > far, however, this doesn't appear to be the case - people have JACK
> > running at the same latency settings as they could get with ALSA. so
> > the effect is marginal if its measurable at all.
>
> no latency ?? so why qjackctl show latency information ? (around 50ms for me)

No, reread the sentence above: "it doesn't *add* any latency at all".
Since the latency is the length of the buffer, as long as the overhead
introduced by Jack is "small", it doesn't add latency. By "small" i mean
that is does not cause underruns, which depends on the buffer size. For
example if your system can handle buffers down to 1ms long, with Jack that
time is longer is eg. 2ms. But there is not difference in latency using a
2ms long buffer with Jack and the same with alsa-lib, because it's always
2ms.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
