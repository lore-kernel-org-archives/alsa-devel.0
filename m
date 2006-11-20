From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: Re: Long-standing 5.1ch huge LFE/rear swap annoyance
	(ALSA vs. Windows!)
Date: Mon, 20 Nov 2006 20:51:56 +0100
Message-ID: <20061120195156.GA1181@rhlx01.hs-esslingen.de>
References: <20061118013834.GA22785@rhlx01.hs-esslingen.de>
	<1164031610.1310.276596069@webmail.messagingengine.com>
	<s5hzmamkx5j.wl%tiwai@suse.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hzmamkx5j.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Nov 20, 2006 at 03:31:04PM +0100, Takashi Iwai wrote:
> At Mon, 20 Nov 2006 15:06:50 +0100,
> Clemens Ladisch wrote:
> > 
> > > But OTOH *if* the comment above is correct and ALSA *does* employ a modified channel
> > > order vs. Windows and Mac OS X, then it seems as if it might be speaker-test which
> > > *doesn't* obey this ALSA ordering???
> > 
> > speaker-test _does_ obey the ALSA ordering.  However, USB devices do not,
> > and there is not yet an ALSA configuration file for remapping channels
> > on USB devices.
> > 
> > This is a bug in the ALSA library.
> 
> I'd call it rather a configuration bug.
> 
> 
> > > Could we please try to put an end to this insanity?
> > 
> > I'm working on this.
> 
> What solution in sight?

Sorry for the strong wording ;)
I'll have a look at getting done an USB-Audio channel config.

> > > Is there anyone who has extensive experience with 5.1 surround channel ordering status
> > > of many different soundcards on ALSA? How many "ok", how many swapped?
> > 
> > AFAIK USB devices are the only ones where channels are swapped.
> 
> Possibly some ice172x-based devices may have similar problems.
> There are many untested boards.

To me it sounded like that scope is far bigger than USB-only, from internet
research (and bug tracker).

I also had a quick visit to #ubuntu (openprojects) where I was absolutely SHOCKED
about the amount of sound config issues. Those even exceeded the amount of
wireless configuration requests. At least 3 sound/mixer issues within the
one hour that I was in there (weirdly swapped channels on surround,
almost no sound or none at all, ...).

Thus I think there should be more effort towards getting currently implemented
chipset drivers to work on all those cards easily.
Of course this is much easier said than done...

Andreas Mohr

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
