From: Olaf Hering <olh@suse.de>
Subject: Re: snd-powermac produces only low quality dirty so
Date: Wed, 15 Dec 2004 19:56:28 +0100
Message-ID: <20041215185628.GA3556@suse.de>
References: <XFMail.20041215111002.pochini@shiny.it> <Pine.LNX.4.33.0412151929380.14428-100000@luna.ellen.dexterslabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from Cantor.suse.de (news.suse.de [195.135.220.2])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8791824F
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2004 19:56:29 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0412151929380.14428-100000@luna.ellen.dexterslabs.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: danny@mailmij.org
Cc: Giuliano Pochini <pochini@shiny.it>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 On Wed, Dec 15, danny@mailmij.org wrote:

> On Wed, 15 Dec 2004, Giuliano Pochini wrote:
> 
> > 
> > On 14-Dec-2004 Olaf Hering wrote:
> > 
> > > All 2.6 versions I tried so far produce only "dirty" low quality sound
> > > when playing mp3 with xmms with either the alsa or oss plugin.
> > > But it works as expected when I use dmasound_pmac and the liboss plugin.
> > >
> > > Any ideas how to debug it?
> > 
> > It seems that the chip is not happy with some period/buffer sizes.
> > Someone was trying to find the right constraints to set for those
> > parameters. Maybe the attached patch fixes it (untested).
> > 
> O yes, I forgot to send it. Will do later tonight. It doesn't have to be a 
> power of 2 though, at least not on my Snapper.
> However, the problem never occured with oss emulation, so I doubt above 
> problem is the same. Low quality sound was happening a few versions ago, 
> but latest ALSA produces very reasonable sound, only distortion when 
> I turn up PCM too much (and DRC Range is set high).

You are right, reducing the volume to 80% in xmms fixes it and the mp3
sounds ok.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
