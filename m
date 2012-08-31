From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 1/3] ALSA: pcm - introduce device_buffer
Date: Fri, 31 Aug 2012 12:48:53 +0200
Message-ID: <50409695.1060904@perex.cz>
References: <1346375684-4145-1-git-send-email-vinod.koul@linux.intel.com>
 <1346375684-4145-2-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id DDA8A265DFD
 for <alsa-devel@alsa-project.org>; Fri, 31 Aug 2012 12:48:53 +0200 (CEST)
In-Reply-To: <1346375684-4145-2-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Date 31.8.2012 03:14, Vinod Koul wrote:
> -		if (avail >= runtime->stop_threshold) {
> +		snd_pcm_uframes_t actual_avail;
> +		if (avail < runtime->device_buffer)
> +			actual_avail = avail;
> +		else
> +			actual_avail = avail - runtime->device_buffer;
> +		if (actual_avail  >= runtime->stop_threshold) {

Perhaps this may be simplified to:
	if (avail >= runtime->stop_threshold + runtime->device_buffer)

> +			snd_printd(KERN_ERR  "avail > stop_threshold!!\n");
> +			snd_printd(KERN_ERR  "actual_avail %ld, avail %ld, device_buffer %ld!!\n",
> +					actual_avail, avail,  runtime->device_buffer);

I would propose to enhance xrun_log() to show something about
device_buffer and remove these printd calls from this location.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
