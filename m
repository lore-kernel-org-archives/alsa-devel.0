From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: opening control devices with "hw:N,M"
Date: Sat, 20 Jul 2002 09:08:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0207200907430.809-100000@pnote.perex-int.cz>
References: <s5hbs93r4a7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA07443
	for <alsa-devel@alsa-project.org>; Sat, 20 Jul 2002 09:08:48 +0200
In-Reply-To: <s5hbs93r4a7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <pbd@op.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Jul 2002, Takashi Iwai wrote:

> At Thu, 18 Jul 2002 09:03:26 -0400,
> Paul Davis wrote:
> > 
> > why doesn't this work:
> > 
> >     snd_ctl_open (&handle, "hw:0,0", ...)
> > 
> > it means that you can't use the same standard name format for control
> > devices as PCM devices, which is a bit of problem for programs that
> > need to open both but only want to require the user to specify a
> > single name ...
> 
> do you suppose that the second argument of ctl name is always ignored?
> the control interface has no device like pcm.
> 
> but it's true that having a same naming rule makes the life easier...

The 'default' is there for this purpose. Otherwise, application / user 
must know the right device name.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
