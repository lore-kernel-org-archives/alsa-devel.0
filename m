From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: HBR audio with intel HDA
Date: Fri, 02 Aug 2013 19:28:40 +0300
Message-ID: <51FBDE38.5060304@iki.fi>
References: <a7c323b2e500302c67f527c6b3b819e3@free.fr>
 <51FA8EDC.5040601@iki.fi> <8C6FC878-F338-4040-8557-693C9490B495@free.fr>
 <51FBB72C.3090800@iki.fi> <BD474694-A9C3-4ACA-AB88-D4448831B4C4@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id EB9B1261740
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2013 18:28:46 +0200 (CEST)
In-Reply-To: <BD474694-A9C3-4ACA-AB88-D4448831B4C4@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ashecrow <ashecrow42@free.fr>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
 Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

02.08.2013 19:14, Ashecrow kirjoitti:
> =

> Le 2 ao=FBt 2013 =E0 15:42, Anssi Hannula a =E9crit :
> =

>> 02.08.2013 16:11, Ashecrow kirjoitti:
>>> Hi Anssi,
>>> Thanks for your answer
>>>
>>> Test on kernel 3.8 + non-pcm bit in AES0:
>>> aplay -D hdmi:CARD=3DPCH,DEV=3D0,AES0=3D0x06 -c8 -fs16_le -r192000 dts.=
spdif
>>> =3D> same result: no signal
>>
>> Hmh, OK.
>>
>>> With kernel upgrade to 3.9: same result
>>>
>>>
>>> Note that I have tested with alsa* 1.025 and intel-hda driver included =
in kernel
>>>
>>> Do you have any other idea?
>>
>> You could try DEV=3D1 instead of DEV=3D0 (according to your log DEV=3D0 =
is
>> correct, though), and truehd (thd.spdif from ffmpeg samples).
>>
>> If neither of those work, could you provide another alsa-info while
>> playing back using AES0=3D0x06 (with alsa debug enabled again)?
>>
> I have already tried DEV=3D1 but it does the same. Moreover, let me note =
that I play DTS and dolby fine with DEV=3D0 in xbmc. So I guess it is the r=
ight device.

OK. Note that in some cases you can hear stereo audio or AC-3/DTS even
when using wrong DEV=3Dx (but HBR or multichannel audio would not work).

> see attached alsa-info.txt_dev0_kernel-3.8_aes0_dts-hd which is result of=
 playing dts-hd spdif encapsulated with kernel 3.8 in debug mode and AES0=
=3D0x06 through command bellow
> =

> aplay -D hdmi:CARD=3DPCH,DEV=3D0,AES0=3D0x06 -c8 -fs16_le -r192000 dts.sp=
dif
> =

> see attached alsa-info.txt_dev0_kernel-3.8_aes0_true-hd which is result o=
f playing dts-hd spdif encapsulated with kernel 3.8 in debug mode and AES0=
=3D0x06 through command bellow
> =

> aplay -D hdmi:CARD=3DPCH,DEV=3D0,AES0=3D0x06 -c8 -fs16_le -r192000 thd.sp=
dif
> =


Looks like your kernel is definitely too old to have working HBR on
Intel (the "ASP channel x =3D> slot y" messages should have x=3Dy), so
you'll need 3.9+.

Unfortunately I don't see anything else wrong (and HBR+intel works for
me), so I don't have anything else to suggest at the moment. Sorry.


> Thanks for your help
> =

>>
>>
>>> Thanks
>>>
>>>
>>> Le 1 ao=FBt 2013 =E0 18:37, Anssi Hannula a =E9crit :
>>>
>>>> 01.08.2013 19:29, ashecrow42@free.fr kirjoitti:
>>>>> Hi there,
>>>>
>>>> Hi!
>>>>
>>>>> I have troubles using HBR audio (DTS-HD and Dolby TrueHD). With every =

>>>>> test, I get no signal in the AV receiver. I have tested using a dts-h=
d =

>>>>> encapsulated in spdif sample file (found there =

>>>>> http://samples.mplayerhq.hu/hdmi/) and commands bellow
>>>>>
>>>>> - aplay -D hdmi devices
>>>>> - aplay -D hw devices
>>>>> - aplay -D plughw devices
>>>>
>>>> You need to set the non-pcm bit in AES0. Use e.g. "-D hdmi:AES0=3D0x06=
".
>>>>
>>>>> Note that I use ubuntu raring with 3.8 kernel that includes Xingchao'=
s =

>>>>> HBR kernel patches.
>>>>>
>>>>>
>>>>> A. Configurations I have tested:
>>>>>
>>>>>
>>>>> - hda driver upgrade (alsa devel ubuntu team daily builds)
>>>>>
>>>>> - upgrade alsa-lib & alsa-utils (alsa-testing launchpad)
>>>>>
>>>>> - kernel upgrade to 3.9
>>>>
>>>> IIRC 3.9 (or newer) may indeed be needed since you have both hdmi and =
spdif.
>>>>
>>>>> - snd_hda_codec_realtek module backlist (to try to disable SPDIF) =

>>>>> /etc/modprobe.d/blacklist.conf
>>>>>
>>>>> - snd_hda_codec_realtek index =3D -2 in /etc/modprobe.d/alsa-base.conf
>>>>>
>>>>> - fresh new ubuntu raring install with no modifications at all: still =

>>>>> no signal
>>>>>
>>>>> B. Info:
>>>>>
>>>>> cat /proc/asound/card0/codec* | grep Codec
>>>>> Codec: Realtek ALC892
>>>>> Codec: Intel CougarPoint HDMI
>>>>>
>>>>> I use zotac ZBOX ID82 (intel HM65 chipset with hdmi and spdif)
>>>>>
>>>>> with alsa debug and alsa debug verbose enabled in kernel I got the =

>>>>> alsa-info.txt attached file produced on raring with no modification =

>>>>> while playing dts-hd sample file with command:
>>>>>
>>>>>
>>>>> aplay -D hdmi:CARD=3DPCH,DEV=3D0 -c8 -fs16_le -r192000 dts.spdif
>>>>
>>>> As per above you need to use
>>>> aplay -D hdmi:CARD=3DPCH,DEV=3D0,AES0=3D0x06 -c8 -fs16_le -r192000 dts=
.spdif
>>>>
>>>>>
>>>>> C. I add that:
>>>>>
>>>>> - In every test I have non HD audio protocols (DTS and dolby) working =

>>>>> well in the same configuration
>>>>>
>>>>> - I have tried with windows just to see if my hardware is broken and =
I =

>>>>> get DTS-HD audio with no problem
>>>>>
>>>>> - Takashi, I've read your HD-Audio.txt file and as far as I see, I ha=
ve =

>>>>> no known error message in kernel log
>>>>>
>>>>>
>>>>> =3D> I and Wingchao Wang have conclued that it is driver or codec =

>>>>> related. Can you help me please?
>>>>>
>>>>> Thanks a lot
>>>>> PS: sorry if you receive this email twice, I have sent it again as I =

>>>>> was not member of the list the first time.
>>>>
>>>>
>>>> -- =

>>>> Anssi Hannula
>>>
>>
>>
>> -- =

>> Anssi Hannula
> =



-- =

Anssi Hannula
