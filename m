From: Andre Schramm <andre.schramm@iosono-sound.com>
Subject: Re: [PATCH RFC 2/4] ALSA: Add RME MADI FX Kconfig
 entries
Date: Sat, 2 Feb 2013 16:16:36 +0100
Message-ID: <20130202161636.23c04179@rvllap.ps13>
References: <1359722921-18769-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1359722921-18769-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <1359722921-18769-3-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 2049F26171C
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2013 16:16:39 +0100 (CET)
In-Reply-To: <1359722921-18769-3-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri,  1 Feb 2013 13:48:39 +0100
Adrian Knoth <adi@drcomp.erfurt.thur.de> wrote:


Hi.

> 
> Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
> 
> diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
> index 947cfb4..d1fe845 100644
> --- a/sound/pci/Kconfig
> +++ b/sound/pci/Kconfig
> @@ -598,6 +598,27 @@ config SND_HDSPM
>  	  To compile this driver as a module, choose M here: the
> module will be called snd-hdspm.
>  
> +config SND_MADIFX
> +	tristate "RME Hammerfall DSP MADI FX"
> +	select SND_HWDEP
> +	select SND_RAWMIDI
> +	select SND_PCM
> +	help
> +	  Say Y here to include support for RME Hammerfall DSP MADI
> FX
> +	  soundcards.
> +
> +	  To compile this driver as a module, choose M here: the
> module
> +	  will be called snd-hdspm.
> +
Should this be "snd-madifx"? Also, the the mail on patch 4/4 seems to be
lost - can you resend it?


Cheers,
  Andre
