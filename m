From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Question about pcm_formats[] array in
	sound/core/pcm_misc.c
Date: Thu, 13 Dec 2007 09:41:01 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0712130939520.8243@tm8103.perex-int.cz>
References: <475EF3A4.70304@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 30C6624635
	for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2007 09:41:02 +0100 (CET)
In-Reply-To: <475EF3A4.70304@freescale.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Dec 2007, Timur Tabi wrote:

> I'm confused about the entries for unsigned 24-bit sound in the pcm_formats[] array:
> 
> 	[SNDRV_PCM_FORMAT_U24_BE] = {
> 		.width = 24, .phys = 32, .le = 0, .signd = 0,
> 		.silence = { 0x80, 0x00, 0x00 },
> 	},
> 
> and
> 
> 	[SNDRV_PCM_FORMAT_U24_3BE] = {
> 		.width = 24, .phys = 24, .le = 0, .signd = 0,
> 		.silence = { 0x80, 0x00, 0x00 },
> 	},
> 
> SNDRV_PCM_FORMAT_U24_BE means a 24-bit sample packed into a 32-bit word.  So I 
> presume that if the 24-bit sample is:
> 
> 0x123456
> 
> then when that sample is written to memory, it looks like this:
> 
> X	X + 1	X + 2	X + 3
> 0x00	0x12	0x34	0x56
> 
> (where X is some address in memory).
> 
> If that's so, shouldn't the entry for SNDRV_PCM_FORMAT_U24_BE look like this:
> 
> 	[SNDRV_PCM_FORMAT_U24_BE] = {
> 		.width = 24, .phys = 32, .le = 0, .signd = 0,
> 		.silence = { 0x00, 0x80, 0x00, 0x00 },
> 	},                  ^^^^^^

Good catch. It looks like a bug and your proposal seems to be correct.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
