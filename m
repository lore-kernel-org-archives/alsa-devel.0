From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-user] Edirol DA-2496
Date: Fri, 19 Sep 2003 10:27:59 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309190922420.2357-100000@studcom.urz.uni-halle.de>
References: <1063907973.2726.6.camel@81-202-149-3.user.ono.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1063907973.2726.6.camel@81-202-149-3.user.ono.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonatan de la Torre <jonatandelatorre@ono.com>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jonatan de la Torre wrote:
> * One IC whose PCB tag is IC38
>
> CS8420-CS

sample rate converter

> * Four IC's whose PCB tags are IC17, IC22, IC27, IC32
>
> AK4524VF

stereo 24bit 96kHz DAC/ADC

These chips are used on M-Audio cards, too.

> Anything else before I close the box?

Please try to load the snd-ice1712 driver, and show the contents of
the /proc/asound/cardX/ice1712 file. The driver might actually work
with your card.

If not, the EEPROM subvendor/device ID has to be added to the driver.
Your card looks as if it might be compatible to the Delta 1010LT; if
it isn't, we have to know to which pins of the ICE1712 the other chips
are connected.


Regards,
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
