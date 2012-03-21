From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
 protection mode
Date: Wed, 21 Mar 2012 10:13:32 +0200
Message-ID: <4F698DAC.7060503@bitmer.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<4F68AE51.808@bitmer.com>
	<CANOLnOMqK5-yWoEA=1x2a4-OQYy8xvBUwY_RVdqHeaz4TxL3eQ@mail.gmail.com>
	<4F68D898.5080606@bitmer.com>
	<CA+7tXigvqY19SPCajY2awV9rJRkTh33H8cO+FZ+Un0uK1f9voA@mail.gmail.com>
	<4F698A02.1070306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id C8880244ED
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 09:13:35 +0100 (CET)
In-Reply-To: <4F698A02.1070306@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, Trent Piepho <tpiepho@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 03/21/2012 09:57 AM, Peter Ujfalusi wrote:
> On 03/20/2012 09:47 PM, Trent Piepho wrote:
>>> To me this looks more like a correct fix. At quick test I got single
>>> xrun when starting up but not endless loop of them. Maybe need to tune a
>>> bit with CONFIG_SND_PCM_XRUN_DEBUG=y.
>>
>> Does the ALSA API allow the driver to change start_threshold in the
>> prepare function?  It seems what is needed is a minimum
>> start_threshold constraint, but there aren't constaints for sw_params.
> 
> I did as well looked at the start_threshold, and came to the same
> conclusion. It is sw_param, and the driver should not modify it.
> The OSS emulation layer sets the start_threshold to 1, most application
> sets the start threshold to the size of the buffer. Some legacy
> application might not care about this at all. Others might want specific
> threshold to start the actual playback.
> 
Oh yes. I guess start_threshold is not even known yet when we are ruling
the buffer size so we cannot use it as a source for alternative rules?

-- 
Jarkko
