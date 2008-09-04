From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Playing silence instead of pausing during underrun
Date: Thu, 4 Sep 2008 17:28:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0809041726320.9153@tm8103.perex-int.cz>
References: <48BFF900.50002@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E38B24142
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 17:28:39 +0200 (CEST)
In-Reply-To: <48BFF900.50002@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 4 Sep 2008, Timur Tabi wrote:

> If I understand it correctly, when ALSA detects an underrun during 
> playback, it throttles the driver by sending pause and resume commands.
> 
> It turns out that our hardware doesn't really like this.  We're looking 
> at various solutions, but one proposal would be to keep the hardware 
> running during a pause, but just have it play silence instead.  That is, 
> ALSA keeps feeding silence data during an underrun recovery.
> 
> Is there an easy way to do this in ALSA?  Is there another driver that 
> does this?

Note that not all hardware supports pause, so just remove 
SNDRV_PCM_INFO_PAUSE and all pause related code in the trigger callback 
and let user space to do the full reinitialization.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
