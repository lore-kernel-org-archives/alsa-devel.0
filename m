From: "Fabian van der Werf" <fvanderwerf@gmail.com>
Subject: A52 plugin segfault and patch
Date: Tue, 22 May 2007 19:10:30 +0200
Message-ID: <43a13be70705221010u684ca33y4d6f176cd2c58dd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 41AE624487
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2007 19:10:32 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so2320623nzf
	for <alsa-devel@alsa-project.org>; Tue, 22 May 2007 10:10:31 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi All,

I bumped into segfault when trying to use the a52 plugin. I linked the
plugin with the latest svn revision of ffmpeg (r9102).

Starting program: /usr/bin/aplay -Dsurround test.wav
Failed to read a valid object file image from memory.
[Thread debugging using libthread_db enabled]
[New Thread -1211078432 (LWP 9835)]
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread -1211078432 (LWP 9835)]
av_crc (ctx=0x0, crc=0, buffer=0x8072c14 , length=1116) at crc.c:77
77	    if(!ctx[256])
(gdb) bt
#0  av_crc (ctx=0x0, crc=0, buffer=0x8072c14 , length=1116) at crc.c:77
#1  0xb78ce8a1 in output_frame_end (s=0x0) at ac3enc.c:1135
#2  0xb78d1010 in AC3_encode_frame (avctx=0x806d3c0, frame=0x8072c10
"\vw", buf_size=6136, data=0x806e400) at ac3enc.c:1261
#3  0xb7730f68 in avcodec_encode_audio (avctx=0x806d3c0, buf=0x8072c10
"\vw", buf_size=6136, samples=0x0) at utils.c:863
#4  0xb772f66c in convert_data (rec=0x805c868) at pcm_a52.c:57
#5  0xb7730101 in a52_transfer (io=0x805c868, areas=0x80551f0,
offset=0, size=1536) at pcm_a52.c:197
#6  0xb7efcf11 in ioplug_priv_transfer_areas (pcm=0x806c138,
areas=0x80551f0, offset=0, size=0) at pcm_ioplug.c:521
#7  0xb7efcfd6 in snd_pcm_ioplug_mmap_commit (pcm=0x806c138, offset=0,
size=1536) at pcm_ioplug.c:590
#8  0xb7ebf7b7 in snd_pcm_mmap_commit (pcm=0x0, offset=0, frames=1536)
at pcm.c:6305
#9  0xb7ecc7e4 in snd_pcm_plugin_write_areas (pcm=0x8054f48,
areas=0xbfc8ea10, offset=0, size=1536) at pcm_plugin.c:282
#10 0xb7ebfc42 in snd_pcm_write_areas (pcm=0x8054f48,
areas=0xbfc8ea10, offset=0, size=1536, func=0xb7ecc740
<snd_pcm_plugin_write_areas>) at pcm.c:6492
#11 0xb7ecbdff in snd_pcm_plugin_writei (pcm=0x8054f48,
buffer=0x8074410, size=1536) at pcm_plugin.c:353
#12 0xb7eb7da5 in snd_pcm_writei (pcm=0x8068488, buffer=0x8074410,
size=0) at pcm_local.h:401
#13 0x0804d05a in pcm_write (data=0x8074410 "", count=1536) at aplay.c:1260
#14 0x0804d66f in playback_go (fd=8, loaded=0, count=48457728,
rtype=2, name=0xbfc8fa1d "test.wav") at aplay.c:1986
#15 0x0804e9b2 in playback (name=0xbfc8fa1d "test.wav") at aplay.c:2044
#16 0x08050ea9 in main (argc=3, argv=0xbfc8ed64) at aplay.c:601

The patch below fixes this segmentation fault by adding a call to avcodec_init()

diff -Naur alsa-plugins-1.0.13/a52/pcm_a52.c
alsa-plugins-1.0.13-patched/a52/pcm_a52.c
--- alsa-plugins-1.0.13/a52/pcm_a52.c	2006-09-29 13:51:37.000000000 +0200
+++ alsa-plugins-1.0.13-patched/a52/pcm_a52.c	2007-05-22
18:49:56.000000000 +0200
@@ -676,6 +676,7 @@
 	rec->channels = channels;
 	rec->format = format;

+	avcodec_init();
 	avcodec_register_all();
 	rec->codec = avcodec_find_encoder(CODEC_ID_AC3);
 	if (! rec->codec) {

Regards,
Fabian
