From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Build regressions/improvements in v3.0-rc7
	(sound/isa/)
Date: Sun, 24 Jul 2011 12:26:24 -0700
Message-ID: <20110724122624.324d10dc.rdunlap@xenotime.net>
References: <1310585610-434-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy4-pub.bluehost.com (oproxy4-pub.bluehost.com
	[69.89.21.11]) by alsa0.perex.cz (Postfix) with SMTP id A2D512448E
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Jul 2011 21:26:28 +0200 (CEST)
In-Reply-To: <1310585610-434-1-git-send-email-geert@linux-m68k.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 13 Jul 2011 21:33:30 +0200 Geert Uytterhoeven wrote:

>   + src/sound/isa/ad1816a/ad1816a_lib.c: error: implicit declaration of function 'snd_dma_disable':  => 544
>   + src/sound/isa/ad1816a/ad1816a_lib.c: error: implicit declaration of function 'snd_dma_pointer':  => 302
>   + src/sound/isa/ad1816a/ad1816a_lib.c: error: implicit declaration of function 'snd_dma_program':  => 244
>   + src/sound/isa/es1688/es1688_lib.c: error: implicit declaration of function 'snd_dma_pointer':  => 509
>   + src/sound/isa/es1688/es1688_lib.c: error: implicit declaration of function 'snd_dma_program':  => 417
>   + src/sound/isa/gus/gus_dma.c: error: implicit declaration of function 'snd_dma_disable':  => 177
>   + src/sound/isa/gus/gus_dma.c: error: implicit declaration of function 'snd_dma_program':  => 79
>   + src/sound/isa/gus/gus_pcm.c: error: implicit declaration of function 'snd_dma_pointer':  => 619
>   + src/sound/isa/gus/gus_pcm.c: error: implicit declaration of function 'snd_dma_program':  => 591
>   + src/sound/isa/sb/sb16_main.c: error: implicit declaration of function 'snd_dma_pointer':  => 456
>   + src/sound/isa/sb/sb16_main.c: error: implicit declaration of function 'snd_dma_program':  => 276
>   + src/sound/isa/sb/sb8_main.c: error: implicit declaration of function 'snd_dma_pointer':  => 425
>   + src/sound/isa/sb/sb8_main.c: error: implicit declaration of function 'snd_dma_program':  => 172
>   + src/sound/isa/sscape.c: error: implicit declaration of function 'snd_dma_program':  => 481
>   + src/sound/isa/wss/wss_lib.c: error: implicit declaration of function 'snd_dma_disable':  => 1695
>   + src/sound/isa/wss/wss_lib.c: error: implicit declaration of function 'snd_dma_pointer':  => 1160
>   + src/sound/isa/wss/wss_lib.c: error: implicit declaration of function 'snd_dma_program':  => 1025

All of these source files do #include <sound/core.h>,
but these missing/implicit functions are conditional:

#ifdef CONFIG_ISA_DMA_API
#define DMA_MODE_NO_ENABLE	0x0100

void snd_dma_program(unsigned long dma, unsigned long addr, unsigned int size, unsigned short mode);
void snd_dma_disable(unsigned long dma);
unsigned int snd_dma_pointer(unsigned long dma, unsigned int size);
#endif

so should these drivers all depend on ISA_DMA_API ?
or should only pieces of each driver depend on ISA_DMA_API ?


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
