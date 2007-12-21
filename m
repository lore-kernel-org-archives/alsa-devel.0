From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] alsa-kernel clean-ups
Date: Fri, 21 Dec 2007 20:30:03 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0712212026080.8567@tm8103.perex-int.cz>
References: <s5hy7bp2z5v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F2281038B9
	for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2007 20:30:04 +0100 (CET)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Dec 2007, Takashi Iwai wrote:

> Hi,
> 
> ALSA kernel tree has lots of unused and rotten codes.  I'd like to
> clean up this.  Here we go...
> 
> 1. Indirect control element access
> 2. PCM xfer_align parameter
> 3. PCM sleep_min and tick
> 4. sound/driver.h
> 
> I'll post some patches to clean the above thing up in the following
> posts.  Please speak up if you have objections.

Please wait to first week in 2008. I'll review your patches. But 
preliminary, I agree. If code is not used, it's better to remove it.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
