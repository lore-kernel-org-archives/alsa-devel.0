From: "Daniel Heckenberg" <daniel@bogusfront.org>
Subject: RE: PCMCIA and snd-hdsp
Date: Thu, 29 Aug 2002 13:57:48 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NEEMIOAOEHMNBAMDCGNGGELFCGAA.daniel@bogusfront.org>
References: <E17k1w9-0003RT-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17k1w9-0003RT-00@usw-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I have a somewhat working pcmcia hdsp configuration.
I would be very interested in removing the somewhat from the previous
statement... and can certainly provide any details from my configuration
that may be of assistance.

I'm using the planet ccrma packages, which means
2.4.19-1 kernel with low latency (and other) patches
alsa 0.9.0-36
on top of red hat 7.3

For some reason, the hotplug script can't successfully load the snd-hdsp
driver but a simple
"modprobe snd-hdsp" does work.  This is true at boot time (coldplug) and
upon insertion (hotplug).  Can anyone offer any insight into this?

I don't have the latest pcmcia-cs (I think I've got 3.1.22 but I'm not on
that machine at the moment) and don't appear to be having any segfault
trouble... however occasionally I do get unknown device errors when pcmcia
starts up and sometimes the card isn't registered at all.

daniel

> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Paul Davis
> Sent: Wednesday, 28 August 2002 10:30 PM
> To: Orm Finnendahl
> Cc: alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] PCMCIA and snd-hdsp
>
>
> >after recompiling a kernel on my laptop, my RME HDSP configuration is
> >broken. Does anybody have a working setup with the RME PCMCIA card and
> >would be willing to share some information about the process of
> >initialization off list?
>
> i don't have the working setup (with pcmcia), but i would obviously
> like to hear more about whatever has broken. do you still have the old
> kernel, and does it still work?
>
> --p
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by: Jabber - The world's fastest growing
> real-time communications platform! Don't just IM. Build it in!
> http://www.jabber.com/osdn/xim
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
