From: Richard Bown <bownie@bownie.com>
Subject: Re: Quick SBLive/AWE32 synth question
Date: Wed, 31 Jul 2002 19:02:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207311902.02690.bownie@bownie.com>
References: <200207301624.02609.bownie@bownie.com> <s5hy9bsf2x1.wl@alsa2.suse.de>
Reply-To: bownie@bownie.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy9bsf2x1.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> can you check whether this happens on SB Live only or both on SB Live
> and AWE?

Chris and I are both experiencing it - I've got an SBLive and he's the AWE32.
All of us (including Taupter who's the only other one to report this problem
so far on this list) are using Rosegarden so I'm suddenly very paranoid it's
us instead.  I'll double check probably tomorrow and get back to you.

I'm trying to reproduce the problem with another sequencer but to tell the
truth I'm having a problem finding one that does on-board ALSA synths too.
I've got Muse and Brahms but I can't get the former working properly and the
latter is aRts only - there must be a playmidi equivalent for ALSA but for the
moment my mind has gone blank.

> a similar problem has been reported, but not the identical as i've
> heard.  perhaps by the same reason, though.
> that is, most likely a long-standing bug of wavetable routine on
> emu10k1 driver...   (well, yeah, i know, it must be fixed :)

To me this sounds reasonable - from the dim and distant past I remember
fiddling with voice allocation maps when implementing synth output for OSS
and I know how tortuous it can all be.  I also know how flakey my code is
so YMMV.

> could you try to make a short midi clip which can cause the same
> behavior, so that i can test to reproduce on my machine?

I will do once I've convinced myself it's not us.

B


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
