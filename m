From: Martin Langer <martin-langer@gmx.de>
Subject: Re: finding out the driver module in use for a given PCM
Date: Sun, 26 Sep 2004 19:55:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040926175522.GA1102@tuba.home>
References: <200409261818.14729.cannam@all-day-breakfast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200409261818.14729.cannam@all-day-breakfast.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Cannam <cannam@all-day-breakfast.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 26, 2004 at 06:18:14PM +0100, Chris Cannam wrote:
> 
> Can anyone suggest a way for the user or a script to discover which kernel 
> module is in use for a given card?  (As in, card N == the card detailed 
> at /proc/asound/cardN.)
> 
> I naively thought I could do it trivially (at least for the most usual cases 
> where the user has only one of each sort of card) by looking for the 
> snd-card-N line from /etc/modules.conf.  But that doesn't work even for my 
> simple test machine, which has an Intel AC97 codec: if I specify snd-card-0 
> to be snd-intel8x0 without options, I get both /proc/asound/card0 
> and /proc/asound/card1 from the same driver (seems one of them is the modem).  
> Is there any way to tell that they're both run by the same driver?
> 
> If I also have an Audiophile 2496 as snd-card-1, it will correspond 
> to /proc/asound/card2 (as the 8x0 has card0 and card1).  But no snd-card-2 in 
> modules.conf at all.  How can I discover that /proc/asound/card2 is in fact 
> an ice1712-driven card?
> 
> (The aim is just to write a simple script that starts a mixer app for a given 
> soundcard, starting envy24control if the card is driven by snd-ice1712, 
> hdspmixer if it's driven by snd-hdspsomething, etc.)

Hmm, what about /proc/asound/modules ?


martin


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
