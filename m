From: Olaf Hering <olh@suse.de>
Subject: Re: snd-powermac produces only low quality dirty so
Date: Wed, 15 Dec 2004 19:05:07 +0100
Message-ID: <20041215180507.GA2772@suse.de>
References: <20041214213549.GA22308@suse.de> <XFMail.20041215111002.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from Cantor.suse.de (cantor.suse.de [195.135.220.2])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AE1AD23D
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2004 19:05:12 +0100 (MET)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 On Wed, Dec 15, Giuliano Pochini wrote:

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

This patch does not help.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
