From: K.Fetscher@t-online.de
Subject: New ALSA Driver
Date: Tue, 8 Mar 2005 21:46:24 +0100
Message-ID: <200503082146.24634.k.fetscher@fetron.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I wan't to program an ALSA driver for my custom ARM based Cirrus-EP9312 board.

The driver starts with the initialisation of the hardware, with 
snd_card_new(...), snd_pcm_new(...), the request for the DMA-Controller, 
programming snd_pcm_set_ops(...) and 
snd_pcm_lib_preallocate_pages_for_all(...).

After that, I can see the card in the /proc/asound/card0/... filesystem.


When I start playing a song with aplay, ALSA calls hw_params(..), prepare(..)  
and trigger(..) with command SNDRV_PCM_TRIGGER_START. After that, all stops 
until I make a CTRL C (after that, it terminates with hw_free and close). Is 
it correct, that runtime->dma_addr is 0 (runtime->size is 1000 and 
runtime->period is 400) ?


I have looked into some drivers for the parameters of 
snd_pcm_lib_preallocate_pages_for_all(...). There are different types for the 
DMA type and I don't know, which is the correct type (at the moment, I use 
SNDRV_DMA_TYPE_CONTINUOUS).

Thanks

Klaus  


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
