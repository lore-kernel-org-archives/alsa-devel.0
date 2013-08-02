From: Ashecrow <ashecrow42@free.fr>
Subject: Re: HBR audio with intel HDA
Date: Fri, 2 Aug 2013 15:11:10 +0200
Message-ID: <8C6FC878-F338-4040-8557-693C9490B495@free.fr>
References: <a7c323b2e500302c67f527c6b3b819e3@free.fr>
 <51FA8EDC.5040601@iki.fi>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by alsa0.perex.cz (Postfix) with ESMTP id C88AD265696
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2013 15:11:18 +0200 (CEST)
In-Reply-To: <51FA8EDC.5040601@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, xingchao.wang@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Anssi,
Thanks for your answer

Test on kernel 3.8 + non-pcm bit in AES0:
aplay -D hdmi:CARD=3DPCH,DEV=3D0,AES0=3D0x06 -c8 -fs16_le -r192000 dts.spdif
=3D> same result: no signal

Test with a non spdif-encapsulated file extracted from blu ray which is 16 =
bits 8 channel 192 kHz :
aplay -D hdmi:CARD=3DPCH,DEV=3D0,AES0=3D0x06 -c8 -fs16_le -r192000 dts.dts-=
hd.sample_track2_und.dts
=3D> I get a static noise and receiver shows PCM and 2 channels (front left=
 and front right)
 =

With kernel upgrade to 3.9: same result


Note that I have tested with alsa* 1.025 and intel-hda driver included in k=
ernel

Do you have any other idea?

Thanks


Le 1 ao=FBt 2013 =E0 18:37, Anssi Hannula a =E9crit :

> 01.08.2013 19:29, ashecrow42@free.fr kirjoitti:
>> Hi there,
> =

> Hi!
> =

>> I have troubles using HBR audio (DTS-HD and Dolby TrueHD). With every =

>> test, I get no signal in the AV receiver. I have tested using a dts-hd =

>> encapsulated in spdif sample file (found there =

>> http://samples.mplayerhq.hu/hdmi/) and commands bellow
>> =

>> - aplay -D hdmi devices
>> - aplay -D hw devices
>> - aplay -D plughw devices
> =

> You need to set the non-pcm bit in AES0. Use e.g. "-D hdmi:AES0=3D0x06".
> =

>> Note that I use ubuntu raring with 3.8 kernel that includes Xingchao's =

>> HBR kernel patches.
>> =

>> =

>> A. Configurations I have tested:
>> =

>> =

>> - hda driver upgrade (alsa devel ubuntu team daily builds)
>> =

>> - upgrade alsa-lib & alsa-utils (alsa-testing launchpad)
>> =

>> - kernel upgrade to 3.9
> =

> IIRC 3.9 (or newer) may indeed be needed since you have both hdmi and spd=
if.
> =

>> - snd_hda_codec_realtek module backlist (to try to disable SPDIF) =

>> /etc/modprobe.d/blacklist.conf
>> =

>> - snd_hda_codec_realtek index =3D -2 in /etc/modprobe.d/alsa-base.conf
>> =

>> - fresh new ubuntu raring install with no modifications at all: still =

>> no signal
>> =

>> B. Info:
>> =

>> cat /proc/asound/card0/codec* | grep Codec
>> Codec: Realtek ALC892
>> Codec: Intel CougarPoint HDMI
>> =

>> I use zotac ZBOX ID82 (intel HM65 chipset with hdmi and spdif)
>> =

>> with alsa debug and alsa debug verbose enabled in kernel I got the =

>> alsa-info.txt attached file produced on raring with no modification =

>> while playing dts-hd sample file with command:
>> =

>> =

>> aplay -D hdmi:CARD=3DPCH,DEV=3D0 -c8 -fs16_le -r192000 dts.spdif
> =

> As per above you need to use
> aplay -D hdmi:CARD=3DPCH,DEV=3D0,AES0=3D0x06 -c8 -fs16_le -r192000 dts.sp=
dif
> =

>> =

>> C. I add that:
>> =

>> - In every test I have non HD audio protocols (DTS and dolby) working =

>> well in the same configuration
>> =

>> - I have tried with windows just to see if my hardware is broken and I =

>> get DTS-HD audio with no problem
>> =

>> - Takashi, I've read your HD-Audio.txt file and as far as I see, I have =

>> no known error message in kernel log
>> =

>> =

>> =3D> I and Wingchao Wang have conclued that it is driver or codec =

>> related. Can you help me please?
>> =

>> Thanks a lot
>> PS: sorry if you receive this email twice, I have sent it again as I =

>> was not member of the list the first time.
> =

> =

> -- =

> Anssi Hannula
