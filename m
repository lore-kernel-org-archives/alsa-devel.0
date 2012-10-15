From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] Fix for conflict of HDMI and SPDIF IEC958
 controls
Date: Mon, 15 Oct 2012 12:21:18 +0200
Message-ID: <507BE39E.5070306@perex.cz>
References: <s5hpq4nk9b1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CF65264EFF
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2012 12:21:19 +0200 (CEST)
In-Reply-To: <s5hpq4nk9b1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Date 12.10.2012 17:18, Takashi Iwai wrote:
> Hi,
> 
> there is a long-standing problem in HD-audio regarding IEC958
> controls.  When both an SPDIF and an HDMI are created on the same
> card (e.g. one from analog codec and one from graphics chip), the
> driver assigns the IEC958 controls just with new indices, 0, 1, 2...
> 
> The problem is that there is no way to connect between this index and
> the actual PCM device.  Currently, alsa-lib HDA-Intel.conf has a fixed
> configuration:
>   spdif  -> IEC958 xxx index=0, PCM dev=1
>   hdmi,0 -> IEC958 xxx index=0, PCM dev=3
>   hdmi,1 -> IEC958 xxx index=1, PCM dev=7
>   hdmi,2 -> IEC958 xxx index=2, PCM dev=8
>   hdmi,3 -> IEC958 xxx index=3, PCM dev=9
> 
> So obviously spdif and the first hdmi conflict.
> 
> Basically this can be fixed by reassigning each IEC958 control with
> the same device number corresponding to the PCM device.  That is, for
> SPDIF, assign a control element with device=1, for HDMI,
> device=3,7...
> However, this obviously breaks the old configuration unless user
> upgrades the alsa-lib configuration.  Thus this is no-go.
> 
> Now here is a compromise: the IEC958 control for SPDIF is reassigned
> to device=1 *only* when SPDIF and HDMI coexist.  Since the
> configuration is anyway broken as is now in such a case, it's no big
> deal to fix one side in an incompatible way.  (The reason why SPDIF
> is re-assigned is that I guess majority of user require more HDMI than
> SPDIF in such a configuration.)
> 
> In addition, we need a fix in alsa-lib.  Also not for breaking the
> compatibility with older kernel, we need some fallback check.  I did a
> quick hack to alsa-lib conf code and added "skip_rest" option to the
> hook element, so that only the first matching element is taken.
> 
> Long story short, I cooked up three patches.  One patch is for kernel,
> to add the workaround above, and the two are for alsa-lib, one clean
> up and one to introduce the skip_rest option (and application to
> HDA-Intel.conf).
> 
> My plan is to merge this to 3.8 tree, so it's no urgent issue.
> But it's of course always good to fix something.

What about to introduce more cleaner solution - export this information
using TLV to user space, so alsa-lib can enumerate (distinguish) the
spdif and hdmi devices properly.

						Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
