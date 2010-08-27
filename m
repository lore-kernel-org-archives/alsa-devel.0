From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: xine AC3 dropout problem - Please help!
Date: Fri, 27 Aug 2010 19:33:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008271926500.10278@eeebox2.perex-int.cz>
References: <AANLkTim_nj3t6FUY1Qnd=3AXkajELkAGzswOHN3ox3xE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7212310381E
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 19:33:07 +0200 (CEST)
In-Reply-To: <AANLkTim_nj3t6FUY1Qnd=3AXkajELkAGzswOHN3ox3xE@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: VDR User <user.vdr@gmail.com>
Cc: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 27 Aug 2010, VDR User wrote:

> occurs in xine.  The error I see in the xine log when the dropout
> occurs is: pcm_hw.c: snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed
> (-32).

-32 means -EPIPE - underrun has occured. It means that xine does not 
deliver samples in time to the driver for some reason. Because mplayer 
works, it does not seem like a general ALSA issue. I would ask xine 
developers for further debugging of this issue (compare the audio write 
calls with the realtime clock).

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
