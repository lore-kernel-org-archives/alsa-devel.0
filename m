From: Timur Tabi <timur@freescale.com>
Subject: Re: Unable to find an usable access for 'default'
Date: Fri, 06 Jul 2007 17:32:37 -0500
Message-ID: <468EC305.8080301@freescale.com>
References: <468ACB86.1040303@freescale.com>
	<1183530859.19025.1198427403@webmail.messagingengine.com>
	<468CE7AD.8020305@freescale.com>
	<1183719027.2620.1198799059@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 39959103905
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Jul 2007 00:32:43 +0200 (CEST)
In-Reply-To: <1183719027.2620.1198799059@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

> ALSA-lib's access type specifies whether to use mmap or not, and whether
> the sample are interleaved or not.  (The SNDRV_PCM_INFO_*INTERLEAVED and
> SNDRV_PCM_INFO_MMAP* flags specify the capabilities of the device.)

Is mmap support ever required?  I don't have that support turned on in my PCM driver, so 
could that cause some ALSA applications to fail to match?

> Look at the values in the snd_pcm_hardware structure and at the
> constraints the driver adds manually, if there are any.

Ok, I think I fixed some issues there, but I'm still having problems.

I think part of the problem is that I'm telling ALSA that I only support these sample 
rates: 192000, 96000, 64000, 48000, 32000, and 16000.  For playback, I'm using alsaplayer 
to play an MP3.  Could it be that alsaplayer is picking a sample rate like 44100 and since 
it doesn't find a match, it's failing?  I thought ALSA always did sample rate conversion. 
  Is that not true?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
