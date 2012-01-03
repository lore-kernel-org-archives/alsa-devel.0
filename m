From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Join play of pcm in multiple playback devices
Date: Tue, 03 Jan 2012 15:32:23 -0600
Message-ID: <4F0373E7.2060807@linux.intel.com>
References: <4F029F10.7060704@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D627103A09
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2012 22:32:25 +0100 (CET)
In-Reply-To: <4F029F10.7060704@sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> while(1)
> {
>       retval=snd_pcm_readi(pAlsaConfig->pcm_handle, buffer,
> pAlsaConfig->alsaBufferSize);
>       snd_pcm_writei(pAlsaConfig->pcm_handle1, buffer,retval);
>       snd_pcm_writei(pAlsaConfig->pcm_handle2, buffer,retval);
> }

This code doesn't work in the general case where the different devices 
don't share a common audio clock and have different physical 
capture/playback rates. Compensating for clock drift requires the use of 
asynchronous sample-rate conversion.
Assuming you have a perfectly synchronous system, you could make use of 
snd_pcm_delay() to compensate for delays incurred in the 
driver/firmware/hardware. This is not well supported by all drivers though.
-Pierre
