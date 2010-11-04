From: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Subject: Buffer memory does not get allocated?
Date: Thu, 4 Nov 2010 14:12:33 -0700
Message-ID: <AANLkTindxGLPbsk9hWWqf6U89ZnzgbNf3qt96JVQm5rT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AF44310386B
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 22:12:34 +0100 (CET)
Received: by wyb33 with SMTP id 33so412647wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 04 Nov 2010 14:12:33 -0700 (PDT)
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

I am allocating memory for the buffers in my init call by doing:
snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
snd_dma_continuous_data(GFP_KERNEL), 256*1024, 256*1024);

in my hw_params call I have:
ret= snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));

here is the output from my hw_params call:

called snd_pcm_lib_malloc_pages return=1
params_buffer_bytes(hw_params)=32768

Size of DMA area=32768

Buffer size in bytes=262144

Buffer virt address=9dc00000

Buffer phys address=0


Now I am not sure why is my buffer size bigger than my DMA area. I assume
that memory is not linear because of that and that is why I do not have phys
address to the buffer. How do I fix this?

Thanx
Ogi
