From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: Virtual multi channel devices
Date: Wed, 15 Sep 2004 10:41:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409151000430.30383@denise.shiny.it>
References: <XFMail.20040913094642.pochini@shiny.it>
 <Pine.LNX.4.58.0409131332250.11209@linux.iitis.gliwice.pl>
 <20040914195357.698f1ebb.pochini@shiny.it> <Pine.LNX.4.58.0409150957440.14383@linux.iitis.gliwice.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409150957440.14383@linux.iitis.gliwice.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Artur Rataj <arataj@iitis.gliwice.pl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Wed, 15 Sep 2004, Artur Rataj wrote:

> On Tue, 14 Sep 2004, Giuliano Pochini wrote:
>
> > This is required if the cards can't syncronize the sample clock and it makes
> > the thing much more complex and inaccurate.
>
> If synchronizing by interrupt times is inaccurate, then the cards
> should have not only clock sync, but also start/stop sync?

No, timestamps are accurate enough, but if the cards have indipendent
sample clock, they use a different sample rate. Thus they go out of sync
more and more over time and you need to resample one of the streams to
keep them syncronized. It's a complex and CPU-hungry process. Instead, if
the cards can sync the sample clock, you only have to correct the
different start time, which is simple. Just add some padding in front of
one of the substreams. My knowledge of the userspace API is very poor, but
I think all the above can already be done using the timer API. Have a look
at alsa-lib/test/latency.c .


> But such a start/stop sync would probably require some support from the
> driver?

Yes, of course. It's a hardware feature.


> Does ALSA support it? And if yes, which cards are supported?

It supports sync start/stop of substreams that belong to the same card,
but not among different cards AFAIK.
I don't know if some cards can do syncronous start/stop.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
