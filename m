From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adau1701: Reset codec based on
	sample rate changes
Date: Wed, 23 Mar 2016 14:44:43 +0100
Message-ID: <56F29DCB.2090208@metafoo.de>
References: <1458734303-16307-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-033.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 6215C267260
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 14:44:55 +0100 (CET)
In-Reply-To: <1458734303-16307-1-git-send-email-pascal.huerst@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: pascal.huerst@gmail.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 03/23/2016 12:58 PM, pascal.huerst@gmail.com wrote:
> From: Pascal Huerst <pascal.huerst@gmail.com>
> 
> Instead of checking if mclk/lrclk ratio has changed, check if
> sample rate has changed. In certain cases, the mclk might be
> changed in the machine driver, which can lead to the same
> mclk/lrclk ration, eventhow the sample rate has changed.
> 
> Since the codec has to be programmed differently for every
> sample rate, its better to check for samplerate changes instead
> of mclk/lrclk ration changes.

Mark's comment made me give this some additional though. Do we actually
need to reset the device if the clkdiv did not change. Stopping the DSP,
uploading the new firmware and then restarting it should be sufficient.
But on the other hand the time the reset takes should be negligible
compared to programming the firmware, so it might be ok to always do it.
Let me know what you think.
