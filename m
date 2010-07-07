From: Felix Homann <fexpop@web.de>
Subject: Re: [PATCH - Fix Fast Track Ultra series: 44.1/88.1
 kHz 1/Fix playback/capture issues and related chrashes at 44100 Hz and
 88200 Hz for M-Audio Fast Track Ultra series.
Date: Wed, 07 Jul 2010 18:55:19 +0200
Message-ID: <4C34B177.1090500@web.de>
References: <4C32E3B2.5080707@web.de>
	<4C344340.8060804@web.de>	<4C3476BD.4090702@ladisch.de>
	<4C347EF7.2030401@web.de> <4C348DC6.7070602@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp188.webpack.hosteurope.de (wp188.webpack.hosteurope.de
	[80.237.132.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 05C0424562
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 18:55:21 +0200 (CEST)
In-Reply-To: <4C348DC6.7070602@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Felix Homann <fexpop@web.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Building Alsa fails after applying your patch:


[...]
make[2]: Entering directory 
`/home/felix/workspace/Alsa/Ladisch/alsa-driver/usb'
copying file alsa-kernel/usb/quirks.c
patching file quirks.c
Hunk #2 FAILED at 159.
Hunk #3 succeeded at 235 (offset 5 lines).
Hunk #4 succeeded at 325 (offset 6 lines).
Hunk #5 succeeded at 343 (offset 6 lines).
Hunk #6 succeeded at 357 (offset 6 lines).
Hunk #7 succeeded at 370 (offset 6 lines).
1 out of 7 hunks FAILED -- saving rejects to file quirks.c.rej
make[2]: *** [quirks.c] Fehler 1
make[2]: Leaving directory 
`/home/felix/workspace/Alsa/Ladisch/alsa-driver/usb'
make[1]: *** [dep] Fehler 1
make[1]: Leaving directory `/home/felix/workspace/Alsa/Ladisch/alsa-driver'
make: *** [include/sndversions.h] Fehler 2


Am 07.07.2010 16:23, schrieb Clemens Ladisch:
>
> There must be some difference, and I'd really like to know what it is.
> Please load the driver with the patch below, with and without the
> AUDIO_FIXED_ENDPOINT patch, and show what it prints to the system log.
>
>    
