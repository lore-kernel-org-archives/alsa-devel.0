From: "Nie Jun" <niej0001@gmail.com>
Subject: noise and consume pcm faster
Date: Tue, 2 Sep 2008 17:00:19 +0800
Message-ID: <7c34ac520809020200l290f78d3l5e7146bfb567e739@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 2EB0D10381C
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 11:00:22 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 21so814566eyc.56
	for <alsa-devel@alsa-project.org>; Tue, 02 Sep 2008 02:00:19 -0700 (PDT)
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
    I found a strange issue that ALSA consume pcm data faster than
normal. Does any one had come across it?

    When I sychronize video frame against audio, the video thread will
check how much pcm data has been written to ALSA API but has not been
fetched by DMA. This query causes ALSA consume pcm data faster than
normal, noise appears too. A stream that is 131 seconds will playback
just 112 seconds. It only appears when audio is stereo and sampling
rate is directly supported by hardware.

This bug can be reproduced with aplay. To reproduce it with aplay, you
just need to add a thread and query the ALSA latency 20~30times every
second.

My system: XSCALE PXA300/zylonite, Linux2.6.25, alsa-lib-1.0.13(I
tried alsa-lib-1.0.17, bugs too), codec: wm9713. Linux2.6.14 has this
issue too, but I did not find it in 2.6.21 and 2.6.24.

Does anyone has idea about it? Thanks!

Jun Nie
