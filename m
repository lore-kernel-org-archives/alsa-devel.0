From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Long-standing 5.1ch huge LFE/rear swap annoyance
 (ALSA vs. Windows!)
Date: Mon, 20 Nov 2006 15:06:50 +0100
Message-ID: <1164031610.1310.276596069@webmail.messagingengine.com>
References: <20061118013834.GA22785@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20061118013834.GA22785@rhlx01.hs-esslingen.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andreas Mohr wrote:
> as I'm trying to improve support for my el-cheapo USB audio adapter,
> I found that one of the bigger issues is swapping of Center/LFE vs.
> rear speakers, as can be seen when running
> 
> speaker-test -c 6 -D pcm.USBAudio
> 
> My theory is that since wave extensible is an established format with different
> channel ordering that some soundcards chose to use this swapped ordering in hardware.

Some do, some don't.

> And ALSA didn't care much since it didn't want to have to expensively remix samples
> into correct order?

Rerouting channels is actually quite cheap.

> But OTOH *if* the comment above is correct and ALSA *does* employ a modified channel
> order vs. Windows and Mac OS X, then it seems as if it might be speaker-test which
> *doesn't* obey this ALSA ordering???

speaker-test _does_ obey the ALSA ordering.  However, USB devices do not,
and there is not yet an ALSA configuration file for remapping channels
on USB devices.

This is a bug in the ALSA library.

> Could we please try to put an end to this insanity?

I'm working on this.

> Is there anyone who has extensive experience with 5.1 surround channel ordering status
> of many different soundcards on ALSA? How many "ok", how many swapped?

AFAIK USB devices are the only ones where channels are swapped.

> Oh, and if the answer is that I should try to fix this on a per-driver (per-card)
> basis, then could anyone tell me where the heck I'd have to tweak snd-usb-audio
> for correct channel order?

You would have to write /usr/share/alsa/cards/USB-Audio.conf.


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
