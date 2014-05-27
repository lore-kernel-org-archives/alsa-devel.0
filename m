From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/2] ASoC: tlv320aic3x: Fix Left/Rigth PGA
 mixer widgets/kcontrols
Date: Tue, 27 May 2014 14:41:32 +0300
Message-ID: <538479EC.7030105@ti.com>
References: <1401187986-11059-1-git-send-email-peter.ujfalusi@ti.com>
 <1401187986-11059-3-git-send-email-peter.ujfalusi@ti.com>
 <53847489.2010801@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E6F5265529
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 13:41:39 +0200 (CEST)
In-Reply-To: <53847489.2010801@metafoo.de>
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

On 05/27/2014 02:18 PM, Lars-Peter Clausen wrote:
> On 05/27/2014 12:53 PM, Peter Ujfalusi wrote:
>> Commit "cf7c1de20c576 ASoC: dapm: Move 'value' field from widget to
>> control" changed the way how the 'value' has been stored for a widget.
>> Since the driver is not updated following the mentioned commit it is mos=
tly
>> broken when we try to change mixers for Left/Right PGA since the value is
>> not going to be updated correctly.
> =

> I don't think the mentioned commit is the cause. The driver didn't set
> widget->value either, so there is no change in behavior here. The commit =
only
> changed where the value is stored not how it is handled.

Yes, exactly. The driver has not been updated after the place where the val=
ue
is stored, so it is not going to store it at all, which causes issues along
the way.

> This driver uses a custom put handler and the generic get handler.
> dapm_kcontrol_get_value() is used in the generic get handler, but only if=
 reg
> equal to SND_SOC_NOPM. Which is not the case for this driver.

The relevant code is this:
	if (dapm_kcontrol_is_powered(kcontrol) && reg !=3D SND_SOC_NOPM)
		val =3D (snd_soc_read(codec, reg) >> shift) & mask;
	else
		val =3D dapm_kcontrol_get_value(kcontrol);

and when the widget is not powered the code will try to get the value from =
the
dapm_kcontrol_data, which is not even touched by the custom code in the dri=
ver.

> And that's the
> only place where the value stored for the kcontrol is used. I don't see h=
ow
> calling dapm_kcontrol_set_value() or not calling dapm_kcontrol_set_value()
> changes anything.

When the widget is not powered the stored value is going to be used. The
custom code in the driver should mimic the code from the core which it is s=
et
to replace/customize.

> =

> I might be missing something, but I think the issue is somewhere else.
> =

> - Lars


-- =

P=E9ter
