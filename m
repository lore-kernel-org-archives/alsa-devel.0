From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Virtual multi channel devices
Date: Tue, 14 Sep 2004 19:53:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040914195357.698f1ebb.pochini@shiny.it>
References: <XFMail.20040913094642.pochini@shiny.it>
	<Pine.LNX.4.58.0409131332250.11209@linux.iitis.gliwice.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409131332250.11209@linux.iitis.gliwice.pl>
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

On Mon, 13 Sep 2004 13:39:11 +0200 (CEST)
Artur Rataj <arataj@iitis.gliwice.pl> wrote:

> > In theory, yes it is. But the times between read/writing to the
> > buffers are not accurate. IMO the times between interrupts are
> > better, expecially if the two cards are using the same period
> > size. Maybe ALSA-kernel already exports the required timestamps.
>
> Is something like that planned in ALSA?

I don't know.


> Like dropping samples or adding interpolated samples to slow/fast cards?

This is required if the cards can't syncronize the sample clock and it makes
the thing much more complex and inaccurate.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
