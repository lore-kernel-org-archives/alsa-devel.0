From: Anton Worshevsky <gbdj@linux.spb.org>
Subject: Re: VIA8233/8235 testers wanted
Date: Wed, 15 Jan 2003 00:48:46 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1333.030115@linux.spb.org>
Reply-To: Anton Worshevsky <gbdj@linux.spb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: gbdj@mail.ru
List-Id: alsa-devel@alsa-project.org

Hello ,

>  if someone has VIA8233, VIA8233A, VIA8233C or VIA8235 chipset, could
>  you help the testing of the new driver?
>  the new driver code is found at
>
>         http://www.alsa-project.org/~iwai/via82xx.c

i has VIA8235 and ALC650 codec. After installing new driver from cvs from
20030113, there is following problem:

In 5.1-channel dvd playback with xine using surround51 device,
i has swapped Rear and Center/lfe channels.
RL <-> Center, RR <-> LFE
i fixed this with following patch for via82xx.c

812,813c812,815
<       case 5: slots = (1<<0) | (2<<4) | (5<<8) | (3<<12) | (4<<16); break;
<       case 6: slots = (1<<0) | (2<<4) | (5<<8) | (6<<12) | (3<<16) | (4<<20); break;
---
> //    case 5: slots = (1<<0) | (2<<4) | (5<<8) | (3<<12) | (4<<16); break;
> //    case 6: slots = (1<<0) | (2<<4) | (5<<8) | (6<<12) | (3<<16) | (4<<20); break;
>       case 5: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12) | (5<<16); break;
>       case 6: slots = (1<<0) | (2<<4) | (3<<8) | (4<<12) | (5<<16) | (6<<20); break;

please note that 5ch mode is untested.
I'm not sure that it is alsa problem, xine' may be.
It will be nice to have a small prog for channel position testing in different
playback modes, because now i know no 5.1ch source other then video player.
In general multichannel playback has good quality now (with rc6 sound was
cracking).

>  the new driver can (hopefully) play multiple streams simultaneously on
>  VIA8233, VIA8233C and VIA8235, but NOT on VIA8233A.

It's worked, but second stream plays only left channel.

Almost all OSS application such as games (UT, tux-racer and other) now producing
cracking and skipping sound. Only XMMS OSS-plugin plays good. OSS-sound was good
with rc6.

Best regards,

Anton Worshevsky




-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
