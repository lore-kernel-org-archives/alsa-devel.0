From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Buffer memory does not get allocated?
Date: Fri, 05 Nov 2010 09:23:05 +0100
Message-ID: <4CD3BEE9.6070808@ladisch.de>
References: <AANLkTindxGLPbsk9hWWqf6U89ZnzgbNf3qt96JVQm5rT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id BB19E103934
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 09:21:16 +0100 (CET)
In-Reply-To: <AANLkTindxGLPbsk9hWWqf6U89ZnzgbNf3qt96JVQm5rT@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Radivoje Jovanovic wrote:
> I am allocating memory for the buffers in my init call by doing:
> snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
> snd_dma_continuous_data(GFP_KERNEL), 256*1024, 256*1024);
> 
> in my hw_params call I have:
> ret= snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
> 
> here is the output from my hw_params call:
> 
> called snd_pcm_lib_malloc_pages return=1
> params_buffer_bytes(hw_params)=32768
> Size of DMA area=32768
> Buffer size in bytes=262144
> Buffer virt address=9dc00000
> Buffer phys address=0
> 
> Now I am not sure why is my buffer size bigger than my DMA area.

You did not say which values are output, but 262144 is 256*1024, so this
is the preallocated buffer.  The DMA is what is actually used with the
current hw_params.

> I assume that memory is not linear because of that

SNDRV_DMA_TYPE_CONTINUOUS gives you continguous pages.

> and that is why I do not have phys address to the buffer.

It doesn't give you the physical address; it looks as if this memory is
intended to be accessed only by the CPU.

To get coherent memory with a DMA address for a specific device, use
SNDRV_DMA_TYPE_DEV.  (This must be supported by your architecture.)


Regards,
Clemens
