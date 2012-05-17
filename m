From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Problem with snd_soc_suspend
Date: Thu, 17 May 2012 13:21:50 -0700
Message-ID: <4FB55DDE.30804@codeaurora.org>
References: <4FB0A685.3040408@codeaurora.org>
	<20120514083430.GG31985@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B22C103B6F
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2012 22:21:53 +0200 (CEST)
In-Reply-To: <20120514083430.GG31985@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 5/14/2012 1:34 AM, Mark Brown wrote:
> On Sun, May 13, 2012 at 11:30:29PM -0700, Patrick Lai wrote:
>
>> that as system attempts to enter suspend while DAILINK X is active,
>> snd_soc_suspend() calls snd_soc_dapm_stream_event(
>> SND_SOC_DAPM_STREAM_SUSPEND) on inactive DAILINK Y since DAILINK Y
>> ignore flag is not set. Consequently, CODEC widgets get powered off
>> even though they should remain powered for DAILINK X.
>
> This sounds like expected behaviour, if the widgets aren't marked as
> ignoring suspend then they will be suspended.
>
As CODEC is getting more complicated and more widgets would be defined,
I don't think it's scalable to mark ignore suspend per widget.

>> 1. Should soc-core check if CODEC DAI is active beside checking
>> ignore_suspend flag before calling snd_soc_dapm_stream_event()?
>> I checked latest soc-core.c from kernel 3.4 RC7. The logic is the same
>> as 3.0
>
> No, the whole point here is to suspend.  If we did that we'd never
> suspend any active streams.

If so, what is purpose of ignore_suspend? My problem is that active
stream which has ignore_suspend flag set ends up suspended because an
inactive stream without ignore_suspend flag set happens to be using
same CODEC but different digital audio interface. I don't think it's
the right behavior. DAPM should maintain widget usage reference. Only
If all CODEC DAIs that are using given widget are going to suspend
should DAPM go ahead power off the widget.

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
