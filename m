From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALSA pcm_lib.c:1789: playback write error (DMA or
 IRQ trouble?) ALSA pcm_native.c:1531: playback drain error
Date: Mon, 23 May 2011 10:46:41 +0800
Message-ID: <BANLkTi=bn7yTKLiv77iLDjHHL5puRrV3Yg@mail.gmail.com>
References: <BANLkTimEbhCw5A4kPNuqvf-KtBO=G2321w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174780bc344b0f04a3e87b9c
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EA2B1037EC
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 04:46:42 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4103508fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 22 May 2011 19:46:41 -0700 (PDT)
In-Reply-To: <BANLkTimEbhCw5A4kPNuqvf-KtBO=G2321w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--0015174780bc344b0f04a3e87b9c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2011/5/22 Raymond Yau <superquad.vortex2@gmail.com>:
> For those HDA Codec which support rate lower than 44100 Hz with prealloc =
=3D 4096
>
>
> ALSA pcm_lib.c:1789: playback write error (DMA or IRQ trouble?)
> ALSA hda_intel.c:1678: azx_pcm_prepare: bufsize=3D0xd7500, format=3D0x431=
1
>
>
> This error occr when aplay using a period time longer than 10 seconds
> ( usually occur above 12 seconds)
>
> =A0aplay -v -Dhw:1 --period-time=3D12000000 11025.wav
> Playing WAVE '11025.wav' : Signed 16 bit Little Endian, Rate 11025 Hz, St=
ereo
> Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
> Its setup is:
> =A0stream =A0 =A0 =A0 : PLAYBACK
> =A0access =A0 =A0 =A0 : RW_INTERLEAVED
> =A0format =A0 =A0 =A0 : S16_LE
> =A0subformat =A0 =A0: STD
> =A0channels =A0 =A0 : 2
> =A0rate =A0 =A0 =A0 =A0 : 11025
> =A0exact rate =A0 : 11025 (11025/1)
> =A0msbits =A0 =A0 =A0 : 16
> =A0buffer_size =A0: 264576
> =A0period_size =A0: 132288
> =A0period_time =A0: 11998911
> =A0tstamp_mode =A0: NONE
> =A0period_step =A0: 1
> =A0avail_min =A0 =A0: 132288
> =A0period_event : 0
> =A0start_threshold =A0: 264576
> =A0stop_threshold =A0 : 264576
> =A0silence_threshold: 0
> =A0silence_size : 0
> =A0boundary =A0 =A0 : 1083703296
> =A0appl_ptr =A0 =A0 : 0
> =A0hw_ptr =A0 =A0 =A0 : 0
>
>
>
>
> ALSA pcm_native.c:1531: playback drain error (DMA or IRQ trouble?)
> ALSA hda_intel.c:1678: azx_pcm_prepare: bufsize=3D0x400000, format=3D0x51=
1
>
> This error occur with speaker-test which use maximum buffer size
>
> speaker-test -d -c 2 -t sine --rate=3D8000 -Dhw:CARD=3DIntel
>
> speaker-test 1.0.24.2
>
> Playback device is hw:CARD=3DIntel
> Stream parameters are 8000Hz, S16_LE, 2 channels
> Sine wave rate is 440.0000Hz
> Rate set to 8000Hz (requested 8000Hz)
> Buffer size range from 64 to 1048576
> Period size range from 32 to 524288
> Using max buffer size 1048576
> Periods =3D 4
> was set period_size =3D 262144
> was set buffer_size =3D 1048576
> Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
> Its setup is:
> =A0stream =A0 =A0 =A0 : PLAYBACK
> =A0access =A0 =A0 =A0 : RW_INTERLEAVED
> =A0format =A0 =A0 =A0 : S16_LE
> =A0subformat =A0 =A0: STD
> =A0channels =A0 =A0 : 2
> =A0rate =A0 =A0 =A0 =A0 : 8000
> =A0exact rate =A0 : 8000 (8000/1)
> =A0msbits =A0 =A0 =A0 : 16
> =A0buffer_size =A0: 1048576
> =A0period_size =A0: 262144
> =A0period_time =A0: 32768000
> =A0tstamp_mode =A0: NONE
> =A0period_step =A0: 1
> =A0avail_min =A0 =A0: 262144
> =A0period_event : 0
> =A0start_threshold =A0: 1048576
> =A0stop_threshold =A0 : 1048576
> =A0silence_threshold: 0
> =A0silence_size : 0
> =A0boundary =A0 =A0 : 1073741824
> =A0appl_ptr =A0 =A0 : 0
> =A0hw_ptr =A0 =A0 =A0 : 0
> =A00 - Front Left
> =A01 - Front Right
> Time per period =3D 20.075443
>

Fix is similar to commit ca1f30ad6c3f002d1d9b9355a53b8bbf2fe70588

--0015174780bc344b0f04a3e87b9c
Content-Type: application/octet-stream;
	name="0001-Add-period-time-constraints-to-snd-hda-intel-to-avoi.patch"
Content-Disposition: attachment;
	filename="0001-Add-period-time-constraints-to-snd-hda-intel-to-avoi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_go0tdqxg0

RnJvbSA1OTg1OTUzODJkOTVjMGY2ZjE5N2ViMDNjMDkzZTc3NjgzYTljMWExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYXltb25kIFlhdSA8c3VwZXJxdWFkLnZvcnRleDJAZ21haWwu
Y29tPgpEYXRlOiBNb24sIDIzIE1heSAyMDExIDEwOjEyOjI0ICswODAwClN1YmplY3Q6IFtQQVRD
SCAtIEFMU0EgaGRhIDEvMV0gQWRkIHBlcmlvZCB0aW1lIGNvbnN0cmFpbnRzIHRvIHNuZC1oZGEt
aW50ZWwgdG8gYXZvaWQgKERNQSBvciBJUlEgdHJvdWJsZSkgd2hlbiBhcHBsaWNhdGlvbiByZXF1
ZXN0IGEgcGVyaW9kIHRpbWUgd2hpY2ggaXMgYWJvdmUgYWxzYS1rZXJuZWwncyBsaW1pdGF0aW9u
CgoKU2lnbmVkLW9mZi1ieTogUmF5bW9uZCBZYXUgPHN1cGVycXVhZC52b3J0ZXgyQGdtYWlsLmNv
bT4KCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaGRhL2hkYV9pbnRlbC5jIGIvc291bmQvcGNpL2hk
YS9oZGFfaW50ZWwuYwppbmRleCA0M2EwMzY3Li42YjJiNjQyIDEwMDY0NAotLS0gYS9zb3VuZC9w
Y2kvaGRhL2hkYV9pbnRlbC5jCisrKyBiL3NvdW5kL3BjaS9oZGEvaGRhX2ludGVsLmMKQEAgLTE1
ODcsNiArMTU4Nyw4IEBAIHN0YXRpYyBpbnQgYXp4X3BjbV9vcGVuKHN0cnVjdCBzbmRfcGNtX3N1
YnN0cmVhbSAqc3Vic3RyZWFtKQogCQkJCSAgIDEyOCk7CiAJc25kX3BjbV9od19jb25zdHJhaW50
X3N0ZXAocnVudGltZSwgMCwgU05EUlZfUENNX0hXX1BBUkFNX1BFUklPRF9CWVRFUywKIAkJCQkg
ICAxMjgpOworCXNuZF9wY21faHdfY29uc3RyYWludF9taW5tYXgKKwkJCShydW50aW1lLCBTTkRS
Vl9QQ01fSFdfUEFSQU1fUEVSSU9EX1RJTUUsIDAsIDgxOTIwMDApOwogCXNuZF9oZGFfcG93ZXJf
dXAoYXBjbS0+Y29kZWMpOwogCWVyciA9IGhpbmZvLT5vcHMub3BlbihoaW5mbywgYXBjbS0+Y29k
ZWMsIHN1YnN0cmVhbSk7CiAJaWYgKGVyciA8IDApIHsKLS0gCjEuNi4wLjYKCg==
--0015174780bc344b0f04a3e87b9c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0015174780bc344b0f04a3e87b9c--
