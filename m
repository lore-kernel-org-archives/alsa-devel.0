From: Kasper Souren <kasper@303.nu>
Subject: 1869 trouble with snd-es18xx
Date: Thu, 27 Jun 2002 14:20:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D1B0307.8080002@303.nu>
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
To: alsa devel <alsa-devel@lists.sourceforge.net>, abramo@alsa-project.org, fishbach@pool.informatik.rwth-aachen.de
List-Id: alsa-devel@alsa-project.org

Hi,

I'm still trying to get ALSA running on my es1869 chip. The chip gets 
detected properly:

   ALSA ../alsa-kernel/isa/es18xx.c:1544: [0x220] ESS1869 chip found

Also alsamixer works properly.

But when I try to play a soundfile with alsaplayer I just get whitish noise. 
I get a lot of messages like this from dmesg:

   ALSA ../alsa-kernel/core/pcm_native.c:1093: playback drain error
   (DMA or IRQ trouble?)

I tried other IRQ's and DMA's, and then the chip doesn't get recognised, or 
I don't get noise when playing something. Also, the IRQ and DMA settings 
(IRQ 5, DMA1 1, DMA2 5) are the same for the OSS sb driver, which is working 
properly.

So... What can I do? I took a look at es18xx.c but my knowledge about device 
driver programming is very limited. And I'm longing to try ALSA, and JACK, 
and some other stuff... Is there a way to debug device drivers, maybe with gdb?

Isn't there any option to use a 'virtual' ALSA device? Like snd-pcm-oss, but 
then the other way around. snd-oss-pcm module? Then you could use ALSA with 
a working OSS driver, and no working ALSA driver...

greetz,
Kasper



-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
