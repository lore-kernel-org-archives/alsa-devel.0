From: "Harsha priya gupta" <harshapriya@gmail.com>
Subject: timer + snd_pcm_period_elapsed
Date: Thu, 5 Jun 2008 15:43:07 +0530
Message-ID: <827ad74d0806050313t471ab0b2n5856db7bf8db55e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 1501A24495
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 12:13:08 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so113229and.80
	for <alsa-devel@alsa-project.org>; Thu, 05 Jun 2008 03:13:07 -0700 (PDT)
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
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

In my driver, i see that first my copy function is called some 4 times. Then
my timer starts (when trigger->start is reached). In my timer function,
snd_pcm_period_elapsed is called after the period is considered to be
processed by hardware. Everytime the period_elapsed function is called,
inturn my pointer function is called but i get the following error. can
anyone help as to what i am missing to do?

aplay: pcm_write:1266: write error: Input/output error

Can anyone hint me what i am doing wrong?

-- 
-Harsha
