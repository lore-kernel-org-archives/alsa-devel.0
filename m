From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ICE1724 - File descriptor in bad state when
	capturing
Date: Tue, 11 Mar 2008 08:35:14 +0100
Message-ID: <47D63632.60808@ladisch.de>
References: <47D46B01.8020009@insite.cz> <s5hk5kax2dn.wl%tiwai@suse.de>
	<47D5AA82.4080009@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 08F7024422
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2008 08:33:48 +0100 (CET)
In-Reply-To: <47D5AA82.4080009@insite.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@insite.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Pavel Hofman wrote:
> Whereas for the broken analog input, the sequence is
>
> 1. snd_pcm_lib_read1 with SNDRV_PCM_STATE_PREPARED - returns 0
> 2. snd_pcm_lib_read1 with SNDRV_PCM_STATE_SETUP - returns -EBADFD

I'd guess that your trigger callback fails somehow, bit this is
hard to determine without the source code.


Regards,
Clemens
