From: Tim Goetze <tim@quitte.de>
Subject: Re: Xruns with Audiophile 2496 M-audio
Date: Sat, 29 May 2004 12:52:15 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405291234350.566@autumn>
References: <20040529114908.2118135c@pentium233.krystal.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040529114908.2118135c@pentium233.krystal.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Remi Bernhard <rgbmlist2@free.fr>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

[Remi Bernhard]
>I read a lot a great thing about the audiophile 24/96 on the net, and i
>decided to buy it to get better latency than my old sblive! I just
>received the audiophile 24/96 and unfortunatly, i have a lot of XRuns
>with when i run jackd.

my old system had various 2.4.x-ll kernels, asus board and a k6-III
450, then migrated to kernel 2.4.19-ll, a cheap-as-hell board (forgot
the brand name) and an athlon xp 2k, ALSA versions ranging from
pre-0.9 CVS to 1.0.3.

the PCI audiophile 24/96 ran and runs smooth as a train in all
configurations at 64 frames / 44.1 kHz.

obvious question, is your kernel ll-patched? if not, go here:

http://www.zipworld.com.au/~akpm/linux/schedlat.html

(i gather that 2.4 is still the better choice for low-latency
operations.)

oh, btw, the ISA 'Blaster AWE64 i used to run in the old board did
64/44.1 just as stable as the audiophile.

cheers,

tim


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
