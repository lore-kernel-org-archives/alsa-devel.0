From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Tue, 29 Oct 2013 22:30:49 +0200
Message-ID: <52701AF9.8080306@iki.fi>
References: <20131025165452.GA89428@deflower.internal>
 <526AA924.5070508@iki.fi> <20131028175206.GA70365@localhost>
 <526EA91B.3090607@iki.fi> <20131028181743.GA70502@localhost>
 <526EAC12.5000905@iki.fi> <20131028183554.GB70502@localhost>
 <526ECAAC.306@iki.fi> <20131028220045.GA71497@localhost>
 <526EE844.4030608@iki.fi> <20131028231552.GA72034@localhost>
 <89F8E4011FD7234ABFE48744E300CBC206B7FFCA@041-DB3MPN1-092.041d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040202090504010104020206"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 63E472615D1
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 21:30:57 +0100 (CET)
In-Reply-To: <89F8E4011FD7234ABFE48744E300CBC206B7FFCA@041-DB3MPN1-092.041d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: LANGLOIS Olivier PIS -EXT <olivier.pis.langlois@transport.alstom.com>, Andre Heider <a.heider@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, =?ISO-8859-1?Q?Peter_Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040202090504010104020206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

29.10.2013 21:52, LANGLOIS Olivier PIS -EXT kirjoitti:
>>>
>>> Yep. I did manually verify that your EDID really claims AAC support,
>>> though. It could be wrong I guess, and the reported max_bitrate is
>>> suspiciously the same as for AC-3.
>>>
>>> If you want to try AAC bitstreaming, you can download this:
>>> http://onse.fi/files/testi.aac.lc.unconfirmed.spdif
>>> and play it back using:
>>> aplay -Dhdmi:CARD=Generic,DEV=0,AES0=6 -r44100 -f s16_le -c2 \
>>>     testi.aac.lc.unconfirmed.spdif
>>>
>>> (file unconfirmed as I don't have AAC HW)
>>
>> That looks like its playing something, but there's no sound at all. The receiver
>> claims there's a Dolby Digital stream active while that aplay command is
>> running... so yeah, looks like the EDID is lying.
>> (Same with another raw AAC LE file I just googled).

Note that compressed audio (except some cases of DTS) requires IEC-61937
encapsulation before output (this can be done e.g. with ffmpeg, "-f
spdif"). Not sure if the other file you got was like that, maybe.

But yes, looks like the receiver lies in EDID.

>> But on the good side, multichannel AC3 and DTS passthrough is working
>> flawlessly with XBMC ;)
>>
>> Thanks again,
>> Andre
> 
> Just throwing an idea like this. There is a small voice telling me that maybe HDMI receiver supporting AAC expect it wrapped inside ADTS packets rather than just raw AAC stream.

Yep, and my sample file is ADTS :)

> Also note that ffmpeg report formatting problem:
> 
> lano1106@hpmini ~ $ ffprobe testi.aac.lc.unconfirmed.spdif
> ffprobe version 2.1 Copyright (c) 2007-2013 the FFmpeg developers
>   built on Oct 29 2013 15:37:36 with gcc 4.8.2 (GCC)
>   configuration: --prefix=/usr --disable-debug --disable-static --enable-avresample --enable-dxva2 --enable-fontconfig --enable-gnutls --enable-gpl --enable-libass --enable-libfreetype --enable-libgsm --enable-libmodplug --enable-libmp3lame --enable-libopencore_amrnb --enable-libopencore_amrwb --enable-libopenjpeg --enable-libopus --enable-libpulse --enable-librtmp --enable-libschroedinger --enable-libspeex --enable-libtheora --enable-libv4l2 --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libxvid --enable-pic --enable-postproc --enable-runtime-cpudetect --enable-shared --enable-swresample --disable-vdpau --disable-vaapi --arch=native --cpu=native --enable-version3 --enable-x11grab
>   libavutil      52. 48.100 / 52. 48.100
>   libavcodec     55. 39.100 / 55. 39.100
>   libavformat    55. 19.104 / 55. 19.104
>   libavdevice    55.  5.100 / 55.  5.100
>   libavfilter     3. 90.100 /  3. 90.100
>   libavresample   1.  1.  0 /  1.  1.  0
>   libswscale      2.  5.101 /  2.  5.101
>   libswresample   0. 17.104 /  0. 17.104
>   libpostproc    52.  3.100 / 52.  3.100
> [spdif @ 0x8afc6b0] Invalid AAC packet in IEC 61937
> testi.aac.lc.unconfirmed.spdif: Invalid data found when processing input

FFmpeg bug. Patch attached (and sent to ffmpeg-devel@).

-- 
Anssi Hannula


--------------040202090504010104020206
Content-Type: text/x-patch;
 name="0001-lavf-spdifdec-fix-demuxing-of-AAC-in-IEC-61937.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-lavf-spdifdec-fix-demuxing-of-AAC-in-IEC-61937.patch"

>From 24f271570ec3fb533126b22649651b52160ac232 Mon Sep 17 00:00:00 2001
From: Anssi Hannula <anssi.hannula@iki.fi>
Date: Tue, 29 Oct 2013 22:22:34 +0200
Subject: [PATCH] lavf/spdifdec: fix demuxing of AAC in IEC 61937

Return value of avpriv_aac_parse_header() is not checked correctly. Fix
it.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
 libavformat/spdifdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libavformat/spdifdec.c b/libavformat/spdifdec.c
index 6984350..7da16c9 100644
--- a/libavformat/spdifdec.c
+++ b/libavformat/spdifdec.c
@@ -57,7 +57,7 @@ static int spdif_get_offset_and_codec(AVFormatContext *s,
         break;
     case IEC61937_MPEG2_AAC:
         init_get_bits(&gbc, buf, AAC_ADTS_HEADER_SIZE * 8);
-        if (avpriv_aac_parse_header(&gbc, &aac_hdr)) {
+        if (avpriv_aac_parse_header(&gbc, &aac_hdr) < 0) {
             if (s) /* be silent during a probe */
                 av_log(s, AV_LOG_ERROR, "Invalid AAC packet in IEC 61937\n");
             return AVERROR_INVALIDDATA;
-- 
1.8.1.5


--------------040202090504010104020206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040202090504010104020206--
