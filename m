From: =?UTF-8?B?SWdvciBLb3RyYXNpxYRza2k=?= <ikk_pl@yahoo.co.uk>
Subject: OSS virtual driver - dma buffer size problems
Date: Tue, 28 Jan 2014 14:47:41 +0100
Message-ID: <52E7B4FD.5060100@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm8-vm1.bullet.mail.ir2.yahoo.com
 (nm8-vm1.bullet.mail.ir2.yahoo.com [212.82.96.135])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E457264F19
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 14:47:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I'm trying to get the "cuckoo" OSS module (virtual ALSA driver) to work, 
and have some trouble properly setting up the dma buffer size. Relevant 
code (old type names are properly typedeffed from new ones) is:

static snd_pcm_hardware_t snd_cuckoo_playback = {
   .info = (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
            SNDRV_PCM_INFO_BLOCK_TRANSFER |
            SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_SYNC_START),
   .channels_min = 1,
   .channels_max = 2,
   .buffer_bytes_max = (64 * 1024),
   .period_bytes_min = 64,
   .period_bytes_max = (32 * 1024),
   .periods_min = 2,
   .periods_max = 1024,
   (...)
};


static snd_pcm_ops_t snd_cuckoo_playback_ops = {
   .open = snd_cuckoo_playback_open,
   .hw_params = snd_cuckoo_playback_hw_params,
   .prepare = snd_cuckoo_playback_prepare,
   (...)
};

static int
snd_cuckoo_playback_hw_params (snd_pcm_substream_t * substream,
                                snd_pcm_hw_params_t * hw_params)
{
   cuckoo_t *chip = snd_pcm_substream_chip (substream);
   snd_pcm_runtime_t *runtime = substream->runtime;
   dmap_t *dmap; //relevant buffer data here
   snd_dma_buffer_t *dmab;

   (...)

   if (runtime->dma_buffer_p)
     dmab = runtime->dma_buffer_p;
   else
     dmab = &(substream->dma_buffer);

   dmab->area = dmap->dmabuf;
   dmab->addr = dmap->dmabuf_phys;
   dmab->bytes = dmap -> buffsize; //supposed to be 4096
   snd_pcm_set_runtime_buffer(substream, dmab);
   memset (dmap->dmabuf, 0, dmap->buffsize);
   return 0;
}

Inspecting values in snd_cuckoo_playback_prepare shows that 
runtime->dma_bytes is correctly set to 4096, but runtime->buffer_size is 
16384 (with frame_bits == 32) and snd_pcm_lib_buffer_bytes(substream) 
returns 65536. If not aborted, it indeed overwrites the kernel. What is 
the correct way to pass a manually initialized dma buffer?
