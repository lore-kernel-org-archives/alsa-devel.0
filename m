From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: mixer device
Date: Thu, 13 May 2004 19:10:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040513171025.GF6913@sunrise.pg.gda.pl>
References: <20040513153457.GE6913@sunrise.pg.gda.pl> <XFMail.20040513182817.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <XFMail.20040513182817.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, May 13, 2004 at 06:28:17PM +0200, Giuliano Pochini wrote:
> Good question. The current approach is based on the control
> names but sometimes they're not enough. What do you suggest ?
I am testing changed aoss lib which uses dmix plugin 
to play simultaniously many stereo sound sources.
Now I can use JavaSoundDemo, sound in Flash pages in mozilla,
Q1, Q2 and Q3, xmms and mplayer at once. Of course playing 
simulaniously many Quake games is resource consuming and has no 
practical sense but for demonstration purposes its ok.

OK - there is many different hardware on the market and some cards
are multichannel, some are not, some of them have limited mixers or none.

So maybe we could create an abstract sound card which has a mixer and is
a multichannel one (and could mix many 5.1 sources too ;-)).
Now if a real card has ability to do this we use hardware, and if not
we emulate functionality in software. Example of doing mixer functions
on open PCM stream is a good one. Typical sound program just opens
it's PCM stream, sets the volume level, plays sounds and exits closing
stream. Of course we have programs which need know more about hardware.
OK and this all should be supported too. But typical desktop usage
is to play a few sounds simultaniously (desktop events, Internet music,
browser sounds etc..) and set their volume independently.
There are some sound daemons of course. But we have different daemons
working with different desktops (KDE, GNOME) and even supporting
particular group of programs. All of this is a big mess. So maybe better
solution is to implement this functions at the sound card level.

Regards

-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
