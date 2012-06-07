From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Fwd: [PATCH V2] ALSA: hda - power setting error check
Date: Thu, 7 Jun 2012 21:33:35 +0800
Message-ID: <CA+v+29hFyViDi2rTZUbVeVUD72MMVbYfGA5ynP5vYivtm6uG8g@mail.gmail.com>
References: <1339064490-6510-1-git-send-email-xingchao.wang@intel.com>
	<20120607104243.GA18157@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 13BDE104579
	for <Alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 15:33:56 +0200 (CEST)
Received: by qcse14 with SMTP id e14so298251qcs.38
	for <Alsa-devel@alsa-project.org>; Thu, 07 Jun 2012 06:33:56 -0700 (PDT)
In-Reply-To: <20120607104243.GA18157@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel@alsa-project.org, "Wang,
	Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi fengguang,

2012/6/7 Fengguang Wu <fengguang.wu@intel.com>:
> Xingchao,
>
> On Thu, Jun 07, 2012 at 06:21:30PM +0800, Wang Xingchao wrote:
>> codec may reject power state transition requests(reporting PS-ERROR set),
>> in that case we re-issue a power state setting and check error bit again.
>
> Is this patch based on real errors observed? And tested to fix the issue?
>

Not exactly, i tested the patch on my netbook with codec ALC269 and
didnot meet regression. It's not based on real error but from the HDA
spec description about PowerStates setting part. The spec said
PS-ERROR bit indicates the power states transition rejection so we'd
better check the status when try to set  codec power state.

>> Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
>> ---
>> =A0sound/pci/hda/hda_codec.c | =A0 17 ++++++++++++++---
>> =A01 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
>> index d0ca370..a93c7ca 100644
>> --- a/sound/pci/hda/hda_codec.c
>> +++ b/sound/pci/hda/hda_codec.c
>> @@ -3526,6 +3526,7 @@ static bool snd_hda_codec_get_supported_ps(struct =
hda_codec *codec, hda_nid_t fg
>> =A0static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int=
 power_state)
>> =A0{
>> + =A0 =A0 int state, count =3D 0;
>
> nit pick: break that into two lines?
>
> state should be unsigned int.
>
>> =A0 =A0 =A0 if (codec->patch_ops.set_power_state) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 codec->patch_ops.set_power_state(codec, fg, =
power_state);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> @@ -3537,9 +3538,19 @@ static void hda_set_power_state(struct hda_codec =
*codec, hda_nid_t fg,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bool epss =3D snd_hda_codec_get_supported_ps=
(codec, fg, AC_PWRST_EPSS);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(epss? 10:100);
>> =A0 =A0 =A0 }
>> - =A0 =A0 snd_hda_codec_read(codec, fg, 0, AC_VERB_SET_POWER_STATE,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 power_state);
>> - =A0 =A0 snd_hda_codec_set_power_to_all(codec, fg, power_state, true);
>> +
>> + =A0 =A0 /* repeat power states setting at most 10 times*/
>> + =A0 =A0 while (count++ > 10) {
>
> < 10?
>
> for(;;) looks slightly better, by putting the initialization together
> with test and increase.
>

thanks your review above, i will fix these errors.

>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_read(codec, fg, 0, AC_VERB_SET_P=
OWER_STATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 power_=
state);
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_set_power_to_all(codec, fg, powe=
r_state, true);
>> + =A0 =A0 =A0 =A0 =A0 =A0 state =3D snd_hda_codec_read(codec, fg, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0AC_VERB_GET_POWER_STATE, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!(state & AC_PWRST_ERROR))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> Do you have any clue the condition of success? For example, is it time
> based (the codec takes some time to respond) or retry count based?
>

Good question. snd_hda_codec_read() will send the command and get the
response, but power setting verb id (705h) acturally has response "0"
all the time. As the spec said, if the node remain in its previous
power states, it sets PS-ERROR bit immediately. If the node doesnot
set PS-Error bit after it received the Set Power State Verb, that
means the transition is successful. That's why i didnot add some time
delay to wait for the response here.

>> + =A0 =A0 }
>> + =A0 =A0 if (count > 10)
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_printk(KERN_WARNING "Power states transiti=
on reject!\n");
>
> Power state transition rejected
>
> Hmm, if some codec always rejects it, the user may get lots of these
> warnings..

Will remove the warning message here.

--thanks
xingchao
