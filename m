From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Why do I get broken pipe on write to a pcm in  
 statePREPARED?
Date: Mon, 16 Sep 2002 21:31:03 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D863177.51DB8C79@libero.it>
References: <Pine.LNX.4.33.0209131137140.521-100000@pnote.perex-int.cz>
		<3D84C9EB.DF7C7D6C@libero.it> <s5h4rcqtdoy.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Anders Torger <torger@ludd.luth.se>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> At Sun, 15 Sep 2002 19:56:59 +0200,
> Abramo Bagnara wrote:
> >
> > Jaroslav Kysela wrote:
> > >
> > > I think that the current behaviour of write() is ok, the behaviour of
> > > poll() might be "fixed". I see advantages for both. I would prefer to have
> > > this configurable to satisfy multi-threaded applications. We can put a new
> > > variable to sw_params.
> >
> > Implementing that specific behaviour for poll I've paid most attention
> > to efficiency issues.
> >
> > Consider that if you choose a differente behaviour for poll you're
> > forced to check for xruns (i.e. enter kernel space) just before *every*
> > poll!
> 
> well, the origianl question was the behavior of poll at the prepare
> (and pause) state, so the theme has nothing to do with xruns (it
> cannot happen :)
> 
> the behavior of poll at other states should be as well as before.
> 

I think that the best behaviour is the current and it's also the
simplest to describe and to understand: poll/select never blocks when
there is nothing to wait.

... and in PREPARED state definitely there's nothing to wait from sound
card.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
