From: Ken Arromdee <arromdee@rahul.net>
Subject: Re: Is there any chance of getting my card to work?
Date: Tue, 12 Feb 2002 08:14:50 -0800 (PST)
Message-ID: <Pine.BSF.4.21.0202120804420.40306-100000@yellow.rahul.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from yellow.rahul.net (postfix@yellow.rahul.net [192.160.13.18])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA26034
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2002 17:16:41 +0100
Received: from localhost (localhost [127.0.0.1])
	by yellow.rahul.net (Postfix) with ESMTP id 885DE7C83
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2002 08:14:50 -0800 (PST)
In-Reply-To: <s5hn0yf554v.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 12 Feb 2002, Takashi Iwai wrote:
> > I'm the guy with the Shark Predator ISA card, AD1816a-based.
> > It works with 0.5 and doesn't work with 0.9, and nobody's been able to help
> > me so far...
> could you elaborate the symtom a bit more?

Yes.

Cutting and pasting from my earlier post:

My sound card is a Shark Predator ISA.  It's pretty obscure (I had to send in
a patch to get it recognized).  It works fine in Alsa 0.5 with the ad1816a
driver.  It also works fine with oss.

I am running Mandrake 8, kernel 2.4.3-20mdk.

Using 0.9.0 beta 9, Alsa malfunctions in the following way:
-- If I go to alsamixer, I find that the sound gets louder the *lower* I set
the volume, so it's loudest at 0 and can't be heard at all at 100.
-- aplay <filename> only plays the first half second of the sound, which
keeps repeating over and over.  A couple of seconds later I get this error:
    aplay: pcm_write:934: write error: Input/output error
The sound does not stop and keeps repeating until I actually stop Alsa.

I compiled the driver with debug; /var/log/messages shows this:
Nov 19 14:39:42 localhost kernel: ALSA pcm_lib.c:1864: playback write error (DMA
 or IRQ trouble?)
Nov 19 14:39:52 localhost kernel: ALSA pcm_native.c:1250: playback drain error (
DMA or IRQ trouble?)

As far as I can tell, my DMA and IRQ settings are correct.  The relevant
settings from my /etc/modules.conf are:

    alias char-major-116 snd
    options snd snd_major=116 snd_cards_limit=1
    alias snd-card-0 snd-card-ad1816a
    options snd-card-ad1816a snd_port=0x500 snd_mpu_port=0x300 snd_fm_port=0x388
snd_irq=5 snd_mpu_irq=7 snd_dma1=1 snd_dma2=0

[The same settings work in alsa 0.5.  Someone later suggested that I use port
220 instead of 500.  That didn't help.  Either 220 or 500 works in Alsa 0.5.
Taking out the options and letting PNP set up the card didn't help either.]

Here is my /proc/isapnp.

Card 1 'SMM7180:Predator 3D' PnP version 1.0 Product version 2.0
  Logical device 0 'ADS7180:Unknown'
    Supported registers 0x2
    Device is active
    Active port 0x220,0x388,0x500
    Active IRQ 5 [0x2]
    Active DMA 1,0
    Resources 0
      Priority preferred
      Port 0x220-0x240, align 0x1f, size 0x10, 16-bit address decoding
      Port 0x388-0x388, align 0x7, size 0x4, 16-bit address decoding
      Port 0x500-0x560, align 0xf, size 0x10, 16-bit address decoding
      IRQ 5,7 High-Edge
      DMA 1 8-bit byte-count type-A
      DMA 0,1,3 8-bit byte-count type-A
      Alternate resources 0:1
        Priority acceptable
        Port 0x220-0x240, align 0x1f, size 0x10, 16-bit address decoding
        Port 0x388-0x388, align 0x7, size 0x4, 16-bit address decoding
        Port 0x500-0x560, align 0xf, size 0x10, 16-bit address decoding
        IRQ 5,7,10 High-Edge
        DMA 0,1,3 8-bit byte-count type-A
        DMA 0,1,3 8-bit byte-count type-A
      Alternate resources 0:2
        Priority acceptable
        Port 0x220-0x2e0, align 0x1f, size 0x10, 16-bit address decoding
        Port 0x388-0x3b8, align 0x7, size 0x4, 16-bit address decoding
        Port 0x500-0x560, align 0xf, size 0x10, 16-bit address decoding
        IRQ 3,4,5,7,2/9,10,15 High-Edge
        DMA 0,1,3 8-bit byte-count type-A
        DMA 0,1,3 8-bit byte-count type-A
      Alternate resources 0:3
        Priority functional
        Port 0x220-0x2e0, align 0x1f, size 0x10, 16-bit address decoding
        Port 0x388-0x3b8, align 0x7, size 0x4, 16-bit address decoding
        Port 0x500-0x560, align 0xf, size 0x10, 16-bit address decoding
        IRQ 3,4,5,7,2/9,10,15 High-Edge
        DMA 0,1,3 8-bit byte-count type-A
        DMA <none> 8-bit byte-count type-A
  Logical device 1 'ADS7181:Unknown'
    Supported registers 0x2
    Compatible device PNPb006
    Device is active
    Active port 0x300
    Active IRQ 7 [0x2]
    Resources 0
      Priority preferred
      Port 0x300-0x330, align 0x2f, size 0x2, 16-bit address decoding
      IRQ 5,7,2/9 High-Edge
      Alternate resources 0:1
        Priority acceptable
        Port 0x300-0x420, align 0x2f, size 0x2, 16-bit address decoding
        IRQ 3,4,5,7,2/9,10,15 High-Edge
  Logical device 2 'ADS7182:Unknown'
    Supported registers 0x2
    Compatible device PNPb02f
    Device is not active
    Resources 0
      Priority preferred
      Port 0x200-0x200, align 0x7, size 0x8, 16-bit address decoding
      Alternate resources 0:1
        Priority acceptable
        Port 0x200-0x208, align 0x7, size 0x8, 16-bit address decoding
  Logical device 3 'ADS7100:Unknown'
    Supported registers 0x2
    Device is not active
    Resources 0
      Priority preferred
      Port 0x290-0x2c0, align 0x7, size 0x8, 16-bit address decoding



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
