From: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Subject: Re: A couple of hardware problems
Date: Tue, 14 Jan 2003 17:28:47 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030114172847.GF23537@ecs.soton.ac.uk>
References: <20030114143440.GW22132@ecs.soton.ac.uk> <s5hfzrvya3b.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hfzrvya3b.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 14, 2003 at 05:23:04PM +0100, Takashi Iwai wrote:
> yes, usually "auto" means to activate the chip on mobo only when no
> other soundcards exist.

Thanks. I wonder why the mobo is not giveing me the "enabled" option it
mentions in the docs. Oh well.
 
> > The other I dont know about: I bought an ESS Solo1 based card (Terratec
> > 128i PCI) to use the MIDI port, but it doesn't appear to work for MIDI
> > input. I've been messing with it for a couple of days and I'm ready to
> > give up and swap it for an old ens1371 based card. If anyone has anything
> > I should try before swtiching it please say.
> 
> the last time i tried, i also couldn't get the midi-in working, and
> forgot this issue for a while.  i just took a look at the code again. 
> could you test the attached patch?  it's to the latest cvs but likely
> applicable to your version, too.

OK, I'l try to apply it this evening. I could sort of get some input (the
Rx bytes number in /proc/asound/card0/midi0 went up) when I opened the
lowlevel device for writing with dd and sent midi in, it didn't seem to be
going up reliably though.

- Steve


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
