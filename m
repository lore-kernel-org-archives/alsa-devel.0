From: Tim Goetze <tim@quitte.de>
Subject: Re: Xruns with Audiophile 2496 M-audio
Date: Sat, 29 May 2004 16:34:49 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405291631440.566@autumn>
References: <20040529114908.2118135c@pentium233.krystal.net>
 <Pine.LNX.4.58.0405291234350.566@autumn> <20040529131601.641aa202@pentium233.krystal.net>
 <Pine.LNX.4.58.0405291329280.566@autumn> <20040529160048.27d74531@pentium233.krystal.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040529160048.27d74531@pentium233.krystal.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Remi Bernhard <rgbmlist2@free.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

[Remi Bernhard]
>I tried with kernel 2.4.25 + lowlatency patch.
>I have the same xruns :-/
>
>Any other idea ?

checklist:

* running jackd as root? with -R option?
* tried running jackd without any clients?
* IDE-DMA enabled?
* ll-sysctl interface chosen at kernel build time? turned it on?
* X running? tried without?
* tried 'latencytest' from the ALSA tree?

tim


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
