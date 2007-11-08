From: Timur Tabi <timur@freescale.com>
Subject: Re: Any OSS changes from kernel 2.6.21 to
 2.6.23?	Something broke.
Date: Wed, 07 Nov 2007 18:15:19 -0600
Message-ID: <47325517.2000407@freescale.com>
References: <472B4416.8060009@freescale.com> <s5hfxzkwyvo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id B3F23246E6
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 01:19:13 +0100 (CET)
In-Reply-To: <s5hfxzkwyvo.wl%tiwai@suse.de>
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

Takashi Iwai wrote:

> There is no relevant change regarding OSS-emulation code in kernel
> between 2.6.21 and 2.6.23.

It turns out that ALSA (when using mplayer to play a divx video file via OSS 
emulation) is rapidly sending back-to-back SNDRV_PCM_TRIGGER_STOP and 
SNDRV_PCM_TRIGGER_START commands.  Why would it do that?

-- 
Timur Tabi
Linux kernel developer at Freescale
