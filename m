From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Fwd: Re: [linux-audio-user] Sampling rate problems on a VXPocket
 v2
Date: Thu, 11 Dec 2003 18:25:05 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FD837F1.8060609@boosthardware.com>
References: <OF0970C0E0.30BA8562-ONC1256DF9.002F050D-C1256DF9.00321B9F@bang-olufsen.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: A list for linux audio users <linux-audio-user@music.columbia.edu>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fwd'd to alsa-devel.


Geoffrey Martin wrote:
> 
> 
> 
> Hi,
> 
> I'm using the following:
>       IBM T40 laptop
>       Digigram VXPocket v2
>       RedHat 9
>       Kernel 2.4.22-ac4
>       ALSA drivers 0.9.8
>       vxloader 0.9.7-i686
> 
> Measurement gear
>       Audio Precision System Two Cascade
>       PrismSound DSA-1
> 
> 
> Some of my other gear is having difficulties locking to the S/PDIF output
> of the card at 44.1 kHz and I have a suspicion as to why this is
> happening...
> 
> I have control over the sampling rate of the S/PDIF output of the card as I
> would expect, however...
> 
> In the S/PDIF Channel Status Block information there is a portion of Byte 3
> that is used to send the intended sampling rate (selectable between three
> values, 32 kHz, 44.1 kHz and 48 kHz, depending on the arrangement of bits
> 0-3 in Byte 3. For specific information on this, please see Application
> Note AN22REV2 from www.crystal.com). It is also possible, using bit 0 of
> Byte 0, to indicate whether the signal is Professional or Consumer format.
> 
> Using my present configuration, I do not appear to have control over either
> of these two variables. For example, even when I am sending a 44.1 kHz
> signal at a rate of 44.1 kHz (or close enough... it's actually 44.0993, -17
> ppm) Byte 3 of the Channel Status Block is saying that the signal is a 48
> kHz transmission.
> 
> Are the VXPocket drivers in ALSA capable of changing these values in the
> card? The official drivers for Mac OSX allow me to change the Pro/Consumer
> flag using an application, and the sampling rate indicator changes
> automatically with the actual sampling rate of the card's output.
> 
> Cheers
> -geoff
> 
> 
> 
> 
> ____________________________________________________
> Geoff Martin Ph.D.
> Tonmeister, Bang & Olufsen a/s
> email: ggm@bang-olufsen.dk
> web: www.bang-olufsen.com
> web: www.tonmeister.ca
> phone: +45 96 84 49 54
> 
> 
> 
> 


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================


  Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
