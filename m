From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Sampling rate problems on a VXPocket v2
Date: Fri, 12 Dec 2003 09:30:06 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312120928370.20863@pnote.perex-int.cz>
References: <OF68B2BE80.8E208767-ONC1256DFA.002A67D4-C1256DFA.002A6C7F@bang-olufsen.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <OF68B2BE80.8E208767-ONC1256DFA.002A67D4-C1256DFA.002A6C7F@bang-olufsen.dk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Geoffrey Martin <GGM@bang-olufsen.dk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Dec 2003, Geoffrey Martin wrote:

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

Yes, use 'iecset' utility from alsa-utils for example or alsactl and 
reedit your configuration file (look for IEC958 controls).

> flag using an application, and the sampling rate indicator changes
> automatically with the actual sampling rate of the card's output.

We might change the behaviour later. Actually the PCM rate and S/PDIF 
indicated rate might differ in the current vxpocket driver.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
