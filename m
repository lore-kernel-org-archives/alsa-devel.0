From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Virtual multi channel devices
Date: Wed, 15 Sep 2004 07:54:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409151154.i8FBsmB5009257@localhost.localdomain>
References: <Pine.LNX.4.58.0409151000430.30383@denise.shiny.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 15 Sep 2004 10:41:59 +0200."
             <Pine.LNX.4.58.0409151000430.30383@denise.shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: Artur Rataj <arataj@iitis.gliwice.pl>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> But such a start/stop sync would probably require some support from the
>> driver?
>
>Yes, of course. It's a hardware feature.
>
>
>> Does ALSA support it? And if yes, which cards are supported?
>
>It supports sync start/stop of substreams that belong to the same card,
>but not among different cards AFAIK.
>I don't know if some cards can do syncronous start/stop.

the best evidence i have seen so far of what snd_pcm_link()
... snd_pcm_start() can do suggests that both cards will start up
within 1 sample of each other at 48kHz. unfortunately, this is from a
single data point, and there is a real need for someone to do more
rigorous testing of how well a synced start works in general.

--p


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
