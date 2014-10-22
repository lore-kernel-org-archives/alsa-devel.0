From: "Palacios, Hector" <Hector.Palacios@digi.com>
Subject: Re: [PATCH] ASoC: soc-pcm: always cancel any pending
 delayed stream shutdown
Date: Wed, 22 Oct 2014 17:25:11 +0000
Message-ID: <52F917CEA1B9C64C94833D53889D478C044B9B@dor-sms-xch01.digi.com>
References: <1413987293-21544-1-git-send-email-hector.palacios@digi.com>
 <20141022162802.GB2344@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta8.messagelabs.com (mail1.bemta8.messagelabs.com
 [216.82.243.204])
 by alsa0.perex.cz (Postfix) with ESMTP id 43C7C265205
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 19:25:16 +0200 (CEST)
In-Reply-To: <20141022162802.GB2344@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Oct 2014 18:28, Mark Brown wrote:
> On Wed, Oct 22, 2014 at 04:14:53PM +0200, Hector Palacios wrote:
>> After playback a shutdown is scheduled to happen within 5 seconds.
>> If another playback takes place before the scheduled work times out, 
>> the work is cancelled, but if a recording takes place, the work will 
>> shutdown in the middle of the recording, causing problems.
> 
> You're not saying what the problems are, just that they might be caused.

Sorry, your right. When I do a recording 2 seconds after a previous playback, and later play the recorded sound I hear 3 seconds of correct audio and then I continue to hear good audio but mixed with noise and at a higher volume, as if the codec had reseted certain parameters to some default values.

> Starting or stopping a playback should have no impact on a running 
> capture stream, users could always start and stop streams manually 
> anyway.  It sounds like you're working around some problem in drivers.

I see. I tested this with Freescale SGTL5000 on an i.MX6 platform. The shutdown of the playback is eventually calling the set_bias_level() hook of the codec to SND_SOC_BIAS_PREPARE and then again to SND_SOC_BIAS_STANDBY which may eventually turn off the regulators. Anyway the problem doesn't seem to be on this codec hook because I set it to NULL and the problem was reproducible. I thought it was the dapm->bias_level being set to STANDBY on snd_soc_dapm_set_bias_level() in the middle of the capture that did something to the workflow of the capture stream, but I'm no expert on the architecture of the sound layer and didn't see any other call to the codec functions that could be causing the issue. 

Thanks
