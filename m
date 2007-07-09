From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Unable to find an usable access for 'default'
Date: Mon, 09 Jul 2007 08:51:35 +0200
Message-ID: <1183963895.22813.1199147561@webmail.messagingengine.com>
References: <468ACB86.1040303@freescale.com>
	<1183530859.19025.1198427403@webmail.messagingengine.com>
	<468CE7AD.8020305@freescale.com>
	<1183719027.2620.1198799059@webmail.messagingengine.com>
	<468EC305.8080301@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id DDE77103841
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2007 08:51:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <468EC305.8080301@freescale.com>
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

Timur Tabi wrote:
> Clemens Ladisch wrote:
> > ALSA-lib's access type specifies whether to use mmap or not, and whether
> > the sample are interleaved or not.  (The SNDRV_PCM_INFO_*INTERLEAVED and
> > SNDRV_PCM_INFO_MMAP* flags specify the capabilities of the device.)
> 
> Is mmap support ever required?

No, but the ALSA framework does all mmap stuff for you if it knows what
type of memory you're using for the buffer, i.e., when you're using the
snd_pcm_lib_* memory management functions.

> > Look at the values in the snd_pcm_hardware structure and at the
> > constraints the driver adds manually, if there are any.
> 
> Ok, I think I fixed some issues there, but I'm still having problems.
> 
> I think part of the problem is that I'm telling ALSA that I only support
> these sample rates: 192000, 96000, 64000, 48000, 32000, and 16000.  For
> playback, I'm using alsaplayer to play an MP3.  Could it be that
> alsaplayer is picking a sample rate like 44100 and since it doesn't find
> a match, it's failing?

This is possible.  Try using aplay with a .wav file that uses a sample
format supported by the hardware.

> I thought ALSA always did sample rate conversion. 

It does when using the "default" device, but it's possible that
alsaplayer tries to use some "hw" device that does not.


HTH
Clemens
