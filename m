From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH] ALSA: hda - Do not assign streams in reverse order
Date: Tue, 08 Apr 2014 10:50:18 +0300
Message-ID: <5343AA3A.6050405@iki.fi>
References: <1396899398-1293-1-git-send-email-anssi.hannula@iki.fi> <s5hr458qnnu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hr458qnnu.wl%tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

08.04.2014 10:35, Takashi Iwai kirjoitti:
> At Mon,  7 Apr 2014 22:36:38 +0300,
> Anssi Hannula wrote:
>>
>> Currently stream numbers are assigned in reverse order.
>>
>> Unfortunately commit 7546abfb8e1f9933b5 ("ALSA: hda - Increment
>> default stream numbers for AMD HDMI controllers") assumed this was n=
ot
>> the case (specifically, it had the "old cards had single device only=
"
>> =3D> "extra unused stream numbers do not matter" assumption), causin=
g
>> non-working audio regressions for AMD Radeon HDMI users on v3.14.
>>
>> Change the stream numbers to be assigned in increasing order instead=
=2E
>>
>> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=3D77002
>> Reported-by: Christian G=C3=BCdel <cg@dmesg.ch>
>> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
>> Tested-by: Christian G=C3=BCdel <cg@dmesg.ch>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: <stable@vger.kernel.org> # 3.14
>> ---
>>
>> Takashi, please check I didn't miss anything (I'm not that familiar
>> with this low-level HDA code). :)
>=20
> In that case, let's revert the commit instead.  There was a reason to
> behave in that way, although I don't remember well.  That said, this
> change might lead to another regression.  Thus, if a fix is needed fo=
r
> stable, the revert would be the best choice as a first aid.  Of
> course, this change is good to have, so let's implement this for 3.15
> and see whether it works well for all nasty controllers.

We tested reverting (on top of v3.14) with Christian and it works as
well, so you can add:
Tested-by: Christian G=C3=BCdel <cg@dmesg.ch>

> Besides, this patch can't be applied any longer to the current code
> base since it's been rewritten a lot; most of codes have been moved t=
o
> another file hda_controller.c.  Could you rebase the patch for the
> latest tree?  Meanwhile I'll prepare a revert that is applied only to
> 3.14.x.

Will do.

>=20
> thanks,
>=20
> Takashi
>=20
>>
>>
>>  sound/pci/hda/hda_intel.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index e354ab1ec20f..7a7b7b10dddf 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -1856,13 +1856,14 @@ azx_assign_device(struct azx *chip, struct s=
nd_pcm_substream *substream)
>>  		struct azx_dev *azx_dev =3D &chip->azx_dev[dev];
>>  		dsp_lock(azx_dev);
>>  		if (!azx_dev->opened && !dsp_is_locked(azx_dev)) {
>> -			res =3D azx_dev;
>> -			if (res->assigned_key =3D=3D key) {
>> -				res->opened =3D 1;
>> -				res->assigned_key =3D key;
>> +			if (azx_dev->assigned_key =3D=3D key) {
>> +				azx_dev->opened =3D 1;
>> +				azx_dev->assigned_key =3D key;
>>  				dsp_unlock(azx_dev);
>>  				return azx_dev;
>>  			}
>> +			if (!res)
>> +				res =3D azx_dev;
>>  		}
>>  		dsp_unlock(azx_dev);
>>  	}
>> --=20
>> 1.8.4.5
>>


--=20
Anssi Hannula
