From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH]: Bug: ALSA Sequencer or MTPAV - easy to
 reproduce
Date: Thu, 13 Feb 2003 17:27:25 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302131725440.1315-100000@pnote.perex-int.cz>
References: <s5hadh0mtc9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hadh0mtc9.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ryan Pavlik <rpav@nwlink.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 13 Feb 2003, Takashi Iwai wrote:

> Hi,
> 
> At Wed, 12 Feb 2003 14:35:29 -0800,
> Ryan Pavlik wrote:
> > 
> > On Wed, 12 Feb 2003 21:41:50 +0100 (CET)
> > Jaroslav Kysela <perex@suse.cz> wrote:
> > 
> > <snip> 
> > > It seems that mtpav don't remeber the old status byte for each
> > > channels. If it's true, then we need to take care about the expansion
> > > in the mtpav driver, because the sequencer MIDI driver removes
> > > duplicated status bytes to opmitize throughput.
> > <snip>
> > 
> > OK, I've attached a patch that emulated running status in the mtpav
> > driver, so there shouldn't be any need to change stuff elsewhere.
> > 
> > Thanks for your pointer, I've been wanting to fix this problem for a
> > very long time. :-)
> 
> thanks for the patch.
> i applied it to cvs with a little improvement (returning immediately
> if snd_rawmidi_transmit() gets null).
> 
> also, i found a bug regarding magic-alloc/free in the driver (at
> last!).  fixed on cvs, too.

Unfortunately, the patch is not perfect. I think that we need to buffer
the whole MIDI message and send it after completion, because it's
possible, that you'll get only partial MIDI message from the rawmidi API 
or at buffer overrun / full.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
