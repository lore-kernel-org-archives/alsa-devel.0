From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] ASoC: tlv320aic3x: Fix Left/Rigth PGA
 mixer widgets/kcontrols
Date: Tue, 27 May 2014 15:19:14 +0300
Message-ID: <538482C2.1090607@ti.com>
References: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
 <1401187986-11059-3-git-send-email-peter.ujfalusi@ti.com>
 <53847489.2010801@metafoo.de> <538479EC.7030105@ti.com>
 <53847CE7.4080105@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id DE855261A0D
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 14:19:17 +0200 (CEST)
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
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/27/2014 02:54 PM, Lars-Peter Clausen wrote:
> On 05/27/2014 01:41 PM, Peter Ujfalusi wrote:
>> On 05/27/2014 02:18 PM, Lars-Peter Clausen wrote:
>>> On 05/27/2014 12:53 PM, Peter Ujfalusi wrote:
>>>> Commit "cf7c1de20c576 ASoC: dapm: Move 'value' field from widget to
>>>> control" changed the way how the 'value' has been stored for a widget.
>>>> Since the driver is not updated following the mentioned commit it is m=
ostly
>>>> broken when we try to change mixers for Left/Right PGA since the value=
 is
>>>> not going to be updated correctly.
>>>
>>> I don't think the mentioned commit is the cause. The driver didn't set
>>> widget->value either, so there is no change in behavior here. The commi=
t only
>>> changed where the value is stored not how it is handled.
>>
>> Yes, exactly. The driver has not been updated after the place where the =
value
>> is stored, so it is not going to store it at all, which causes issues al=
ong
>> the way.
> =

> Before the patch the value was stored in widget->value, after the patch t=
he
> value is stored in the kcontrol. The tlv320aic3x driver did not store any=
thing
> in widget->value before the patch and neither does it store anything in t=
he
> kcontrol after the patch.

Sure it is not doing itself. When this custom function has been added it was
essentially a copy of the snd_soc_dapm_put_volsw() - stripped down a bit co=
py.
But it has not been updated for a long time to follow what is happening the
the core underneath.
I believe not many people uses these paths with the codec and this is why it
has gone unnoticed.
I might attempt to bisect this, but not really sure from which point this is
broken (3.14, 3.12?).

>>> This driver uses a custom put handler and the generic get handler.
>>> dapm_kcontrol_get_value() is used in the generic get handler, but only =
if reg
>>> equal to SND_SOC_NOPM. Which is not the case for this driver.
>>
>> The relevant code is this:
>>     if (dapm_kcontrol_is_powered(kcontrol) && reg !=3D SND_SOC_NOPM)
>>         val =3D (snd_soc_read(codec, reg) >> shift) & mask;
>>     else
>>         val =3D dapm_kcontrol_get_value(kcontrol);
>>
>> and when the widget is not powered the code will try to get the value fr=
om the
>> dapm_kcontrol_data, which is not even touched by the custom code in the =
driver.
> =

> dapm_kcontrol_is_powered() always returns true if the control is not a
> auto-muted control. And there are no auto-muted controls in the tlv320aix=
3c
> driver.

dapm_kcontrol_is_powered() returns the data->widget->power, which is not the
automute state. Widgets do turn off when they are not in use, like in my sy=
stem:

# cat tlv320aic3x-codec.0-001b/dapm/Left\ PGA\ Mixer
Left PGA Mixer: Off  in 0 out 0
 out "static" "Left ADC"

So the widget's power is off.

> =

> There are two cases where dapm_kcontrol_get_value() can be called
> a) The control is a virtual control
> b) The control is a auto-muted control
> =

> Neither is the case here, which is why I expect that the real issue is
> something else and it is just shadowed by this patch.
> =

> - Lars


-- =

P=E9ter
