From: Remi Bernhard <rgbmlist2@free.fr>
Subject: Re: [Alsa-devel] Xruns with Audiophile 2496 M-audio
Date: Sat, 29 May 2004 13:16:01 +0200
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <20040529131601.641aa202@pentium233.krystal.net>
References: <20040529114908.2118135c@pentium233.krystal.net>
	<Pine.LNX.4.58.0405291234350.566@autumn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0405291234350.566@autumn>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Tim Goetze <tim@quitte.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, 


On Sat, 29 May 2004 12:52:15 +0200 (CEST)
Tim Goetze <tim@quitte.de> wrote:

> [Remi Bernhard]
> >I read a lot a great thing about the audiophile 24/96 on the net, and
> >i decided to buy it to get better latency than my old sblive! I just
> >received the audiophile 24/96 and unfortunatly, i have a lot of XRuns
> >with when i run jackd.
> 
> obvious question, is your kernel ll-patched? if not, go here:
> 
> http://www.zipworld.com.au/~akpm/linux/schedlat.html

As i said , 

<rb>
Sofware :
  Debian/Testing
  Kernel 2.6.5
</rb>

So i have 2.6.5 kernel, and not 2.4.x. Do you think i should install
2.4.25 instead ?

> 
> (i gather that 2.4 is still the better choice for low-latency
> operations.)
> 

I read the alsa-* archives, and i saw a thread with two people who had
good latency results with 2.6.x. 
Could someone tell me if man can achieve a buffer size <=128 with
audiophile 2496 and kernel 2.6.x ?

> oh, btw, the ISA 'Blaster AWE64 i used to run in the old board did
> 64/44.1 just as stable as the audiophile.

Great !

Regards,
	Remi.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
