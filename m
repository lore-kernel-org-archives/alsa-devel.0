From: Tim Goetze <tim@quitte.de>
Subject: Re: Xruns with Audiophile 2496 M-audio
Date: Sat, 29 May 2004 13:44:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405291329280.566@autumn>
References: <20040529114908.2118135c@pentium233.krystal.net>
 <Pine.LNX.4.58.0405291234350.566@autumn> <20040529131601.641aa202@pentium233.krystal.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040529131601.641aa202@pentium233.krystal.net>
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
>So i have 2.6.5 kernel, and not 2.4.x. Do you think i should install
>2.4.25 instead ?

i do think so because i never saw any hard facts about latency posted
for the 2.6 series, while 2.4.x-ll is well documented and proven to
work quite well here and elsewhere.

it _could_ also be that your graphics subsystem is hogging the PCI bus
for long enough to cause xruns, but that is mostly guessing since i
never laid my hands on a linux box with nvidia hardware. i take it
you're not running graphics-intensive applications while testing the
audio subsystem anyway.

as Jan has pointed out, make sure your IDE subsystem is using DMA on
all devices, too. (man hdparm)

tim


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
