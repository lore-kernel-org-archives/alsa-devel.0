From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: opening control devices with "hw:N,M"
Date: Mon, 22 Jul 2002 21:21:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0207222050001.966-100000@pnote.perex-int.cz>
References: <s5hy9c4owgo.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA20476
	for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2002 21:22:51 +0200
In-Reply-To: <s5hy9c4owgo.wl@alsa2.suse.de>
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

On Mon, 22 Jul 2002, Takashi Iwai wrote:

> At Sat, 20 Jul 2002 09:08:29 +0200 (CEST),
> Jaroslav wrote:
> > 
> > On Fri, 19 Jul 2002, Takashi Iwai wrote:
> > 
> > > At Thu, 18 Jul 2002 09:03:26 -0400,
> > > Paul Davis wrote:
> > > > 
> > > > why doesn't this work:
> > > > 
> > > >     snd_ctl_open (&handle, "hw:0,0", ...)
> > > > 
> > > > it means that you can't use the same standard name format for control
> > > > devices as PCM devices, which is a bit of problem for programs that
> > > > need to open both but only want to require the user to specify a
> > > > single name ...
> > > 
> > > do you suppose that the second argument of ctl name is always ignored?
> > > the control interface has no device like pcm.
> > > 
> > > but it's true that having a same naming rule makes the life easier...
> > 
> > The 'default' is there for this purpose. Otherwise, application / user 
> > must know the right device name.
> 
> iirc, it's not easy to pass the card/device number to "default" pcm.
> at least, "default:CARD=1" doesn't work.  the easiest way to access a
> certain card is, so far, only to use "hw:x".
> this must be fixed.

I don't agree here. The default is very simple case when the application 
programmer doesn't want to take care about the right syntax of the device 
specification.

Anyway, programmers should know that CTL devices are one per card. If 
there is some real need to correlate PCM handle with CTL handle, then we 
might create a special function like:

int snd_pcm_get_ctl_name(snd_pcm_t *handle, char **ctl_name);

> also, i thought that ctl.hw is defined purely in
> /usr/share/alsa/alsa.conf, and tried to redefine this to accept more
> arguments.  but it doesn't change anything.  is ctl.hw hardcoded?

Extra things in configuration file are usually parsed as errors.

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
