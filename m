From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: PulseAudio and softvol
Date: Wed, 15 May 2013 18:31:18 +0530
Message-ID: <1368622878.6590.28.camel@localhost>
References: <1368611744.6590.8.camel@localhost> <519362EB.7050603@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id D426026520C
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 15:01:18 +0200 (CEST)
In-Reply-To: <519362EB.7050603@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2013-05-15 at 12:26 +0200, Jaroslav Kysela wrote:
> Date 15.5.2013 11:55, Arun Raghavan wrote:
> > Hello,
> > A number of users have intermittently(?) been hitting a crash in
> > alsa-lib 1.0.27 [1, 2] related to the softvol plugin. I'm not able to
> > reproduce this reliably, so can't find an easy way to debug/fix.
> 
> The problem is that the offsets are not in sync in this case [1]:
> 
> src_offset = 38560
> dst_offset = 38568
> frames = 16374
> 
> Could you reproduce this bug in any way? At least snd_pcm_dump() before
> the failing snd_pcm_mmap_commit() call might help to determine what was
> the status before the assert() was entered.

Unfortunately, after the time I got the backtrace, I haven't been able
to reproduce the problem.

-- Arun
