From: "Daniel Heckenberg" <daniel@bogusfront.org>
Subject: RE: PCMCIA and snd-hdsp
Date: Fri, 30 Aug 2002 09:49:12 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NEEMIOAOEHMNBAMDCGNGCELNCGAA.daniel@bogusfront.org>
References: <E17kUso-00011B-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17kUso-00011B-00@usw-sf-list1.sourceforge.net>
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


> >For some reason, the hotplug script can't successfully load the snd-hdsp
> >driver but a simple
> >"modprobe snd-hdsp" does work.  This is true at boot time (coldplug) and
> >upon insertion (hotplug).  Can anyone offer any insight into this?
>
> i know nothing about the hotplug script of pcmcia-cs, but i bet its
> because it doesn't use the dependency tree that depmod builds. you
> would have the same problem with insmod(8) for example. modprobe
> doesn't just load the named module, it loads all the required modules
> as well.

No, the script does appear to do a modprobe.  I've checked the scripts
themselves and watched their behaviour.  The appropriate required modules
are loaded (including snd-hammerfall-mem if required).  All of those modules
load correctly.  However, the snd-hdsp module complains that it can't find
the module (not that there are unresolved symbols).  Then all of the other
loaded modules are unloaded (including snd-hammerfall-mem).

I'm not very experienced with shell scripts so it will take me quite a while
to scour through and look at the process in more detail...

Does anyone have their hdsp hotplugging successfully?

Also, I can't get alsactl to restore mixer settings correctly.  I can see
that they've been written correctly in the asound.state file but they don't
seem to be restored properly.  What am I doing wrong?

many thanks,
daniel



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
