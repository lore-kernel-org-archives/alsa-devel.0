From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH] [ALSA] mpc8610: Add mmap support
Date: Thu, 17 Jan 2008 22:00:42 +0500
Message-ID: <478F89BA.4060703@gmail.com>
References: <12005823754197-git-send-email-timur@freescale.com>	<478F8129.5030408@gmail.com>
	<478F82E9.1050809@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id E2E6D24379
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 18:01:08 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so725853fgb.44
	for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2008 09:01:08 -0800 (PST)
In-Reply-To: <478F82E9.1050809@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> Alexander E. Patrakov wrote:
>> Hm, the "struct snd_pcm_ops fsl_dma_ops" doesn't contain the .page 
>> callback. With saa7134-alsa, this led to the "device claims to support 
>> mmap but actually doesn't work" bug, see the following subthread:
> 
> Isn't that an ARM chip?  The default MMAP handler in ALSA doesn't support ARM, 
> but it works for PowerPC.

saa7134 is a Philips chip that you'll find in many TV tuners.

As for the .page logic, my question was indeed stupid. I should have read the 
snd_pcm_mmap_data_nopage() function and notice that, by default, it wants to do 
this:

vaddr = runtime->dma_area + offset;
page = virt_to_page(vaddr);

and saa7134 wants to use vmalloc_to_page() instead of virt_to_page() due to the 
way it allocates the DMA buffer.


> I haven't tried record, but I did try playback, and it worked.  Without this 
> patch, adding -M gives me this error:
> 
> aplay: set_params:852: Access type not available
> 
> After applying this patch, playback works fine.

Good!

-- 
Alexander E. Patrakov
