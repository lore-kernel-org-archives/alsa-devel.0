From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: hda- Disable Sticky PCM
Date: Sat, 17 Sep 2011 11:16:28 +0800
Message-ID: <CAN8cciZ97BshNeH7DgN4pp7gu7jhn_zxs7fAfDUtvcuOannc3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BB4E10383D
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Sep 2011 05:16:29 +0200 (CEST)
Received: by fxe22 with SMTP id 22so2323278fxe.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2011 20:16:28 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/15 Takashi Iwai <tiwai@suse.de>:
> At Thu, 15 Sep 2011 22:23:12 +0800,
> Raymond Yau wrote:
>>
>> BTW, there is some strange behaviour of the non-sticky pcm
>> implementation on ad1988
>>
>> Refer to commit 0e7adbe263f89ea2ef15b5af5e80a812b2a85025
>>
>> Disable sticky PCM stream assignment for AD codecs
>>
>> why hda_codec_cleanup_stream is called twice =A0and this also occur with
>> capture and playback
>
> Isn't it just the power-save? =A0The suspend calls
> hda_cleanup_all_streams().
>
> That is, the first call is the normal one, and it doesn't clean up the
> stream actually because of stickiness. =A0The second call is the real
> cleanup at power-saving.
>
>
> Takashi
>

by adding prinkt statement in really cleanup steam() function,
really_cleanup_stream is called twice
so why is second call if the stream is already really cleanup


ALSA hda_intel.c:1755: azx_pcm_prepare: bufsize=3D0x10000, format=3D0x4011
ALSA hda_codec.c:1412: hda_codec_setup_stream: NID=3D0x4, stream=3D0x5,
channel=3D0, format=3D0x4011
ALSA hda_codec.c:1412: hda_codec_setup_stream: NID=3D0x3, stream=3D0x5,
channel=3D0, format=3D0x4011
ALSA hda_codec.c:1412: hda_codec_setup_stream: NID=3D0x6, stream=3D0x5,
channel=3D0, format=3D0x4011
ALSA hda_codec.c:1412: hda_codec_setup_stream: NID=3D0x5, stream=3D0x5,
channel=3D0, format=3D0x4011
ALSA hda_codec.c:1412: hda_codec_setup_stream: NID=3D0xa, stream=3D0x5,
channel=3D0, format=3D0x4011
ALSA hda_codec.c:1475: hda_codec_cleanup_stream: NID=3D0x4
really cleanup steam
ALSA hda_codec.c:1475: hda_codec_cleanup_stream: NID=3D0x6
really cleanup steam
ALSA hda_codec.c:1475: hda_codec_cleanup_stream: NID=3D0x5
really cleanup steam
ALSA hda_codec.c:1475: hda_codec_cleanup_stream: NID=3D0xa
really cleanup steam
ALSA hda_codec.c:1475: hda_codec_cleanup_stream: NID=3D0x3
really cleanup steam
ALSA hda_codec.c:1475: hda_codec_cleanup_stream: NID=3D0x4
really cleanup steam
ALSA hda_codec.c:1475: hda_codec_cleanup_stream: NID=3D0x6
really cleanup steam
ALSA hda_codec.c:1475: hda_codec_cleanup_stream: NID=3D0x5
really cleanup steam
ALSA hda_codec.c:1475: hda_codec_cleanup_stream: NID=3D0xa
really cleanup steam
ALSA hda_codec.c:1475: hda_codec_cleanup_stream: NID=3D0x3
really cleanup steam
