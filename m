From: LANGLOIS Olivier PIS -EXT <olivier.pis.langlois@transport.alstom.com>
Subject: Re: [PATCH v3 0/5] ALSA: hda - hdmi: ATI/AMD
 multi-channel and HBR support
Date: Tue, 29 Oct 2013 19:52:30 +0000
Message-ID: <89F8E4011FD7234ABFE48744E300CBC206B7FFCA@041-DB3MPN1-092.041d.mgd.msft.net>
References: <20131025165452.GA89428@deflower.internal>
 <526AA924.5070508@iki.fi> <20131028175206.GA70365@localhost>
 <526EA91B.3090607@iki.fi> <20131028181743.GA70502@localhost>
 <526EAC12.5000905@iki.fi> <20131028183554.GB70502@localhost>
 <526ECAAC.306@iki.fi> <20131028220045.GA71497@localhost>
 <526EE844.4030608@iki.fi> <20131028231552.GA72034@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from as-smtp2.itc.alstom.com (as-smtp2.itc.alstom.com
 [159.245.16.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 17B022615D1
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 20:52:35 +0100 (CET)
In-Reply-To: <20131028231552.GA72034@localhost>
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
To: Andre Heider <a.heider@gmail.com>, Anssi Hannula <anssi.hannula@iki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, =?iso-8859-1?Q?Peter_Fr=FChberger?= <fritsch@xbmc.org>
List-Id: alsa-devel@alsa-project.org

> >
> > Yep. I did manually verify that your EDID really claims AAC support,
> > though. It could be wrong I guess, and the reported max_bitrate is
> > suspiciously the same as for AC-3.
> >
> > If you want to try AAC bitstreaming, you can download this:
> > http://onse.fi/files/testi.aac.lc.unconfirmed.spdif
> > and play it back using:
> > aplay -Dhdmi:CARD=Generic,DEV=0,AES0=6 -r44100 -f s16_le -c2 \
> >     testi.aac.lc.unconfirmed.spdif
> >
> > (file unconfirmed as I don't have AAC HW)
>
> That looks like its playing something, but there's no sound at all. The receiver
> claims there's a Dolby Digital stream active while that aplay command is
> running... so yeah, looks like the EDID is lying.
> (Same with another raw AAC LE file I just googled).
>
> But on the good side, multichannel AC3 and DTS passthrough is working
> flawlessly with XBMC ;)
>
> Thanks again,
> Andre

Just throwing an idea like this. There is a small voice telling me that maybe HDMI receiver supporting AAC expect it wrapped inside ADTS packets rather than just raw AAC stream.

Also note that ffmpeg report formatting problem:

lano1106@hpmini ~ $ ffprobe testi.aac.lc.unconfirmed.spdif
ffprobe version 2.1 Copyright (c) 2007-2013 the FFmpeg developers
  built on Oct 29 2013 15:37:36 with gcc 4.8.2 (GCC)
  configuration: --prefix=/usr --disable-debug --disable-static --enable-avresample --enable-dxva2 --enable-fontconfig --enable-gnutls --enable-gpl --enable-libass --enable-libfreetype --enable-libgsm --enable-libmodplug --enable-libmp3lame --enable-libopencore_amrnb --enable-libopencore_amrwb --enable-libopenjpeg --enable-libopus --enable-libpulse --enable-librtmp --enable-libschroedinger --enable-libspeex --enable-libtheora --enable-libv4l2 --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libxvid --enable-pic --enable-postproc --enable-runtime-cpudetect --enable-shared --enable-swresample --disable-vdpau --disable-vaapi --arch=native --cpu=native --enable-version3 --enable-x11grab
  libavutil      52. 48.100 / 52. 48.100
  libavcodec     55. 39.100 / 55. 39.100
  libavformat    55. 19.104 / 55. 19.104
  libavdevice    55.  5.100 / 55.  5.100
  libavfilter     3. 90.100 /  3. 90.100
  libavresample   1.  1.  0 /  1.  1.  0
  libswscale      2.  5.101 /  2.  5.101
  libswresample   0. 17.104 /  0. 17.104
  libpostproc    52.  3.100 / 52.  3.100
[spdif @ 0x8afc6b0] Invalid AAC packet in IEC 61937
testi.aac.lc.unconfirmed.spdif: Invalid data found when processing input


________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may be privileged. If you are not a named recipient, please notify the sender immediately and do not disclose the contents to another person, use it for any purpose or store or copy the information in any medium.
