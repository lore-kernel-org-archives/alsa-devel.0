From: <danny@mailmij.org>
Subject: RE: snd-powermac produces only low quality dirty so
Date: Wed, 15 Dec 2004 19:32:19 +0100 (CET)
Message-ID: <Pine.LNX.4.33.0412151929380.14428-100000@luna.ellen.dexterslabs.com>
References: <XFMail.20041215111002.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.mailmij.org (a62-216-27-249.adsl.cistron.nl [62.216.27.249])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6F34124E
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2004 19:32:20 +0100 (MET)
In-Reply-To: <XFMail.20041215111002.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Olaf Hering <olh@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Dec 2004, Giuliano Pochini wrote:

> 
> On 14-Dec-2004 Olaf Hering wrote:
> 
> > All 2.6 versions I tried so far produce only "dirty" low quality sound
> > when playing mp3 with xmms with either the alsa or oss plugin.
> > But it works as expected when I use dmasound_pmac and the liboss plugin.
> >
> > Any ideas how to debug it?
> 
> It seems that the chip is not happy with some period/buffer sizes.
> Someone was trying to find the right constraints to set for those
> parameters. Maybe the attached patch fixes it (untested).
> 
O yes, I forgot to send it. Will do later tonight. It doesn't have to be a 
power of 2 though, at least not on my Snapper.
However, the problem never occured with oss emulation, so I doubt above 
problem is the same. Low quality sound was happening a few versions ago, 
but latest ALSA produces very reasonable sound, only distortion when 
I turn up PCM too much (and DRC Range is set high).

So:
-what version (libs+driver)
-what is "dirty" low quality?

d.

 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
