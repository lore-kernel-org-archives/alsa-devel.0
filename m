From: "Timur Tabi" <timur@freescale.com>
Subject: Re: Playing silence instead of pausing during underrun
Date: Thu, 4 Sep 2008 11:04:55 -0500
Message-ID: <ed82fe3e0809040904s610ff7e8i9e17408f30eda100@mail.gmail.com>
References: <48BFF900.50002@freescale.com>
	<Pine.LNX.4.61.0809041726320.9153@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AC5C2441A
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Sep 2008 18:04:56 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so12571wra.24
	for <alsa-devel@alsa-project.org>; Thu, 04 Sep 2008 09:04:55 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0809041726320.9153@tm8103.perex-int.cz>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 4, 2008 at 10:28 AM, Jaroslav Kysela <perex@perex.cz> wrote:

> Note that not all hardware supports pause, so just remove
> SNDRV_PCM_INFO_PAUSE and all pause related code in the trigger callback
> and let user space to do the full reinitialization.

That's not what I'm talking about.  It doesn't matter if it's paused
or stopped, when playback is paused/stopped, the hardware is disabled.
 When the hardware is re-enabled, stale data in the hardware causes a
popping sound.  Therefore, during underrun, the popping will not occur
if the hardware is never disabled, but this requires either the driver
or ALSA to pump silence data into the hardware.

-- 
Timur Tabi
Linux kernel developer at Freescale
