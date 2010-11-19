From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_mmap_commit
Date: Fri, 19 Nov 2010 08:11:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011190810081.21207@eeebox2.perex-int.cz>
References: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE36E@EXGMBX01.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D2AE103938
	for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2010 08:11:04 +0100 (CET)
In-Reply-To: <16F32A3F9AF4E441B752BCD79C151ACA5D9A2EE36E@EXGMBX01.sasken.com>
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

> /*************************************************************/
> Code below O/p results runs in a while loop till end of PCM data.
> 1) First time O/p is
>          Farames available : 1024                                                /*Return VALUE of snd_pcm_avail_update*/
>          >>>>>>>>>>>>>>>>>>>>>>>>>Begin result : 0      /*Return VALUE of snd_pcm_mmap_begin*/
>          Address outbuffer : 0xcff88
>          >>>>>>>>>>>>>>>>>>>>>>Comit result : 1024       /*SUCESSFUL - Return VALUE of  snd_pcm_mmap_commi*/
>
> 2) Second time onwards ALWAYS O/p is
>          Farames available : 0                                                      /*Return VALUE of snd_pcm_avail_update*/
>          >>>>>>>>>>>>>>>>>>>>>>>>>Begin result : 0      /*Return VALUE of snd_pcm_mmap_begin*/
>          Address outbuffer : 0xcff88
>          >>>>>>>>>>>>>>>>>>>>>>Comit result : 0             /*FAILURE - Return VALUE of  snd_pcm_mmap_commit*/

You have to use poll()/select() or snd_pcm_wait() to wait for a room in 
the playback buffer. The direct mmap I/O is always non-blocked.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
