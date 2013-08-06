From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: rt5640: change widget
	sequencefordepop
Date: Tue, 06 Aug 2013 10:45:41 +0200
Message-ID: <5200B7B5.7050506@metafoo.de>
References: <1375676343-13891-1-git-send-email-bardliao@realtek.com>
 <20130805144808.GG9858@sirena.org.uk> <51FFDF11.5020106@metafoo.de>
 <1121E117AD4ECE49880A389A396215BB935C692E0E@rtitmbs7.realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 12DA0261688
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 10:45:26 +0200 (CEST)
In-Reply-To: <1121E117AD4ECE49880A389A396215BB935C692E0E@rtitmbs7.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "swarren@nvidia.com" <swarren@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 08/06/2013 10:07 AM, Bard Liao wrote:
>> -----Original Message-----
>> From: Lars-Peter Clausen [mailto:lars@metafoo.de]
>> Sent: Tuesday, August 06, 2013 1:21 AM
>> To: Mark Brown
>> Cc: Bard Liao; Oder Chiou; alsa-devel@alsa-project.org; swarren@nvidia.com;
>> swarren@wwwdotorg.org; lgirdwood@gmail.com; Flove
>> Subject: Re: [alsa-devel] [PATCH] ASoC: rt5640: change widget sequence
>> fordepop
>>
>> On 08/05/2013 04:48 PM, Mark Brown wrote:
>>> On Mon, Aug 05, 2013 at 12:19:03PM +0800, bardliao@realtek.com wrote:
>>>> From: Bard Liao <bardliao@realtek.com>
>>>>
>>>> Add mute/unmute control in widget event and modify the power on/off
>> sequence to avoid pop noise.
>>>
>>> This looks like you should be using Lars-Peter's patch for controls
>>> that are disabled while a widget isn't powered - as far as I can tell
>>> from a quick read through all this does is keep the speaker/headphone
>>> muted while the outputs are powered down.
>>
>> The driver is using stereo controls though. So either support for stereo controls
>> needs to be added to DAPM (which shouldn't be too hard) or the control needs
>> to be split into two mono controls.
>>
>> - Lars
>
> I think I need to use SND_SOC_DAPM_SWITCH with SOC_DAPM_SINGLE_AUTODISABLE for this control.
> Am I right?
> I am trying to do that, but meet a problem.
> If I set speaker switch unmute before playing music, dapm will mute it automatically in power on sequence.
> The only way I can unmute speaker is set speaker switch unmute while playing music.

DAPM should unmute the switch on power up and mute it on power down. The 
Speaker Channel Switch control has the invert flag set did you also set the 
invert flag for the new autodisable control?

- Lars
