From: Artur Rataj <arataj@iitis.gliwice.pl>
Subject: Re: Virtual multi channel devices
Date: Wed, 15 Sep 2004 09:59:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409150957440.14383@linux.iitis.gliwice.pl>
References: <XFMail.20040913094642.pochini@shiny.it>
 <Pine.LNX.4.58.0409131332250.11209@linux.iitis.gliwice.pl>
 <20040914195357.698f1ebb.pochini@shiny.it>
Reply-To: Artur Rataj <arataj@iitis.gliwice.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040914195357.698f1ebb.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On Tue, 14 Sep 2004, Giuliano Pochini wrote:

> This is required if the cards can't syncronize the sample clock and it makes
> the thing much more complex and inaccurate.
>

If synchronizing by interrupt times is inaccurate, then the cards
should have not only clock sync, but also start/stop sync? But such a
start/stop sync would probably require some support from the driver?
Does ALSA support it? And if yes, which cards are supported?

Best regards,
Artur


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
