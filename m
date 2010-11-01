From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: iec958 and 24-bit audio
Date: Mon, 1 Nov 2010 20:18:43 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011012017270.29422@eeebox2.perex-int.cz>
References: <AANLkTi=U5k+mYy-kSCn4699LwFF6J2gxYQKePSNayDth@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id B1EDF24381
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 20:18:43 +0100 (CET)
In-Reply-To: <AANLkTi=U5k+mYy-kSCn4699LwFF6J2gxYQKePSNayDth@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Nov 2010, pl bossart wrote:

> When I try playing 24-bit audio files on my SPDIF output, I get this
>
> [alsa-lib]$ aplay -Diec958 file24bits.wav
> aplay: set_params:1059: Sample format non available
> Available formats:
> - S16_LE
> - S32_LE
>
> Is there an built-in assumption that the iec958 device can only take
> as input what the slave hardware device supports?

Use 'plug:iec958' device if you want to do the format conversion (from 
24-bit to 32-bit format).

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
