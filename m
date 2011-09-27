From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/3] ASoC: ssm2602: Support setting the
 oscillator and the clock output state
Date: Tue, 27 Sep 2011 14:47:12 +0200
Message-ID: <4E81C5D0.5000905@metafoo.de>
References: <1317114528-16736-1-git-send-email-lars@metafoo.de>
	<1317114528-16736-3-git-send-email-lars@metafoo.de>
	<20110927123032.GJ4289@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id C654E24346
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 14:47:52 +0200 (CEST)
In-Reply-To: <20110927123032.GJ4289@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

On 09/27/2011 02:30 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 11:08:48AM +0200, Lars-Peter Clausen wrote:
>> Currently the oscillator is always enabled and the clock output is always
>> disabled. This patch adds support for controlling the oscillator and clock
>> output state through snd_soc_dai_set_sysclk. Which makes it possible to
>> disable or enable them dynamically according to the requirements of the board
>> on which the CODEC is used.
>>
>> This patch also slightly modifies the behavior as to when the oscillator is
>> going to be disabled in low-power states. Previously it would only be disabled
>> in BIAS_OFF, now it is also going to be disabled in BIAS_STANDBY, since no
>> components which depend on it should be active in this state.
> 
> Is this last assumption actually true?  Things like accessory detect can
> need clocks on devices even when they're idle from an audio point of
> view.  Still, I've applied the patch - we can always fix up later if
> something needs the clock enabling.

At least for the ssm2602 the sysclk is only used to for audio processing and to
drive the clock out signal. Audio is off in standby and the clock out signal
was going to be disabled when switching to standby even before this patch. But
you are correct the later might be a problem in systems where the clock out
signal is used for another external component which needs a clock input signal
in standby mode.

Thanks
- Lars
