From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: amixer scontents fails, amixer contents succeeds
Date: Wed, 3 Feb 2010 15:00:15 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1002031459050.5886@t61.perex-int.cz>
References: <4B694857.8050606@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B2466243DC
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 15:00:23 +0100 (CET)
In-Reply-To: <4B694857.8050606@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 3 Feb 2010, Eliot Blennerhassett wrote:

> Greetings,
>
> Probably a bug in my driver (asihpi), but I don't understand how "amixer
> controls" can work while "amixer scontrols" fails.
>
> (with error code -EINVAL: "Mixer hw:1 load error: Invalid argument")
>
> Where should I start looking for why this happens?

Simple mixer is code on top of standard control API. See 
alsa-lib/src/mixer tree.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
