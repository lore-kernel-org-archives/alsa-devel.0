From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: pcm_drain() behavior (Re: snd_pcm_close hangs)
Date: Wed, 26 Jun 2002 19:23:45 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0206261923120.795-100000@pnote.perex-int.cz>
References: <s5hfzza55ip.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzza55ip.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Tim Goetze <tim@quitte.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 26 Jun 2002, Takashi Iwai wrote:

> At Wed, 26 Jun 2002 17:55:49 +0200 (CEST),
> Jaroslav wrote:
> > 
> > On Mon, 24 Jun 2002, Takashi Iwai wrote:
> > 
> > > At Tue, 18 Jun 2002 20:23:50 +0200 (CEST),
> > > Tim Goetze wrote:
> > > > 
> > > > Takashi Iwai wrote:
> > > > 
> > > > >well, draing samples at close corresponds to flushing the buffered
> > > > >data to disk at fclose.  then it sounds normal, doesn't it?
> > > > 
> > > > i'm still not convinced -- if the stream is running when you close it,
> > > > you're right, obviously. 
> > > > 
> > > > but when it's not running, starting and stopping it usually produces a
> > > > click that will ruin the audible effect of the few msec worth of sound
> > > > 'drained' (that nobody cares about anyway since the stream is about to
> > > > be closed).
> > > > 
> > > > right?
> > > 
> > > this is a question of behavior.
> > > i don't think it's absolutely "wrong" that the driver processes the
> > > rest of samples at stop status if drain() is called.
> > > 
> > > but..  from my feeling, i agree with you.  it doesn't matter if the
> > > samples are simply dropped at close() when its stream was already
> > > stopped.  so i myself would like to change this behavior.
> > > the fix must be quite easy.
> > > 
> > > however, we need a consensus about this.
> > > 
> > > any comments (or objections)?
> > 
> > We can see both behaviour for the device access. The current
> > implementation was taken from OSS. Actually, I don't mind to change it,
> > because programmers should call drop() or drain() before close depending
> > on their choice. It's also true, when the process is canceled for some 
> > signal, it would be better to drop the contents of ring buffer by default. 
> > It means that even the stream is running, it should be stoped and droped 
> > in native API.
> 
> yep.
> dropping in all cases will be the easiest solution.
> we can even reduce the strange conditionals in close().
> 
> drain() can be called at the close() of oss emulation layer
> if it's really necessary.

It is, but the OSS emulation code already uses a different flush method, 
so we don't need to touch this code.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabberConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
