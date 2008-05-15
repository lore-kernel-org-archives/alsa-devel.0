From: "Alan Lu" <alanlu001@gmail.com>
Subject: ASoC problem
Date: Thu, 15 May 2008 12:02:46 +0800
Message-ID: <ddeffb610805142102q5f19d120qd7e73c9babb838d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 22EE724668
	for <alsa-devel@alsa-project.org>;
	Thu, 15 May 2008 06:02:47 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id j3so147017tid.8
	for <alsa-devel@alsa-project.org>; Wed, 14 May 2008 21:02:46 -0700 (PDT)
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

I built linux-2.6.25.2 kernel with ASoC driver for SMDK2412 board.
 The following is dmesg,

  Advanced Linux Sound Architecture Driver Version 1.0.16rc2 (Thu Jan 31
16:40:16
ASoC version 0.13.2

ALSA device
list:
  No soundcards found.

 I traced the soc_core.c and it never reaches soc_probe() routine.
 That's why "No soundcards found."

 Could you give me some light ?

 Appreciated!
