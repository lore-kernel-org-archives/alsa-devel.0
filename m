From: Francesco Rossi <franc@agbms.ch>
Subject: Re: ES1938 - ESS Solo1 - 3 Cards mounted
Date: 08 Oct 2002 17:57:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1034092679.3245.76.camel@franc.agbms.ch>
References: <Pine.LNX.4.33.0209191039490.7337-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0209191039490.7337-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I just wanted to inform that I have changed the cards with SoundBlaster
4.1 Digital (driver snd-ens1371) and they are working together like a
charm!
It has also been a nice opportunity to test the new Mandrake Linux 9.0
which comes bundled with the latest alsa drivers.
Thanks,
             Franc


On Thu, 2002-09-19 at 10:41, Jaroslav Kysela wrote:
> On 19 Sep 2002, Francesco Rossi wrote:
> 
> > I believe it may sound weird, but I have successfully ran 3 cards
> > recording at 32.000 Hz each stereo, 16 bits. I left it running for
> > 24hours to check if it was just luck and it never crashed!
> > 
> > The configuration I have used with three cards sums up to 384K per
> > second running on the PCI bus. 
> > 
> > Now my test continues and I have added another two cards, reaching the
> > limit of my slots, 5 cards.
> > 
> > When I start the arecord on all of them, it doesn't crash, but it's
> > recording at 8000 Hz 8bits mono by default.
> > 
> > I then tried running arecord at 16000 Hz, stereo, 16 bits, and it
> > crashed when I started the 5th card.
> > 
> > What's weird is that with this configuration on the bus we should have
> > only 320k per second.
> > 
> > It appears to me that it is crashing when I am increasing the summed
> > sample rate. But then it doesn't make sense because 320k is less than
> > 384k.
> > 
> > Do you have any idea?
> 
> Note that ESS Solo1 hardware is not very good. We have several workarounds 
> in our driver to fix the wrong hardware behaviour. Perhaps, it could have 
> more design problems so it eats more bus bandwidth than necessary. Try 
> another hardware.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project  http://www.alsa-project.org
> SuSE Linux    http://www.suse.com




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
