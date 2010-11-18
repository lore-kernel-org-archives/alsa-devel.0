From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_mmap_writei
Date: Thu, 18 Nov 2010 08:43:21 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011180842561.21207@eeebox2.perex-int.cz>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE356@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D3871038B1
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 08:43:22 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE356@EXGMBX01.sasken.com>
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

On Thu, 18 Nov 2010, Irfan Shaikh wrote:

> Hello All,
>
> Replacing  snd_pcm_writei with snd_pcm__mmap_writei gives SEGFAULT in My code.
> Works fine with pcm.c. Can ANyone help me on FINDING OUT WHAT MAY BE CAUSE OF SEGFAULT ?
> Is any thing specific required for MMAP Write ????

Set SND_PCM_ACCESS_MMAP_INTERLEAVED instead SND_PCM_ACCESS_RW_INTERLEAVED.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
