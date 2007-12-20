From: "John Utz" <john.utz@dmx.com>
Subject: Re: [RFC] alsa-kernel clean-ups
Date: Thu, 20 Dec 2007 12:33:49 -0800
Message-ID: <20071220123349.16bdd211@jutz-gnto64>
References: <s5hy7bp2z5v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 9290124840
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 21:34:07 +0100 (CET)
In-Reply-To: <s5hy7bp2z5v.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please Do!

On Thu, 20 Dec 2007 15:55:56 +0100
"Takashi Iwai" <tiwai@suse.de> wrote:

> Hi,
> 
> ALSA kernel tree has lots of unused and rotten codes.  I'd like to
> clean up this.  Here we go...
> 
> 1. Indirect control element access
> 
>   This is what I already suggested.  This hasn't been used (we have no
>   proper API in alsa-lib), and 32/64bit wrapper doesn't work at all.
> 
>   Also, the idea to copy such a big data area via ioctl is bad.  If we
>   need a big matrix mixer, let make each matrix element accessible
>   individually.  Copying the whole matrix at each time isn't
>   efficient.
> 
> 2. PCM xfer_align parameter
> 
>   This sw_params parameter has never been used in a sane manner, and
>   no one understands what this does exactly.  The current
>   implementation looks also buggy because it allows write of shorter
>   size than xfer_align.  So, if you do partial writes, the write isn't
>   actually aligned at all.
> 
>   Removing this parameter will make some pcm_lib_* code more readable
>   (and less buggy).
> 
> 3. PCM sleep_min and tick
> 
>   The "tick" in PCM is set (again) via sw_params.  And, nobody uses
>   this feature at all except for a command line option of aplay.
>   (This is literally "nobody", as I checked alsa-lib API calls in all
>   programs in some major distros.)
> 
>   Above all, if we need finer wake-ups for the position update, it's
>   basically an issue that the driver should solve, not tuned by each
>   application.
> 
> 4. sound/driver.h
> 
>   This header file exists only for some hacks to adapt alsa-driver
>   tree.  It's useless for building in the kernel.  Let's move a few
>   lines in it to sound/core.h and remove it.
> 
>   For building the modules on alsa-driver external tree, we can simply
>   add
>     #include "adriver.h"
>   to each build stub (alsa-driver/*/*.c) before inclusion of
>   alsa-kernel codes.
> 
> 
> I'll post some patches to clean the above thing up in the following
> posts.  Please speak up if you have objections.
> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
