From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_writei VS snd_pcm_mmap_writei
Date: Fri, 19 Nov 2010 08:09:29 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011190808080.21207@eeebox2.perex-int.cz>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE370@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F9C52454F
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2010 08:09:30 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE370@EXGMBX01.sasken.com>
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

On Fri, 19 Nov 2010, Irfan Shaikh wrote:

> Hello,
>
>         Please tell me
>         a) Difference between working of snd_pcm_mmap_writei and snd_pcm_writei ?
>         b) Performance wise which is better ?

The mmap functions does not require user space / kernel context switches.

>         When i use gettimeofday almost profile time comes almost same for both of them.

With current hw power, there are no major differences.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
