From: Francesco Rossi <franc@agbms.ch>
Subject: Re: ES1938 - ESS Solo1 - 3 Cards mounted
Date: 19 Sep 2002 10:28:03 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1032424083.6398.15.camel@franc.agbms.ch>
References: <E17rKNW-0000eB-00@usw-sf-list2.sourceforge.net>
	<1032291542.12984.87.camel@franc.agbms.ch>  <s5hvg53r4e7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvg53r4e7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I believe it may sound weird, but I have successfully ran 3 cards
recording at 32.000 Hz each stereo, 16 bits. I left it running for
24hours to check if it was just luck and it never crashed!

The configuration I have used with three cards sums up to 384K per
second running on the PCI bus. 

Now my test continues and I have added another two cards, reaching the
limit of my slots, 5 cards.

When I start the arecord on all of them, it doesn't crash, but it's
recording at 8000 Hz 8bits mono by default.

I then tried running arecord at 16000 Hz, stereo, 16 bits, and it
crashed when I started the 5th card.

What's weird is that with this configuration on the bus we should have
only 320k per second.

It appears to me that it is crashing when I am increasing the summed
sample rate. But then it doesn't make sense because 320k is less than
384k.

Do you have any idea?

Thanks,
              Franc



On Wed, 2002-09-18 at 12:14, Takashi Iwai wrote:
> At 17 Sep 2002 21:39:01 +0200,
> Francesco Rossi wrote:
> > 
> > Some more info, I finally ran into a kernel message:
> > CPU 0: Machine Check Exception: 0000000000000004
> > Bank 0: a200000084010400
> > Kernel panic: CPU context corrupt
> > In idle task - not syncing
> 
> this is really weird.
> it looks like a hardware problem rather than the driver problem.
> 
> questions come to my mind are:
> 
> - try UP kernel if you're using smp?
> - playing on three cards is ok?
> - still problems only with two cards?
> - how about different pci slots?
> 
> 
> Takashi




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
