From: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Subject: dshare plugin issue in alsa-lib.1.0.27
Date: Mon, 8 Jun 2015 09:24:22 +0000
Message-ID: <HKXPR04MB277D49222F18C9F80D44F6BC3BF0@HKXPR04MB277.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_HKXPR04MB277D49222F18C9F80D44F6BC3BF0HKXPR04MB277apcprd_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from APAC01-SG1-obe.outbound.protection.outlook.com
 (mail-sg1on0136.outbound.protection.outlook.com [134.170.132.136])
 by alsa0.perex.cz (Postfix) with ESMTP id E959D2606A5
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 11:24:26 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-audio-dev@lists.linuxaudio.org" <linux-audio-dev@lists.linuxaudio.org>
List-Id: alsa-devel@alsa-project.org

--_004_HKXPR04MB277D49222F18C9F80D44F6BC3BF0HKXPR04MB277apcprd_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear Clemens,


Thanks a lot for all your suggestions w.r.t the thread [alsa-devel] Fw: Usi=
ng loopback card to Connect GSM two way call to the real sound card UDA1345=
TS


Could you please provide some suggestions or guidance w.r.t the below issue


Now am using linux kernel version 3.14 with alsa-lib.1.0.27


I feel dshare plugin is not working now with this linux kernel & alsa-lib v=
ersion ,


When I try to run theaplay -D VOUTR NeroSoundTrax_test8_PCM_Mono_VBR_16SS_4=
8000Hz.wav


I don't get any errors, but it seems that audio is playing but I don't hear=
 any audio


But when I run the same in linux kernel version 3.12 with alsa-lib.1.0.26, =
I hear the audio output



wav @am335x-evm:/# aplay -D VOUTR NeroSoundTrax_test8_PCM_Mono_VBR_16SS_480=
00Hz.w
[  876.513092] DAVINCIIIIIIIIII UDA134XXXXX SYSCLK=3D12288000
[  876.518771] DAVINCIIIIIIIIII UDA134XXXXX BCLK FREQQ=3D1536000
[  876.524777] DAVINCIIIIIIIIII UDA134XXXXX SYSCLK/BCLK_FREQ =3D8
[  876.530813] uda134x_hw_params CLOCKS uda134x_hw_params uda134x->sysclk: =
12288000, params_rate(params):48000
[  876.541191] uda134x_hw_params FORMATS uda134x_hw_params dai_fmt: 16385, =
params_format:2
[  876.549720] uda134x_hw_params FORMATS uda134x_hw_params uda134x->sysclk =
/ params_rate(params) 256
[  876.559165] UDA1345TSSSSSSSSSSSS SYSCLK / fs ratio is 256
[  876.564929] uda134x_hw_params dai_fmt: 16385, params_format:2
[  876.571029] UDA1345TSSSSSSSSSSSS FORMAT SND_SOC_DAIFMT_I2S
[  876.577006] ENTERED davinci_config_channel_size davinci_config_channel_s=
ize: tx_rotate =3D 4
[  876.585812] ENTERED davinci_config_channel_size davinci_config_channel_s=
ize: MASK=3D 65535
[  876.598147] uda134x_unnnnnnnnmuteeeeeeeeee uda134x_mute mute: 0
[  876.605173] davinci_mcasp_starttttttttttttttttttttt SNDRV_PCM_STREAM_PLA=
YBACK
Playing WAVE 'NeroSoundTrax_test8_PCM_Mono_VBR_16SS_48000Hz.wav' : Signed 1=
6 bit Little Endian, Rate 48000 Hz, Mono


I have tired the following:


Firstly, I have tried with basic arecord & aplay in linux kernel version 3.=
14 that works, without the above asound.conf


I have even tried with combination's of  linux kernel version 3.14 & alsa-l=
ib-1.0.26 & linux kernel verison 3.12 with alsa-lib-1.0.27 that didn't work=
, with the above asound.conf


Now I feel, it seems to be there is an dependency issue with alsa-lib.1.0.2=
7


So, could you please try from your end with linux kernel version 3.14 with =
the above asound.conf with above alsalib version & please let  me know whet=
her it works or not?


If not, Could you please let me know how to get this thing working with lin=
ux kernel 3.14 (as all my development activities are being done in linux 3.=
14)


Kindly do the needful as early as possible, as am stuck with this from many=
 day's


Many Many Thanks in advance,


--_004_HKXPR04MB277D49222F18C9F80D44F6BC3BF0HKXPR04MB277apcprd_
Content-Type: text/plain; name="asound.txt"
Content-Description: asound.txt
Content-Disposition: attachment; filename="asound.txt"; size=743;
	creation-date="Mon, 08 Jun 2015 09:21:41 GMT";
	modification-date="Mon, 08 Jun 2015 09:21:41 GMT"
Content-Transfer-Encoding: base64

cGNtLmNhcmQwIHsKICAgIHR5cGUgaHcKICAgICAgY2FyZCAwCiAgICAKfQoKY3RsLmNhcmQwIHsK
ICAgIHR5cGUgaHcKICAgICAgY2FyZCAwCiAgICAgIAp9CgpwY20uVk9VVEwgewogICAgdHlwZSBk
c2hhcmUKICAgICAgaXBjX2tleSA2Njc4MjkzCiAgICAgIGlwY19rZXlfYWRkX3VpZCB5ZXMKICAg
ICAgc2xhdmUgewogICAgICAgICAgcGNtICJodzowIgogICAgICAgICAgY2hhbm5lbHMgMgogICAg
ICB9CiAgICBiaW5kaW5ncyB7CiAgICAgICAgMCAxCiAgICB9Cn0KCnBjbS5WT1VUUiB7CiAgICB0
eXBlIGRzaGFyZQogICAgICBpcGNfa2V5IDY2NzgyOTMKICAgICAgaXBjX2tleV9hZGRfdWlkIHll
cwogICAgICBzbGF2ZSB7CiAgICAgICAgICBwY20gImh3OjAiCgkgIGNoYW5uZWxzIDIKICAgICAg
fQogICAgYmluZGluZ3MgewogICAgICAgIDAgMAogICAgfQp9CgoKcGNtLlZJTkwgewogICAgdHlw
ZSBkc25vb3AKICAgICAgaXBjX2tleSAzMgogICAgICBzbGF2ZSB7CiAgICAgICAgICBwY20gImNh
cmQwIgogICAgICAgICAgICBjaGFubmVscyAyCiAgICAgIH0KICAgIGJpbmRpbmdzLjAgIDAKfQoK
cGNtLlZJTlIgewogICAgdHlwZSBkc25vb3AKICAgICAgaXBjX2tleSAzMgogICAgICBzbGF2ZSB7
CiAgICAgICAgICBwY20gImNhcmQwIgogICAgICAgICAgICBjaGFubmVscyAyCiAgICAgIH0KICAg
IGJpbmRpbmdzLjAgIDEKfQoKCgoKcGNtLiFkZWZhdWx0IFZPVVRSCnBjbS4hZGVmYXVsdCBWT1VU
TAo=

--_004_HKXPR04MB277D49222F18C9F80D44F6BC3BF0HKXPR04MB277apcprd_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--_004_HKXPR04MB277D49222F18C9F80D44F6BC3BF0HKXPR04MB277apcprd_--
