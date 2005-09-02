From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: why is card #2 being set to default?
Date: Fri, 2 Sep 2005 09:50:16 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509020941300.12225-100000@studcom.urz.uni-halle.de>
References: <5bdc1c8b0509011643199f3101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5bdc1c8b0509011643199f3101@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@gmail.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:
> Why is it that on my new AMD64 system the HDSP 9652 is listed as default?
>
> # cat /proc/asound/cards
> 0 [CK804          ]: NFORCE - NVidia CK804
>                      NVidia CK804 with ALC850 at 0xda103000, irq 185
> 1 [default        ]: H-DSP - Hammerfall DSP
>                      RME Hammerfall HDSP 9652 at 0xda000000, irq 209
>
> On my previous systems I believe that card 0 has been default.

This is^H^Hwas a bug in the hdsp driver.  When using the kernel
firmware loader, it registered the card before setting the card name,
so ALSA used the string "default" as card ID instead of the last word
of the card name.

The ID string has nothing to do with which card actually is the
default card.


HTH
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
