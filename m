From: Paul Davis <pbd@op.net>
Subject: Re: PCMCIA and snd-hdsp
Date: Thu, 29 Aug 2002 15:23:47 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17kUso-00011B-00@usw-sf-list1.sourceforge.net>
References: <NEEMIOAOEHMNBAMDCGNGGELFCGAA.daniel@bogusfront.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 29 Aug 2002 13:57:48 +1000."
             <NEEMIOAOEHMNBAMDCGNGGELFCGAA.daniel@bogusfront.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Daniel Heckenberg <daniel@bogusfront.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>For some reason, the hotplug script can't successfully load the snd-hdsp
>driver but a simple
>"modprobe snd-hdsp" does work.  This is true at boot time (coldplug) and
>upon insertion (hotplug).  Can anyone offer any insight into this?

i know nothing about the hotplug script of pcmcia-cs, but i bet its
because it doesn't use the dependency tree that depmod builds. you
would have the same problem with insmod(8) for example. modprobe
doesn't just load the named module, it loads all the required modules
as well. 

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
