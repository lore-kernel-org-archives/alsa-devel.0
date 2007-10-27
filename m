From: "Filipe Braz" <ferlipaz@gmail.com>
Subject: ALSA dma ring buffer issue on 2.6.14
Date: Sat, 27 Oct 2007 08:26:49 -0700
Message-ID: <1678610a0710270826v5036df22q86d8be50feed4bed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 6920B245E2
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Oct 2007 17:26:50 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id b15so165295ana
	for <alsa-devel@alsa-project.org>; Sat, 27 Oct 2007 08:26:49 -0700 (PDT)
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

Hi,

I am trying to use ALSA with the OMAP2430 embedded platform, using
kernel 2.6.14 for low latency voip applications.

The problem seems to be that the driver ring buffer is not filled by
the alsa kernel/core on time to be sent to the hw codec.

So, If I use the following large buffer size / period-size it works fine:

aplay --period-size=1024 --buffer-size=8192 -f S16_LE -c 2 -r 8000 pattern.pcm

But if I use smaller buffer / period sizes such as the following it
does not work:

aplay --period-size=32 --buffer-size=128 -f S16_LE -c 2 -r 8000 pattern.pcm

aplay --period-size=32 --buffer-size=256 -f S16_LE -c 2 -r 8000 pattern.pcm

aplay --period-size=64 --buffer-size=512 -f S16_LE -c 2 -r 8000 pattern.pcm

aplay --period-size=128 --buffer-size=512 -f S16_LE -c 2 -r 8000 pattern.pcm

aplay --period-size=256 --buffer-size=1024 -f S16_LE -c 2 -r 8000 pattern.pcm

aplay --period-size=512 --buffer-size=2048 -f S16_LE -c 2 -r 8000 pattern.pcm

I am playing a special pattern sound file that I verify before each
period is transfered to the codec via dma (on the driver).
On smaller buffer sizes. the 1st period AFTER the ringbuffer rotates
to the beginning, appears to not contain the pattern data (instead is
filled with zeros). This does not happens with larger buffer /
periods.
On all cases the pattern file is large enough so that the dma ring
buffer rotates several times until transfer is complete.

I have tested this on the pc and it works just fine.
Also if I use the OSS driver for the OMAP2430 instead of the ALSA it
works fine. ALSA with OSS emulation works significantly better but
there is still some distortion.

Any ideas why this happens? Is this a known issue or is there a
solution for this problem?

Thanks in advance,
Filipe
