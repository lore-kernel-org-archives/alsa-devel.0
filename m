From: Kasper Souren <kasper@303.nu>
Subject: es1869 as sb?
Date: Fri, 26 Apr 2002 19:33:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CC98F63.1020105@303.nu>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi. I'm trying to get my laptop soundchip, an ES1869 running under ALSA. 
Under OSS it runs as an sb. With "modprobe sb io=0x220 irq=5 dma=1 dma16=5" 
I get:

SB 3.01 detected OK (220)
ESS chip ES1869 detected
<ESS ES1869 AudioDrive (rev 11) (3.01)> at 0x220 irq 5 dma 1,5

But this doesn't work with any of the ALSA sb modules. None of them accepts 
  any of the parameters I supply to in the command above. Is there a way to 
supply IRQ and DMA settings?
Or is there another way to get it running?

And also the ALSA es18xx module doesn't work. But I expected that, since I 
didn't manage to get the OSS es18xx module to work. But maybe I can help 
supporting the 1869 under the es18xx module. I'd be happy to do that.

greetz,
Kasper
