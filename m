From: Gabriel Johnson <johnsoga@gmail.com>
Subject: dmix and mmap
Date: Thu, 30 Apr 2009 10:10:23 -0500
Message-ID: <bb6204720904300810ma174b6cn825f8565c0b694c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F1472457A
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 17:10:25 +0200 (CEST)
Received: by gxk2 with SMTP id 2so3860061gxk.8
	for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2009 08:10:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am currently working on two issues.

First, I am trying to add mmaping support to the pcm driver I am using
so that I can use the dmix plugin.  My driver is a soc driver for the
powerpc mpc5121.  The pcm_new function preallocates the dma buffers
with the following code:

static int mpc512x_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
{
	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
	struct snd_dma_buffer *buf = &substream->dma_buffer;
	size_t size = mpc512x_pcm_hardware.buffer_bytes_max;

	buf->dev.type = SNDRV_DMA_TYPE_DEV;
	buf->dev.dev = pcm->card->dev;
	buf->private_data = NULL;
	buf->area = dma_alloc_coherent(pcm->card->dev, size,
				       &buf->addr, GFP_KERNEL);
	if (!buf->area)
		return -ENOMEM;
	buf->bytes = size;
	return 0;
}

Given the way the dma buffers are allocated if I just add
SNDRV_PCM_INFO_MMAP and SNDRV_PCM_INFO_MMAP_VALID to my
snd_pcm_hardware struct with the alsa framework use a generic mmap
function or do I still need to implement one?  If I need to implement
a mmap callback what is the fastest and most simple way to add that
support?

Second, I need to test dmix with my driver.  My codec only supports
S16_BE.  When I try to use `aplay -Dplug:dmix -f SE16_BE mywave.raw` I
get the error `requested or auto-format is not available`.  After
looking in pcm_direct.c it appears that when I use -Dplug:dmx it
ignores -f S16_BE and is defaulting to some format that my codec
doesn't support.  I don't have a /etc/alsa.conf or ~/.asoundrc file
and /proc/asound/modules doesn't exists.  Where is aplay getting the
default setting for plug:dmix?  How can I override those defaults?

I am using alsa-lib-1.0.11rc2.

Thanks,
Gabe
