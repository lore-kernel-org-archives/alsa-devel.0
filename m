From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Migration from 0.5 to 0.9?
Date: Fri, 05 Apr 2002 03:00:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CAD0534.5050102@superbug.demon.co.uk>
References: <1017927701.1777.12.camel@lel1.sthlm.i3micro.se>
Reply-To: James@superbug.demon.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from finch-post-12.mail.demon.net (finch-post-12.mail.demon.net [194.217.242.41])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA27469
	for <alsa-devel@alsa-project.org>; Fri, 5 Apr 2002 04:01:15 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Leif Lindholm <leif.lindholm@i3micro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Leif Lindholm wrote:

>Hello
>
>I'm working on a set-top-box based on the National Semiconductor SC1200
>Geode integrated microprocessor.
>
>National have been nice enough to write an Alsa-driver for the built-in
>AC97-controller/audio thingy - unfortunetaly it is written for 0.5.10b.
>
>So now I need to modify this one to use with 0.9.
>
>Can someone give me a few tips/hints or is there possibly a document
>about this that I failed to google up?
>
>regards
>	/
>		Leif
>
>
>
>
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
I would post the source code of your current driver somewhere (URL).
If the set top box uses the AC97-Controller, alsa09 might already have a 
sound driver for it, but someone might need to add an extra bit of card 
recognition code to get it to work.
Also, if you can post to a URL any documents about the set-top-box, 
which would make it easier for people to help you. We might be able to 
recognise which of the current drivers is closest to it from that.
It would probably be better to get support for the set top box into the 
publically available version of alsa09, so that it will be kept up to 
date with any other changes which might happen in alsa without you 
having to worry about it.

Cheers
James
