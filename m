From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Support for Midiman M-Audio Delta 410
Date: Thu, 31 Oct 2002 20:18:10 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210312016570.5341-100000@pnote.perex-int.cz>
References: <1036086910.3dc16e7e09de9@albert.homedns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1036086910.3dc16e7e09de9@albert.homedns.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kristof Pelckmans <Kristof.Pelckmans@antwerpen.be>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, "ajh@watri.uwa.edu.au" <ajh@watri.uwa.edu.au>
List-Id: alsa-devel@alsa-project.org

On Thu, 31 Oct 2002, Kristof Pelckmans wrote:

> > On Thu, 31 Oct 2002, Takashi Iwai wrote:
> > Kristof, could you give us info to which GPIO pins of ICE1712 is the 
> > AK4529 chip connected?
> 
> Jaroslav,
> 
> Unfortunately I do not have the right equipment for measuring which GPIOs are 
> used and what they are connected to. I assume there can't be that many used in 
> comparison with the 1010LT. Probably very similar to the Audiophile's GPIOs...
> 
> Could I try it the old-fashioned way : simple try-and-error starting from the 
> Audiophile configuration ?

Yes, you can. Simply, try to modify the alsa-kernel/ice1712/delta.c code. 
Perhaps, Takashi might commit the AK4529 support to have more fun...

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
