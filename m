From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsamixer on cvs
Date: Thu, 5 Sep 2002 08:32:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209050829550.524-100000@pnote.perex-int.cz>
References: <200209042211.PAA09304@cmn29.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200209042211.PAA09304@cmn29.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 4 Sep 2002, Fernando Pablo Lopez-Lezcano wrote:

> > > Fernando Pablo Lopez-Lezcano wrote:
> > > >
> > > > After installing a new cvs version I'm getting an assertion failure in
> > > > alsamixer (or amix).
> > > >
> > > > # alsamixer
> > > > alsamixer: simple.c:869: simple_add1: Assertion
> > > > `!simple->ctls[type].elem' failed.
> > > > Aborted
> > >
> > > could you try to remove the assert() at alsa-lib/src/mixer/simple.c
> > > line 869?  this looks like a wrong conditional...
> >
> > It's ok. Could you send us output from alsactl utility? We have probably
> > two controls with same name.
> 
> Sure, it is included at the end of the email. I found the
> same problem yesterday in an ens1371 based soundcard.

I've fixed the problem in CVS for intel8x0, but ens1371 hasn't two codecs.
Could you try the latest CVS and 'amixer scontrols'? The error (which
control is twice) should be printed at start to stderr.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
