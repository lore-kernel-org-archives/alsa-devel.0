From: mark@undertone.org
Subject: Re: Extigy testing
Date: Mon, 25 Nov 2002 09:35:59 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021125143559.GA412@undertone.org>
References: <20021125133750.GA32741@undertone.org> <Pine.LNX.4.33.0211251449460.517-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211251449460.517-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nope, doesn't work. I attempted to try and dork around with gdb, but
apparently gdb abilities need quite a bit more dusting off.

-mark

On Mon, Nov 25, 2002 at 02:50:13PM +0100, Jaroslav Kysela wrote:
> On Mon, 25 Nov 2002, mark@undertone.org wrote:
> 
> > After having been pretty busy at work the past few weeks, this morning
> > I decided to give this testing another shot. Last time I had been able
> > to dicern or notice any change at all when most of the switches were
> > fliped... this time amixer/alsamixer simply seg faults. On console the
> > kernel just gives me a "divide error: 0000". If I attempt to tempt
> > fate a second time, the machine crashes with a polite hang and no
> > messages.
> 
> Could you try this patch?
> 
> --- usbmixer.c  24 Nov 2002 10:35:39 -0000      1.11
> +++ usbmixer.c  25 Nov 2002 13:50:23 -0000
> @@ -599,6 +599,8 @@
>                         if (get_ctl_value(cval, GET_RES, (cval->control << 8) | minchn, &cval->res) < 0)
>                                 cval->res = last_valid_res;
>                 }
> +               if (cval->res == 0)
> +                       cval->res = 1;
>                 cval->initialized = 1;
>         }
>         return 0;


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
