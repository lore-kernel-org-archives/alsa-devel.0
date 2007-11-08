From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Any OSS changes from kernel 2.6.21 to 2.6.23?
 Something broke.
Date: Thu, 08 Nov 2007 08:34:04 +0100
Message-ID: <1194507244.16131.1220189539@webmail.messagingengine.com>
References: <472B4416.8060009@freescale.com> <s5hfxzkwyvo.wl%tiwai@suse.de>
	<47325517.2000407@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0F8DE247D6
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 08:34:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47325517.2000407@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> It turns out that ALSA (when using mplayer to play a divx video file via OSS 
> emulation) is rapidly sending back-to-back SNDRV_PCM_TRIGGER_STOP and 
> SNDRV_PCM_TRIGGER_START commands.  Why would it do that?

To recover from underruns.

There shouldn't be any difference, but maybe the buffer size of the
driver has changed.  Could you show the output of mplayer with the "-v"
option for both kernels?


Regards,
Clemens
