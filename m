From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question about snd_pcm_update_hw_ptr_post()
Date: Tue, 04 Mar 2008 08:27:32 +0100
Message-ID: <47CCF9E4.60601@ladisch.de>
References: <47CC62C5.5010308@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 6D7AE103828
	for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2008 08:26:00 +0100 (CET)
In-Reply-To: <47CC62C5.5010308@freescale.com>
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
> During playback, avail = snd_pcm_playback_avail().  Does this mean that avail is
> number of frames available in the playback DMA buffer for new data?

Yes, it's the number of free frames that the application can write.

> If so, why is avail >= runtime->stop_threshold considered an underrun condition?

When too many frames in the buffer are free, there are not enough frames
available for the hardware to play.

The default value of the stop threshold is the size of the buffer, so an
underrun happens when the buffer has been completely emptied.

> how can I adjust runtime->stop_threshold?

snd_pcm_sw_params_current()
snd_pcm_sw_params_set_stop_threshold()
snd_pcm_sw_params()


HTH
Clemens
