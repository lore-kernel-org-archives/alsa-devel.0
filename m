From: pdq808@t-online.de (Reiner Klenk)
Subject: Re: Support for powermac G5?
Date: Mon, 21 Jun 2004 18:30:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D70D3E.60203@t-online.de>
References: <Pine.LNX.4.56L0.0406201812430.22212@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.56L0.0406201812430.22212@linux.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Dont't know anything about soundchips on G5, but on my new Powerbook I 
had to comment out the chipset identification in pmac.c and set the chip 
to snapper.

Reiner

jaspal.kallar.xfree86@spray.se wrote:
> Can anybody say if sound on the powermac G5 is supported ?
> I have no idea which chipset it is either.
> 
> I've tried with kernels 2.6.5, 2.6.6 and 2.6.7
> 
> modprobe snd-powermac
> FATAL: Error inserting snd_powermac 
> (/lib/modules/2.6.7-r0/kernel/sound/ppc/snd-powermac.ko): No such device
> 
> 
> and in /var/log/messages I get
> 
> "Jun 20 18:19:09 linux ALSA sound/ppc/pmac.c:1095: pmac: can't request resource 0!
>  Jun 20 18:19:09 linux no PMac soundchip found"
> 
> 
> Can anybody give me some pointers into what the problem could be. Btw I 
> have snd-powermac as a module and not compliled into any of the above kernels.
> But I have also tried it compliled into the kernel but with same results.
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
> Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
> Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
> REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
