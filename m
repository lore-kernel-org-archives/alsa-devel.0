From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: alsamixer on cvs
Date: Tue,  3 Sep 2002 12:23:49 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209031923.MAA07291@cmn29.stanford.edu>
References: <Pine.LNX.4.44.0209022137350.7932-100000@cmn37.stanford.edu>
	<s5h65xne5sr.wl@alsa2.suse.de>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
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
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

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

I tried that and it seems to work fine now, obviously I did
not do extensive tests. Thanks.

-- Fernando


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
