From: Timur Tabi <timur@freescale.com>
Subject: Re: SNDRV_PCM_INFO_MMAP - what do I need for it?
Date: Wed, 16 Jan 2008 13:40:07 -0600
Message-ID: <478E5D97.3000707@freescale.com>
References: <478E2025.8010509@freescale.com> <s5hy7apr7s0.wl%tiwai@suse.de>
	<478E5598.9060306@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 972DF24567
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 20:40:20 +0100 (CET)
In-Reply-To: <478E5598.9060306@freescale.com>
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

Timur Tabi wrote:

> How can I know whether this function works?  Can I just add those two flags to 
> my .info line, and then .... ?  Is there an ALSA mmap test utility?

Ok, I think aplay can do this.

I ran this command:

aplay -Dhw:0,0 -f S16_BE -M -r 48000 -c 2 15.raw

and I got this error:

aplay: set_params:852: Access type not available

so I modified my .info line and added those two macros.  When I run "aplay -M", 
it plays the file fine.

Does this mean that my one-line change has added mmap support to my driver, and 
dmix should now work?

-- 
Timur Tabi
Linux kernel developer at Freescale
