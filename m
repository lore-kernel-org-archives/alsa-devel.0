From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: status of usb audio driver
Date: Wed, 12 Jun 2002 23:10:19 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D07564B.4050908@boosthardware.com>
References: <s5h7klfdlrn.wl@alsa2.suse.de>	<3D06D91D.1080104@boosthardware.com> <s5hhek81vgl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> it's on cvs.  please give a try.
> btw, now descriptor proc was removed (one can use lsusb anyway).
> instead you'll see formats supported on each stream.
> 

Excellent work. I haven't tested the output yet but will soon. One thing 
that isn't correct is that this card has 4 channels. Is it me or does 
the following only find 3?

---
# cat /proc/asound/card
card0  card1  card2  cards
# cat /proc/asound/card2/
id       pcm0p    pcm1p    pcm2p    stream1
pcm0c    pcm1c    pcm2c    stream0  stream2
# cat /proc/asound/card2/id
card2
# cat /proc/asound/cards
0 [first          ]: CMI8738 - C-Media PCI CMI8738
                      C-Media PCI CMI8738 (model 37) at 0xa800, irq 5
1 [second         ]: ICH - Intel 82801BA-ICH2
                      Intel 82801BA-ICH2 at 0xdc00, irq 3
2 [card2          ]: USB-Audio - USB Audio Driver
                      M Audio USB AudioSport Quattro (tm)
# cat /proc/asound/card2/stream0
M Audio USB AudioSport Quattro (tm) : USB Audio

Playback:
   Format: S16_LE
   Channels: 2
   Rates: 11025, 22050, 44100

Capture:
   Format: S16_LE
   Channels: 2
   Rates: 11025, 22050, 44100
# cat /proc/asound/card2/stream1
M Audio USB AudioSport Quattro (tm) : USB Audio #1

Playback:
   Format: S16_LE
   Channels: 2
   Rates: 11025, 22050, 44100, 48000

Capture:
   Format: S16_LE
   Channels: 2
   Rates: 11025, 22050, 44100, 48000
# cat /proc/asound/card2/stream2
M Audio USB AudioSport Quattro (tm) : USB Audio #2

Playback:
   Format: S16_LE
   Channels: 2
   Rates: 11025, 22050, 44100, 48000

Capture:
   Format: S16_LE
   Channels: 2
   Rates: 11025, 22050, 44100, 48000

---


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
