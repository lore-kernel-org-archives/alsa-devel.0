From: "Vinod Koul" <vinod.koul@gmail.com>
Subject: ALSA Debugging
Date: Fri, 21 Mar 2008 20:45:11 +0530
Message-ID: <b29ed9aa0803210815g43bd5741i81ee7e5d0a04e612@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.231])
	by alsa0.perex.cz (Postfix) with ESMTP id C80AE10380A
	for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2008 16:15:17 +0100 (CET)
Received: by wx-out-0506.google.com with SMTP id t11so2019329wxc.23
	for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2008 08:15:14 -0700 (PDT)
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

Hello,
I am new to ALSA and Linux. I was trying to understand the ALSA
architecture.

I have Linux Box with Intel sound card. with Suse 10.1 on it.
I launched the audio player (Real player) and audio plays fine.

Then, I built the kernel and installed it. I put some printk's in intel8x0.cand
control.c. (could see the my code was complied)
Even though I changed volume muted etc couldn't see any of my printk in
dmesg. One default printk in intel8x0.c was there, so I have put my print
before that line as well, but couldn't see anything.

Apologies If my problem is very basic. I read on forums that best way to
learn is to put printk's.

Can anyone help me with where I am doing incorrectly, Am I supposed to do it
this way or some other way?

Thanks in advance
-Vinod
