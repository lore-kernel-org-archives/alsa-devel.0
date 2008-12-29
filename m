From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: Fixing the AICA driver
Date: Mon, 29 Dec 2008 19:20:16 +0000
Message-ID: <8b67d60812291120i58473762i679f5783b651f803@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f20.google.com (mail-bw0-f20.google.com
	[209.85.218.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AECD1037EC
	for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2008 20:20:17 +0100 (CET)
Received: by bwz13 with SMTP id 13so12780401bwz.8
	for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2008 11:20:16 -0800 (PST)
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
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Adrian McMenamin <adrian@newgolddream.dyndns.info>
List-Id: alsa-devel@alsa-project.org

It's about a year since I last mentioned this so I thought I'd give it
another go...

But the AICA sound driver I wrote for the Dreamcast still won't work
properly with a pure ALSA setup and I don't know why.

It works when OSS emulation is on so it appears to be some sort of
interaction with the ALSA lib layer.

The snd-summy driver also appears to work well with a 'pure' ALSA setup,
but when (for instance) I try to replay an MP3 track without OSS
emulation on I get this:

Playing MPEG stream from ms.mp3 ...
MPEG 1.0, Layer: III, Freq: 44100, mode: Joint-Stereo, modext: 2, BPF :
2560
Channels: 2, copyright: No, original: Yes, CRC: No, emphasis: 0.
Bitrate: 128 Kbits/s, Extension value: 2
Audio: 1:1 conversion, rate: 44100, encoding: signed 16 bit, channels: 2
ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to find
an usable access for 'default'
ALSA snd_pcm_hw_params_set_access error: Invalid argument
Can't find a suitable libao driver. (Is device in use?)

Any clues anyone?

Best wishes for 2009 and thanks for all help,

Adrian
