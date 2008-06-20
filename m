From: Felix Radensky <felix@embedded-sol.com>
Subject: Problems compiling Davinci ASoC driver in 2.6.26-rc6
Date: Fri, 20 Jun 2008 09:34:28 +0300
Message-ID: <485B4F74.4020506@embedded-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 685AE24539
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jun 2008 08:35:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, vova.barinov@gmail.com, vbarinov@ru.mvista.com
List-Id: alsa-devel@alsa-project.org

Hi,

I wanted to test Davinci ASoC driver on Davinci EVM evaluation
board, but encountered the following compilation errors:

 CC      sound/soc/codecs/tlv320aic3x.o
sound/soc/codecs/tlv320aic3x.c:1012: warning: 'aic3x_init' defined but 
not used
  LD      sound/soc/codecs/snd-soc-tlv320aic3x.o
  LD      sound/soc/codecs/built-in.o
  CC      sound/soc/davinci/davinci-i2s.o
sound/soc/davinci/davinci-i2s.c:402: warning: initialization from 
incompatible pointer type
  CC      sound/soc/davinci/davinci-pcm.o
sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_enqueue_dma':
sound/soc/davinci/davinci-pcm.c:99: error: implicit declaration of 
function `davinci_set_dma_src_params'
sound/soc/davinci/davinci-pcm.c:99: error: `INCR' undeclared (first use 
in this function)
sound/soc/davinci/davinci-pcm.c:99: error: (Each undeclared identifier 
is reported only once
sound/soc/davinci/davinci-pcm.c:99: error: for each function it appears in.)
sound/soc/davinci/davinci-pcm.c:99: error: `W8BIT' undeclared (first use 
in this function)
sound/soc/davinci/davinci-pcm.c:100: error: implicit declaration of 
function `davinci_set_dma_dest_params'
sound/soc/davinci/davinci-pcm.c:101: error: implicit declaration of 
function `davinci_set_dma_src_index'
sound/soc/davinci/davinci-pcm.c:102: error: implicit declaration of 
function `davinci_set_dma_dest_index'
sound/soc/davinci/davinci-pcm.c:103: error: implicit declaration of 
function `davinci_set_dma_transfer_params'
sound/soc/davinci/davinci-pcm.c:103: error: `ASYNC' undeclared (first 
use in this function)
sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_dma_irq':
sound/soc/davinci/davinci-pcm.c:117: error: `DMA_COMPLETE' undeclared 
(first use in this function)
sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_dma_request':
sound/soc/davinci/davinci-pcm.c:134: error: `TCC_ANY' undeclared (first 
use in this function)
sound/soc/davinci/davinci-pcm.c:143: error: implicit declaration of 
function `davinci_request_dma'
sound/soc/davinci/davinci-pcm.c:145: error: `EVENTQ_0' undeclared (first 
use in this function)
sound/soc/davinci/davinci-pcm.c:150: error: `PARAM_ANY' undeclared 
(first use in this function)
sound/soc/davinci/davinci-pcm.c:153: error: implicit declaration of 
function `davinci_free_dma'
sound/soc/davinci/davinci-pcm.c:158: error: implicit declaration of 
function `davinci_dma_link_lch'
sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_trigger':
sound/soc/davinci/davinci-pcm.c:174: error: implicit declaration of 
function `davinci_start_dma'
sound/soc/davinci/davinci-pcm.c:179: error: implicit declaration of 
function `davinci_stop_dma'
sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_prepare':
sound/soc/davinci/davinci-pcm.c:194: error: storage size of 'temp' isn't 
known
sound/soc/davinci/davinci-pcm.c:200: error: implicit declaration of 
function `davinci_get_dma_params'
sound/soc/davinci/davinci-pcm.c:201: error: implicit declaration of 
function `davinci_set_dma_params'
sound/soc/davinci/davinci-pcm.c:194: warning: unused variable `temp'
sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_pointer':
sound/soc/davinci/davinci-pcm.c:217: error: implicit declaration of 
function `davinci_dma_getposition'
sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_close':
sound/soc/davinci/davinci-pcm.c:262: error: implicit declaration of 
function `davinci_dma_unlink_lch'
make[3]: *** [sound/soc/davinci/davinci-pcm.o] Error 1
make[2]: *** [sound/soc/davinci] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Are there plans to fix this before release of 2.6.26 ?

Thanks.

Felix.
