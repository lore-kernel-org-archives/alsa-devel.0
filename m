From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC PATCH 3/4] ALSA: core: add report of max dma
 burst
Date: Fri, 10 Jul 2015 19:13:45 +0200
Message-ID: <559FFD49.6090104@metafoo.de>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-4-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hio9uhg16.wl-tiwai@suse.de> <559D61EA.7030308@linux.intel.com>
 <CAN8cciYf_oz+ozAesHu5j_V0=iDSuFrLM5E2i6f+CbaXqWX9uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-145.synserver.de
 [212.40.185.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 53376266606
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 19:13:50 +0200 (CEST)
In-Reply-To: <CAN8cciYf_oz+ozAesHu5j_V0=iDSuFrLM5E2i6f+CbaXqWX9uQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07/10/2015 04:35 AM, Raymond Yau wrote:
[...]
> What is the usage of runtime->dma_bytes in
> snd_pcm_hw_constraints_complete() in core/pcm_native.c ?
>
> Was the usage similar to 128 bytes alignment ?
>
> /* FIXME: remove */
> if (runtime->dma_bytes) {
> err = snd_pcm_hw_constraint_minmax(runtime,
> SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 0, runtime->dma_bytes);
> if (err < 0)
> return err;
> }

The FIXME is probably correct. dma_bytes should always be 0 at that point. 
This is a freshly allocated runtime struct and dma_bytes only gets set once 
a buffer is allocated, which is done later on.

- Lars
