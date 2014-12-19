From: Tim Cussins <timcussins@eml.cc>
Subject: Re: [PATCH v2 3/3] snd_pcm_start_at: Implement
 snd_pcm_start_at for system and audio tstamp types.
Date: Fri, 19 Dec 2014 11:41:17 +0000
Message-ID: <54940EDD.8010007@eml.cc>
References: <1418837365-19398-1-git-send-email-timcussins@eml.cc>	<1418837365-19398-3-git-send-email-timcussins@eml.cc>
 <CAN8cciYLnTBreS=wf4Ax4o8r-zLJ9fYaTXeyQd-fosaXdn_nVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 686392612D6
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 12:41:21 +0100 (CET)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailout.nyi.internal (Postfix) with ESMTP id 34DE820B0D
 for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2014 06:41:19 -0500 (EST)
In-Reply-To: <CAN8cciYLnTBreS=wf4Ax4o8r-zLJ9fYaTXeyQd-fosaXdn_nVA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: nstoughton@aether.com, tiwai@suse.de, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 17/12/14 23:37, Raymond Yau wrote:
>  >
>  > System tstamp types rely on high-res timers.
>  > Audio tstamp types delegate to the pcm driver.
>  > Current start_at timer is cancelled on attempt to change stream state.
>
> http://git.alsa-project.org/?p=alsa-lib.git;a=blob_plain;f=test/timer.c;hb=HEAD
>
> Are there any difference between sound card's timer with high res
> timer/wall clock time stamp ?
>
> It seem those sound cards timer have resolution and max tick
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/ymfpci?id=6e2efaacb3579fd9643d0dc59963b58b801c03a1
>
> snd_timer_status_get_resolution
>
> The clock tick counters are 32 bits and wrap around
>
> This may mean that snd_pcm_start_at can only start within certian time
> interval
>

[and this time I'll post to the list :)]

I had presumed it would be pretty simple to use the timer-wrap interrupt 
to maintain a monotonic sense of time. Hardware that can't support this 
might not be able to support start_at.

T
