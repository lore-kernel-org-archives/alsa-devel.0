From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: [PATCH 2/2] ALSA: hda - reduce msleep time if EPSS
 power states supported
Date: Thu, 7 Jun 2012 15:26:18 +0800
Message-ID: <CA+v+29h7Oz6DWdfP6W5UXAJEH9--oWbGuLB3_gyeMVFefrqCSg@mail.gmail.com>
References: <1338991369-31656-1-git-send-email-xingchao.wang@intel.com>
	<1338991369-31656-2-git-send-email-xingchao.wang@intel.com>
	<4FD054FF.1090907@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
	[209.85.216.44]) by alsa0.perex.cz (Postfix) with ESMTP id 6FE07244F5
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 09:26:39 +0200 (CEST)
Received: by qadz3 with SMTP id z3so3695423qad.17
	for <alsa-devel@alsa-project.org>; Thu, 07 Jun 2012 00:26:38 -0700 (PDT)
In-Reply-To: <4FD054FF.1090907@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi David,


2012/6/7 David Henningsson <david.henningsson@canonical.com>:
> On 06/06/2012 04:02 PM, Wang Xingchao wrote:
>>
>> if EPSS supported, transition from D3 state to D0 state in less
>> than 10ms
>>
>> Signed-off-by: Wang Xingchao<xingchao.wang@intel.com>
>> ---
>> =A0sound/pci/hda/hda_codec.c | =A0 =A06 +++++-
>> =A01 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
>> index b89c8ec..5298ba1 100644
>> --- a/sound/pci/hda/hda_codec.c
>> +++ b/sound/pci/hda/hda_codec.c
>> @@ -3526,14 +3526,18 @@ static bool snd_hda_codec_get_supported_ps(struct
>> hda_codec *codec, hda_nid_t fg
>> =A0static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned =
int power_state)
>> =A0{
>> + =A0 =A0 =A0 bool epss;
>> =A0 =A0 =A0 =A0if (codec->patch_ops.set_power_state) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0codec->patch_ops.set_power_state(codec, f=
g, power_state);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 epss =3D snd_hda_codec_get_supported_ps(codec, fg, AC_PWRS=
T_EPSS);
>> =A0 =A0 =A0 =A0/* this delay seems necessary to avoid click noise at pow=
er-down */
>> - =A0 =A0 =A0 if (power_state =3D=3D AC_PWRST_D3)
>> + =A0 =A0 =A0 if ((power_state =3D=3D AC_PWRST_D3)&& =A0!epss)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msleep(100);
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(10);
>
>
> Hi Wang,
>
> You seem to have increased the delay from 0 to 10 ms on all cases when
> power_state !=3D AC_PWRST_D3, is this intentional?

Thanks for clarification, it's a mistake here. Only transition from D0
to D3 need the delay to avoid click noise, there's no limitation
during power up.
i will update the patch based on your suggestion.

thanks
--xingchao

>
> Or did you mean to write like this:
>
> =A0 =A0 =A0 =A0if (power_state =3D=3D AC_PWRST_D3) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool epss =3D snd_hda_codec_get_supported_=
ps(codec, fg,
> AC_PWRST_EPSS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msleep(epss ? 10 : 100);
> =A0 =A0 =A0 =A0}
>
>
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
