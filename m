From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsamixer on cvs
Date: Wed, 4 Sep 2002 09:17:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209040917120.521-100000@pnote.perex-int.cz>
References: <s5h65xne5sr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65xne5sr.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Sep 2002, Takashi Iwai wrote:

> At Mon, 2 Sep 2002 21:40:37 -0700 (PDT),
> Fernando Pablo Lopez-Lezcano wrote:
> > 
> > After installing a new cvs version I'm getting an assertion failure in 
> > alsamixer (or amix). 
> > 
> > # alsamixer
> > alsamixer: simple.c:869: simple_add1: Assertion `!simple->ctls[type].elem' 
> > failed.
> > Aborted
> 
> could you try to remove the assert() at alsa-lib/src/mixer/simple.c
> line 869?  this looks like a wrong conditional...

It's ok. Could you send us output from alsactl utility? We have probably 
two controls with same name.

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
