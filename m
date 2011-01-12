From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] ALSA: hda: Disable 4/6 channels on some
 NVIDIA	GPUs.
Date: Wed, 12 Jan 2011 19:11:40 +0200
Message-ID: <4D2DE0CC.1010303@iki.fi>
References: <1294676371-1401-1-git-send-email-ndaga@nvidia.com>
	<4D2C8F59.4040507@iki.fi>
	<74CDBE0F657A3D45AFBB94109FB122FF03105680D9@HQMAIL01.nvidia.com>
	<4D2D29FD.6040008@iki.fi>
	<74CDBE0F657A3D45AFBB94109FB122FF0310568276@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sypressi.dnainternet.net (sypressi.dnainternet.net
	[83.102.40.135])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E221103809
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 18:11:45 +0100 (CET)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310568276@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nitin Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 12.01.2011 18:42, Stephen Warren wrote:
> Anssi Hannula wrote:
>>
>> On 11.01.2011 19:41, Stephen Warren wrote:
>>> Anssi Hannula wrote:
>>>> On 10.01.2011 18:19, Nitin Daga wrote:
>>>>> Added hardware constraint in patch_hdmi.c to disable
>>>>> channels 4/6 which are not supported by some older
>>>>> NVIDIA GPUs.
>>>>
>>>> And 3/5/7, which do not seem to work either with my 0x0007.
>>>
>>> Are 3/5/7 channels supported by any vendor?
>> ...
>>
>> Actually, I just tested and just transmitting 3-channel data with extra
>> 4th dummy channel while setting the Audio InfoFrame fields to indicate a
>> 3 channel stream makes it work.
>>
>> So it would seem (to me) like the best approach would be:
>> 1. Add a hw_constraint to prevent odd channel counts (easy)
> 
> That seems enough to me. I'm not sure that 3/5/7 channels are a format
> that there is much use-case for?

Usage of those formats is indeed somewhat limited.

This is true especially with ALSA, since if you open a device with 3
channels, it generally means left+right+rearleft instead of the likely
intended left+right+lfe or left+right+center.

And yes, (1) is enough, the below (2) was meant to be an additional
future development.

>> 2. Provide some way for alsa plug (and the user application) to indicate
>>    the "actual/original" channel count/layout without dummy channels,
>>    so that the infoframe can be set correctly.
>>    This is harder, and I guess should probably be implemented so that
>>    the channel remapping issue on older nvidia hw will be fixed as well.
> 
> Hmm. That sounds kinda complex. If constraints prevent the application
> from using e.g. 3-channel, then implementing (2) means the plugin would
> have to also modify the constraints to re-allow 3-channel, so the
> application could actually use it, no?

No, alsa-lib would insert a dummy channel, so it gets through the
hw_constraint as it is now a 4 channel stream. This is what already
happens when the constrains are added (and the alsa device is used via
'plug', e.g. "plug:'hdmi:CARD=NVidia,DEV=3'").

What (2) would mean is that alsa-lib also informs the kernel of the
actual layout (including 4th channel being a dummy one) so that
patch_hdmi can set the infoframe correctly.

(and in case of 7x hardware, libalsa would notice that the kernel driver
has a channel map different from alsa and do some channel remapping).

-- 
Anssi Hannula
