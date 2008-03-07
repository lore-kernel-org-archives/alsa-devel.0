From: "Jinyoung Park" <mcjin02@gmail.com>
Subject: What recommended performance for ALSA(ASoC)?
Date: Fri, 7 Mar 2008 11:01:21 +0900
Message-ID: <280b69ac0803061801o4ef80585mdd8b7753ab40be8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C1A81038EF
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 03:01:23 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 25so309921wfa.23
	for <alsa-devel@alsa-project.org>; Thu, 06 Mar 2008 18:01:21 -0800 (PST)
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

Hello, I tred developing new ALSA(ASoC) driver for our company's
embedded processor.
Our processor supported I2S and DMA. So, my ALSA drvier implementation
using DMA.
I was tested my ALSA driver. When I play wav file(sample rate 44100)
using aplay( aplay -M -D hw:0,0 test.wav), sometimes occured breaks.
Also, play mp3 file(sample rate 44100Hz) using madplay and mpg123,
sometimes occured noises.
So, I was tested wav file and mp3 file that down sampling 44100 ->
22050. They was not occurring break and decreasing noises.
I tried improving my ALSA driver, optimize souce code and change
variety buffer size and period size. But It doesn't improve much.
In my guess, my target system is not enough performance because ALSA is heavy.
Target system' processor(ARM9) clock is 200MHz and BogoMIPS is
99.6(cat /proc/cpuinfo). Linux kernel version is 2.6.24.1.

What recommended performance for ALSA(ASoC)?
If my target system is enough performance, shall I do that solve problem?

Thanks.
