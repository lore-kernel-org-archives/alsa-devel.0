From: Remi Bernhard <rgbmlist2@free.fr>
Subject: Re: [Alsa-devel] Xruns with Audiophile 2496 M-audio
Date: Sun, 30 May 2004 11:09:23 +0200
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <20040530110923.5ce0172f@pentium233.krystal.net>
References: <20040529114908.2118135c@pentium233.krystal.net>
	<Pine.LNX.4.58.0405291234350.566@autumn>
	<20040529131601.641aa202@pentium233.krystal.net>
	<Pine.LNX.4.58.0405291329280.566@autumn>
	<20040529160048.27d74531@pentium233.krystal.net>
	<Pine.LNX.4.58.0405291631440.566@autumn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0405291631440.566@autumn>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Tim and all,


On Sat, 29 May 2004 16:34:49 +0200 (CEST)
Tim Goetze <tim@quitte.de> wrote:

> [Remi Bernhard]
> >I tried with kernel 2.4.25 + lowlatency patch.
> >I have the same xruns :-/
> >
> >Any other idea ?
>=20
> checklist:
>=20
> * running jackd as root? with -R option?

Tried -> failed.

> * tried running jackd without any clients?

It worked, but as i put some clients, i get xruns again.

> * IDE-DMA enabled?

Yes.

> * ll-sysctl interface chosen at kernel build time? turned it on?

Yes.

> * X running? tried without?

I didn't tried that.

> * tried 'latencytest' from the ALSA tree?

I didn't tried that.

I thank you a lot guys for your help and ideas, but now i've done
enought twiking / hacking / patching kernel, switching the audiophile
from pci port to pci port, changing irq, recompiling kernel 2.6.5,
2.4.25, 2.6.6, patching again, fails again, etc. etc.

Now i have reinstalled my old sblive! with 512 buffer size, and i'm
happy with it (for the moment). I think i'll return the audiophile
24/96 next week.

Thanx again for all your help.

Regards,
	R=E9mi Bernhard.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
