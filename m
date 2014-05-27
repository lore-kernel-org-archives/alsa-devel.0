From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: tlv320aic3x: Fix Left/Rigth PGA
 mixer widgets/kcontrols
Date: Tue, 27 May 2014 14:09:19 +0200
Message-ID: <5384806F.3020005@metafoo.de>
References: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
 <1401187986-11059-3-git-send-email-peter.ujfalusi@ti.com>
 <53847489.2010801@metafoo.de> <538479EC.7030105@ti.com>
 <53847CE7.4080105@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-017.synserver.de (smtp-out-075.synserver.de
 [212.40.185.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D437265633
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 14:09:50 +0200 (CEST)
In-Reply-To: <53847CE7.4080105@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/27/2014 01:54 PM, Lars-Peter Clausen wrote:
> On 05/27/2014 01:41 PM, Peter Ujfalusi wrote:
>> On 05/27/2014 02:18 PM, Lars-Peter Clausen wrote:
>>> On 05/27/2014 12:53 PM, Peter Ujfalusi wrote:
>>>> Commit "cf7c1de20c576 ASoC: dapm: Move 'value' field from widget to
>>>> control" changed the way how the 'value' has been stored for a widget.
>>>> Since the driver is not updated following the mentioned commit it is mostly
>>>> broken when we try to change mixers for Left/Right PGA since the value is
>>>> not going to be updated correctly.
>>>
>>> I don't think the mentioned commit is the cause. The driver didn't set
>>> widget->value either, so there is no change in behavior here. The commit
>>> only
>>> changed where the value is stored not how it is handled.
>>
>> Yes, exactly. The driver has not been updated after the place where the value
>> is stored, so it is not going to store it at all, which causes issues along
>> the way.
>
> Before the patch the value was stored in widget->value, after the patch the
> value is stored in the kcontrol. The tlv320aic3x driver did not store
> anything in widget->value before the patch and neither does it store
> anything in the kcontrol after the patch.
>
>>
>>> This driver uses a custom put handler and the generic get handler.
>>> dapm_kcontrol_get_value() is used in the generic get handler, but only if
>>> reg
>>> equal to SND_SOC_NOPM. Which is not the case for this driver.
>>
>> The relevant code is this:
>>     if (dapm_kcontrol_is_powered(kcontrol) && reg != SND_SOC_NOPM)
>>         val = (snd_soc_read(codec, reg) >> shift) & mask;
>>     else
>>         val = dapm_kcontrol_get_value(kcontrol);
>>
>> and when the widget is not powered the code will try to get the value from
>> the
>> dapm_kcontrol_data, which is not even touched by the custom code in the
>> driver.
>
> dapm_kcontrol_is_powered() always returns true if the control is not a
> auto-muted control. And there are no auto-muted controls in the tlv320aix3c
> driver.
>
> There are two cases where dapm_kcontrol_get_value() can be called
> a) The control is a virtual control
> b) The control is a auto-muted control
>
> Neither is the case here, which is why I expect that the real issue is
> something else and it is just shadowed by this patch.

Picking up on that. What you changed in the patch is that you no longer 
return the return value of snd_soc_test_bits() to the upper layers. amixer 
will print "Invalid command!" if it got a error code. So I'd expect that 
snd_soc_test_bits() returns a error code, can you check that?

- Lars
