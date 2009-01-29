From: maarten van es <maarten.h.van.es@gmail.com>
Subject: set_params:1073: not enough memory
Date: Thu, 29 Jan 2009 22:43:05 +0000
Message-ID: <bca65b460901291443h4bbcbd36p683614a7d9770f45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AD71103890
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 23:43:06 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id 26so148911fkx.0
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 14:43:05 -0800 (PST)
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

Hello all,

I am trying to get alsa to work using buildroot to crosscompile to
i686-linux-uclibc. I am using the latest git version of alsa-lib and a
recent git version of alsa-util. I am stuck with the same error as in
the message included below when using aplay. So far I have been able
to narrow this down to the function set_params in aplay.c, lines 1070,
1071:

chunk_bytes = chunk_size * bits_per_frame / 8;
audiobuf = realloc(audiobuf, chunk_bytes);

chunk_size is 0 here and obviously the realloc fails.

Any ideas on what's going on here?

For the record, "aplay -L" lists the correct devices, "aplay -D null
test.wav" works ok and the card works correctly using alsa version
1.0.16 on standard suse 11.0.

Best regards
Maarten van Es




Hello all,

I'm trying to get alsa 1.0.18 working on a ARM PXA processor and I'm
stuck with the following error message:

aplay /Sinus.raw -fcd
Playing raw data '/Sinus.raw' : Signed 16 bit Little Endian, Rate 44100
Hz, Stereo
aplay: set_params:1073: not enough memory

alsa kernel was compiled with alsa 1.0.16, alsa.conf, located in
/usr/share/alsa is the basic:

pcm.!default {
	type hw
	card 0
	}

	ctl.!default {
	type hw
	card 0
         }

also aplay -l and alsaconf store show the message:

ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL hw:0

However the card shows up /proc/asound/cards and alsamixer is able to
access it.

Any ideas?

Best regards

Michael
