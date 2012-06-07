From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: [PATCH] ALSA: hda - power setting error check
Date: Thu, 7 Jun 2012 18:27:06 +0800
Message-ID: <CA+v+29i8-EbMmj=jhDKrkwfaso2nG-TcecEf=ejBsB8+PLE4vg@mail.gmail.com>
References: <1339059171-4199-1-git-send-email-xingchao.wang@intel.com>
	<s5h8vfz79k3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f50.google.com (mail-qa0-f50.google.com
	[209.85.216.50]) by alsa0.perex.cz (Postfix) with ESMTP id 0634E2413A
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 12:27:27 +0200 (CEST)
Received: by qafl39 with SMTP id l39so44372qaf.2
	for <alsa-devel@alsa-project.org>; Thu, 07 Jun 2012 03:27:27 -0700 (PDT)
In-Reply-To: <s5h8vfz79k3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, fengguang.wu@intel.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

2012/6/7 Takashi Iwai <tiwai@suse.de>:
> At Thu, =A07 Jun 2012 16:52:51 +0800,
> Wang Xingchao wrote:
>>
>> codec may reject power state transition requests(reporting PS-ERROR set),
>> in that case we re-issue a power state setting and check error bit again.
>>
>> Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
>> ---
>> =A0sound/pci/hda/hda_codec.c | =A0 11 +++++++++++
>> =A01 file changed, 11 insertions(+)
>>
>> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
>> index d0ca370..bb64eba 100644
>> --- a/sound/pci/hda/hda_codec.c
>> +++ b/sound/pci/hda/hda_codec.c
>> @@ -3526,6 +3526,7 @@ static bool snd_hda_codec_get_supported_ps(struct =
hda_codec *codec, hda_nid_t fg
>> =A0static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int=
 power_state)
>> =A0{
>> + =A0 =A0 int state, count =3D 0;
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
>> +again:
>> =A0 =A0 =A0 snd_hda_codec_read(codec, fg, 0, AC_VERB_SET_POWER_STATE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 power_state);
>> =A0 =A0 =A0 snd_hda_codec_set_power_to_all(codec, fg, power_state, true);
>> + =A0 =A0 state =3D snd_hda_codec_read(codec, fg, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AC_VERB=
_GET_POWER_STATE, 0);
>> + =A0 =A0 if (state & AC_PWRST_ERROR) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* repeat power states setting at most 10 time=
s*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (count++ > 10)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_printk(KERN_WARNING "Power=
 states transition reject!\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto again;
>> + =A0 =A0 }
>
> For such a short block, better to use a proper loop instead of goto,
> IMO.
>

Thanks for review, i'd update the patch and send it out again.

thanks
--xingchao
