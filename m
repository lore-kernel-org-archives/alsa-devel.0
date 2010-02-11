From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: IEC958 / SPDIF raw capture
Date: Thu, 11 Feb 2010 08:36:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002110833580.19278@eeebox2.perex-int.cz>
References: <325dd9ac1002101514u73929570l51a12d28ecddd7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 63C01103831
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 08:36:50 +0100 (CET)
In-Reply-To: <325dd9ac1002101514u73929570l51a12d28ecddd7b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Donald Tournier <d.tournier@brain.org.au>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Feb 2010, Donald Tournier wrote:

> Hi,
>
> We have an application in our institute that will require recording of
> a digital signal via an optical cable. We have to be able to guarantee
> perfect bitwise reproduction of the signal (the odd bit error is not a
> problem). We're thinking of using SPDIF and ALSA to capture the signal
> (obviously we'll have to make sure the signal is properly encoded to
> begin with).
>
> However, after some initial attempts, it's becoming clear that ALSA
> can't necessarily guarantee bitwise perfect capture. ALSA might change
> the format, or resample the signal after capture (although I've heard
> that can be turned off with "snd_pcm_hw_params_set_rate_resample
> (capture_handle, hw_params, 0)"). Also, the card that we've been
> playing with so far (SB Audigy2 ZS) apparently performs some low-pass
> digital filtering on the input stream anyway, and is therefore no use
> to us.

Getting raw S/PDIF stream for EMU chips is not so easy. They operates 
internally at 48kHz and everything is resampled to this frequency.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
