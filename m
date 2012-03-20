From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Tue, 20 Mar 2012 18:20:33 +0200
Message-ID: <4F68AE51.808@bitmer.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id F3E89104332
	for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2012 17:20:38 +0100 (CET)
In-Reply-To: <1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/20/2012 01:13 PM, Peter Ujfalusi wrote:
> Certain application can experience underrun right after the playback start.
> This is caused by the McBSP FIFO/sDMA integration:
> The sDMA will push samples to the FIFO till it has threshold amount of free
> slots available in the FIFO. If the application picks period size which is
> smaller than the FIFO size, and it did not prepared multiple periods, or
> it did not set the start_threshold for the stream to cover the FIFO size
> the hw pointer will move forward, which is causing the underrun.
> 
> Add a sysfs entry for McBSP ports: period_protection.
> If this property is set the driver will place the constraint agains the
> period size, and not for the buffer size. To ensure that we do not hit
> underrun, the period size constraint will be increased with the requested
> number of frames (the period size will be FIFO size + period_protection).
> 
> As default the period_protection is disabled.
> 
I don't think this is going to solve the actual problem here where
custom asound.conf was required. IMHO custom sysfs is even worse option
and very hard to remove afterwards. And defaulting this new setting for
Pandora might break e.g. MER or MeeGo on N900.

I didn't check this but would it be possible to either put restriction
to start-delay (I think Grazvydas said he has experimental code for
that?) or make sure that minimum buffer size must be higher than FIFO +
1 period (or something like that)?

-- 
Jarkko
