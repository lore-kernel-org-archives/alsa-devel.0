From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: Re: controls for the ice1712
Date: Tue, 9 Jul 2002 21:04:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207092058070.23283-100000@pc40.e18.physik.tu-muenchen.de>
References: <15657.43466.645747.163894@ccs.covici.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <15657.43466.645747.163894@ccs.covici.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: John covici <covici@ccs.covici.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 8 Jul 2002, John covici wrote:

> OK, you have been of great help -- just one more question -- or
> rather two, I cannot find a control for the pcm out, although other
> things are set up which say value 'PCM OUT' I cannot find a control
> labelled 'PCM OUT' to either capture or do anything about.  Also what
> are h/w in 0 through 7 and what are the multi capture switches and
> volumes 1 through 9.  I think I am slowly getting to understand this,
> but it is a bit confusing.
> 
If you are looking for a volume/mute control for PCM OUT you can have a
look at the multi track volume for channels 0 and 1. That's at least the
one for the Hoontech card. Those multi capture settings are (to my
understanding) virtual input devices provided by the ice1712, but you
should better ask some expert. The situation with the h/w inputs could be
similar to the h/w output, namely that one pair is "real" while the others
are virtual, but again, I don't know your card (the Hoontech has only one 
pair of RCA jacks for input/output each).

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Stuff, things, and much much more.
http://thinkgeek.com/sf
