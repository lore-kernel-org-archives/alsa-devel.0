From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
Subject: Segfault in mix_areas3_smp with Edirol UA-25 in
	advance-mode
Date: Mon, 10 Dec 2007 06:35:16 +0200
Message-ID: <475CC204.4040903@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pne-smtpout4-sn1.fre.skanova.net
	(pne-smtpout4-sn1.fre.skanova.net [81.228.11.168])
	by alsa0.perex.cz (Postfix) with ESMTP id BA1882447E
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 05:35:37 +0100 (CET)
Received: from trn.iki.fi (88.195.48.158) by pne-smtpout4-sn1.fre.skanova.net
	(7.3.129) id 474FD0210006A8F3 for alsa-devel@alsa-project.org;
	Mon, 10 Dec 2007 05:35:23 +0100
Received: from trn.iki.fi (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP id 95CF345B802CE
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 06:35:36 +0200 (EET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 06:35:36 +0200 (EET)
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

No asound.conf, just the default dmix configuration. Trying to play
audio via this card randomly causes crashes. Might be a race condition
between closing the PCM at the same time as opening a new one or
something like that, but I didn't debug it further. I get this with both
Xine and GStreamer, using ALSA as audio output.

Using other sound cards or using UA-25 without advance mode=B9 there are
no segfaults.

Advanced Linux Sound Architecture Driver Version 1.0.14 (Fri Jul 20
09:12:58 2007 UTC).
alsa-lib version: 1.0.14a

GStreamer:
#0  0x00002b54714d58dc in mix_areas3_smp () from /usr/lib/libasound.so.2
#1  0x00002b54714d6477 in snd_pcm_dmix_sync_area () from
/usr/lib/libasound.so.2
#2  0x00002b54714d6a4e in snd_pcm_dmix_start () from /usr/lib/libasound.so.2
#3  0x00002b54714bff60 in snd_pcm_rate_start () from /usr/lib/libasound.so.2
#4  0x00002b54714ac357 in snd_pcm_write_areas () from
/usr/lib/libasound.so.2
#5  0x00002b54714b4ca2 in snd_pcm_mmap_writei () from
/usr/lib/libasound.so.2
#6  0x00002aaaaf89dc1c in gst_alsasink_write (asink=3D0x1bf1620,
data=3D0x1a51a40, length=3D3760) at gstalsasink.c:786
#7  0x00002aaaadf46ca0 in audioringbuffer_thread_func (buf=3D<value
optimized out>) at gstaudiosink.c:226
#8  0x00002b5472bf72b4 in g_thread_create_proxy () from
/usr/lib/libglib-2.0.so.0
#9  0x00002b547202bfe7 in start_thread () from /lib/libpthread.so.0

Xine:
#0  0x00002b9c574d88dc in mix_areas3_smp () from /usr/lib/libasound.so.2
#1  0x00002b9c574d9477 in snd_pcm_dmix_sync_area () from
/usr/lib/libasound.so.2
#2  0x00002b9c574d98fa in snd_pcm_dmix_mmap_commit () from
/usr/lib/libasound.so.2
#3  0x00002b9c574b96f0 in snd_pcm_plugin_write_areas () from
/usr/lib/libasound.so.2
#4  0x00002b9c574af29a in snd_pcm_write_areas () from
/usr/lib/libasound.so.2
#5  0x00002b9c574b9052 in snd_pcm_plugin_writei () from
/usr/lib/libasound.so.2
#6  0x00002aaaaefa8078 in ao_alsa_write () from
/usr/lib64/xine/plugins/1.1.8/xineplug_ao_out_alsa.so
#7  0x00002b9c542397a7 in ao_loop () from /usr/lib/libxine.so.1
#8  0x00002b9c5802efe7 in start_thread () from /lib/libpthread.so.0

=B9) There is a switch on this USB sound card for switching between modes.
In advance mode the device is not standard USB Audio device, but it
supports 24 bit packed samples and sample rates higher than 44.1 kHz.
Otherwise it is a standard USB audio device, but only supports 16 bit
44.1 kHz.
