From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA buffer query
Date: Thu, 11 Nov 2010 08:18:06 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011110817390.29422@eeebox2.perex-int.cz>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE320@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id DEA7510389F
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 08:18:07 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE320@EXGMBX01.sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Irfan Shaikh <irfan.shaikh@sasken.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Nov 2010, Irfan Shaikh wrote:

> Hello All,
>
>
>      1) My understanding :  snd_pcm_writei() takes the allocated buffer 
> from applications and passes the buffer beneath to the ASLA library and 
> then to the ALSA driver for rendering Audio.
>
>      2) Query 1 : Instead of me allocating the buffer in ALSA 
> application and passing the pointer in snd_pcm_writei, Can ALSA allocate 
> the buffer and give to my application, so that i can copy my data into 
> it.
>
>      3) Query 2 : Is there any wayto diirectly get hardware ALSA buffer 
> from the ALSA driver to application so that i can copy PCM data to this 
> buffer directly.
>                          If not, is there any way can we do this ?

Read alsa-lib documentation. snd_pcm_mmap_begin/snd_pcm_mmap_commit.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
