From: David Lloyd <dmlloyd@tds.net>
Subject: Re: DMIX and capture stream
Date: Mon, 5 Jan 2004 11:20:40 -0600 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401051113381.8705@tomservo.workpc.tds.net>
References: <200401040507.i0457Qbv005994@dhin.linuxaudiosystems.com>
 <Pine.LNX.4.58.0401051020560.8705@tomservo.workpc.tds.net> <s5hbrpi2vq8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbrpi2vq8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, ALSA Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 5 Jan 2004, Takashi Iwai wrote:

> At Mon, 5 Jan 2004 10:29:01 -0600 (CST),
> David Lloyd wrote:
> > 
> > On Sun, 4 Jan 2004, Paul Davis wrote:
> > 
> > > >I'm working on changing DMIX to allow clients to open the capture stream.  
> > > 
> > > i don't get it. dmix is for playback, not capture. what would be the
> > > semantics of this?
> > 
> > That is exactly the problem!  DMIX is for playback.  DSNOOP is for 
> > capture.  Where is the module that is for both?  Why, oh why, did they not 
> > simply make ONE MODULE in the first place??
> 
> patch welcome ;)
> 
> well, more practical answer is that capturing the playback would need 
> copy of the playback data to the capture buffer.  meanwhile, the
> implementation of dmix and dsnoop is basically only the multiplex
> access of a single hardware buffer.  it's not "copying" of data.

Nonononono.  Nobody is understanding what I want!

I have application A that needs to open payback and capture streams 
because it's a two-way communications program.  Application B is a game 
that uses playback only.  I want to use these both at the same time.

Problem is both applications use OSS emulation.  They both work with aoss, 
but the two-way program won't initialize sound when dmix is loaded because 
it's not allowed to open capture stream.  See my problem?  I can't put two 
different plugins in my audiorc and expect an OSS application to 
understand it.  I am not interested in capturing the playback stream!  I 
just want to have more than one program be able to use /dev/dsp for both 
input and output...

- D


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
