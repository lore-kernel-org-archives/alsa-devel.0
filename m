From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: dpcm: Fix race between FE/BE updates
 and trigger
Date: Tue, 04 Nov 2014 16:20:50 +0000
Message-ID: <1415118050.7168.32.camel@loki>
References: <1415116348-11792-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B1A62260611
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 17:25:59 +0100 (CET)
In-Reply-To: <1415116348-11792-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Qiao Zhou <zhouqiao@marvell.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2014-11-04 at 16:52 +0100, Takashi Iwai wrote:
> DPCM can update the FE/BE connection states totally asynchronously
> from the FE's PCM state.  Most of FE/BE state changes are protected by
> mutex, so that they won't race, but there are still some actions that
> are uncovered.  For example, suppose to switch a BE while a FE's
> stream is running.  This would call soc_dpcm_runtime_update(), which
> sets FE's runtime_update flag, then sets up and starts BEs, and clears
> FE's runtime_update flag again.
> 
> When a device emits XRUN during this operation, the PCM core triggers
> snd_pcm_stop(XRUN).  Since the trigger action is an atomic ops, this
> isn't blocked by the mutex, thus it kicks off DPCM's trigger action.
> It eventually updates and clears FE's runtime_update flag while
> soc_dpcm_runtime_update() is running concurrently, and it results in
> confusion.
> 
> Usually, for avoiding such a race, we take a lock.  There is a PCM
> stream lock for that purpose.  However, as already mentioned, the
> trigger action is atomic, and we can't take the lock for the whole
> soc_dpcm_runtime_update() or other operations that include the lengthy
> jobs like hw_params or prepare.
> 
> This patch provides an alternative solution.  This adds a way to defer
> the conflicting trigger callback to be executed at the end of FE/BE
> state changes.  For doing it, two things are introduced:
> 
> - Each runtime_update state change of FEs is protected via PCM stream
>   lock.
> - The FE's trigger callback checks the runtime_update flag.  If it's
>   not set, the trigger action is executed there.  If set, mark the
>   pending trigger action and returns immediately.
> - At the exit of runtime_update state change, it checks whether the
>   pending trigger is present.  If yes, it executes the trigger action
>   at this point.
> 
> Reported-and-tested-by: Qiao Zhou <zhouqiao@marvell.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
