From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA 1.0.5
Date: Mon, 31 May 2004 15:32:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405311531490.1799@pnote.perex-int.cz>
References: <E1BUbHW-0005Wg-PQ@sc8-sf-list2.sourceforge.net>
 <200405311258.53199.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200405311258.53199.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 31 May 2004, Pedro Lopez-Cabanillas wrote:

> > Mobo: Gigabyte 7VT600 with chipset VIA KT600
> > Sound: Integrated Realtek ALC655 AC97 codec
> > http://tw.giga-byte.com/MotherBoard/Products/Products_Spec_GA-7VT600.htm
> 
> Anybody using the same hardware should avoid the 1.0.5 driver, IMO.
> Relevant sources are ac97_codec.c and ac97_patch.c. The problem was
> related to a mutex deadlock.

1.0.5a will be released shortly with this bug-fix.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
