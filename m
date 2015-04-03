From: Hui Wang <hui.wang@canonical.com>
Subject: Re: linux-next - strange audio bug
Date: Fri, 03 Apr 2015 08:44:12 +0800
Message-ID: <551DE25C.6020201@canonical.com>
References: <57781.1428021275@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A904265777
 for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2015 02:44:22 +0200 (CEST)
In-Reply-To: <57781.1428021275@turing-police.cc.vt.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 04/03/2015 08:34 AM, Valdis Kletnieks wrote:
> Next-20150310 works OK, next-20150324 has the bug.
>
> Dell Latitude E6530 laptop, lspci tells me:
>
> 01:00.1 Audio device: NVIDIA Corporation GF108 High Definition Audio Controller (rev a1)
>          Subsystem: Dell Device 0535
>          ...
>          Kernel driver in use: snd_hda_intel
>
> Symptoms:  Audio works perfectly at boot, and for some amount
> of time after.  But somewhere around 6-8 hours of uptime, it gets
> into a strange state where I'll get no audio... and then it will
It sounds like the suspend or resume of power management introduces this 
problem. Probably you could reproduce this problem very soon just 
repeatedly suspend and resume the system.
> cut in for all of 2 seconds or so (fairly consistent, that part),
> and then cut back out for anywhere from 10 seconds to a minute,
> then another 2 seconds of sound.. lather rinse repeat.
>
> Before I start the thankless task of bisecting this (which means I'll
> be able to do only 1, *maybe* 2 steps a day), does this ring any bells?
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
