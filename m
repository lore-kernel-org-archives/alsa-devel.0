From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer
	support
Date: Fri, 18 Jan 2019 10:35:44 +0100
Message-ID: <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 32DC5266A89
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 10:36:11 +0100 (CET)
In-Reply-To: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Baolin Wang <baolin.wang@linaro.org>, tiwai@suse.com, broonie@kernel.org, leo.yan@linaro.org
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, gustavo@embeddedor.com, srinivas.kandagatla@linaro.org, mchehab+samsung@kernel.org, sr@denx.de, daniel.thompson@linaro.org, corbet@lwn.net, philburk@google.com, willy@infradead.org, jmiller@neverware.com, keescook@chromium.org, arnd@arndb.de, colyli@suse.de, ckeepax@opensource.wolfsonmicro.com, anna-maria@linutronix.de, mathieu.poirier@linaro.org, sboyd@kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, joe@perches.com
List-Id: alsa-devel@alsa-project.org

Dne 18.1.2019 v 05:55 Baolin Wang napsal(a):
> This patch adds dma share buffer support, which allows a dma-buf to be shared
> between processes by passing file descriptors between them, allowing multiple
> processes to cooperate in filling the DMA buffer used by the audio hardware
> without the need to copy data around. This reduces both latency and CPU load,
> especially in configurations where only one application is playing audio and
> so context switches can be avoided.
> 
> In userspace, we can use ioctl:SNDRV_PCM_IOCTL_DMABUF_EXPORT to export one
> dma buffer to a PCM, and use ioctl:SNDRV_PCM_IOCTL_DMABUF_ATTACH and
> ioctl:SNDRV_PCM_IOCTL_DMABUF_DETACH to attach or detach one device to the
> dma buffer. Morevoer we can use dma buffer ioctl:DMA_BUF_IOCTL_SYNC to
> guarantee the cache coherency of the DMA buffer.
> 
> You can refer to below patches [1] created by Leo Yan to use the dma buffer
> in userspace.
> 
> [1] https://github.com/tinyalsa/tinyalsa/pull/126
> 
> Welcome any comments. Thanks.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Hi,
> 
> Before sending to ALSA mailing list, we had some internal discussion off line,
> so I posted them to follow up.
> 
> 1. One issue proposed by Srinivas Kandagatla, he proposed one use case example:
> DSP1 pre-process(compress-to-pcm) the buffers, pass the fd to DSP2/audio-ip
> to play pcm data. The dmabuf exporter (DSP1) is a different device than
> audio device in this instance, so the DSP1 device cannot call
> snd_pcm_dmabuf_export() to export one dma buffer and pass to the DSP2/audio-ip.
> 
> Our original design is, the dma buffer should be associated with one PCM
> device, since different PCM devices may need different buffer types (see
> SNDRV_DMA_TYPE_XXX) to play PCM data, and need consider the PCM device's
> coherent capability for DMA memory. My concern is, if we let other
> non-audio device to allocate one buffer and export it, how to guarantee
> the dma buffer can be used by PCM device and have the same coherent capability
> with the PCM device.
> 
> So I am not sure for this issue and need more suggestion to get a consensus.
> 
> 2. Second question raised by Srinivas Kandagatla, he wondered:
> "Am still unclear on the whole idea making a audio device dmabuf exporter
> in Linux systems, unless you are sharing the dmabuf fd with other devices.
> 
> If you are working with just one device we could just live with mmap,
> isn't it?"
> 
> Mark Brown gave the answer:
> "The issue is permissions management. We've got a sound server that owns
> all the sound hardware and needs to be able to retain administrative control
> over it which means that permissions for the sound devices are locked down to
> it. For performance reasons on systems where it's practical (eg, where there's
> multiple audio streams the system can use to play data to the hardware) we
> want to be able to have that server allow other applications with lower
> permissions to stream data to/from the hardware without going through it. The
> applications can't mmap() the device directly as that's too painful to do that
> securely from a permission management point of view so we want to be able to
> have the sound server do the mmap() then hand the mapped buffer off to the
> application for it to use via a FD over a pipe. That way the only thing with
> direct access to the devices is the sound server but the clients have a data
> path that doesn't need to bounce through another process.
> 
> Practically speaking the only use case I can think of in an audio context is
> for one reader and one writer (AIUI Android is envisioning this as one hardware
> and one software), it's difficult to see how you could usefully chain multiple
> in place transformations together in the way that you can with video applications
> but I'm possibly not thinking of something here."

Hi,

  the tinyalsa implementation does not show much - it's equal to the
standard mmap access for the PCM devices. Even considering the Mark's
text, there must be an arbiter (sound server) which communicates with
the producer or consumer to control the data flow. I really would like
to see a real usage for this.

  It seems to me that the only point to implement this is the
permissions. We already have O_APPEND mode for the PCM file descriptor
which can reuse the PCM device multiple times (mmap the buffer to
multiple tasks). I would probably go in this way and add more extended
permission control for the PCM device, so permissions can be restricted
for the passed descriptor to the producer or the consumer task. In this
way, the restricted task might reuse other control mechanism offered buy
the PCM file descriptor without requesting the arbiter to do so (like
read the actual position in the DMA buffer, get the audio delay or so -
reduce context switches).

					Thanks,
						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
