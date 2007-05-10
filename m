From: Chris Pemberton <cjpembo@gmail.com>
Subject: alsa-driver-1.0.14rc3 won't compile with kernel
 2.6.20.3 when Processor family is Core2
Date: Wed, 09 May 2007 23:28:16 -0500
Message-ID: <46429F60.1000206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by alsa0.perex.cz (Postfix) with ESMTP id DD511244EA
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 06:28:17 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a25so405729pyi
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2007 21:28:16 -0700 (PDT)
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

Laptop has Pentium Dual Core and Intel HD Audio
Kernel is 2.6.20.3 compiled for Processor family Core2.
In-kernel alsa drivers are 1.0.14rc3 (cat /proc/asound/version) and 
compile ok.
In-kernel drivers do not work for this sound card.

Downloaded 1.0.14rc3 and applied patch_realtek.c
./configure --prefix=/usr --with-cards=hda-intel
"make" gives the following error:

make[1]: Entering directory `/usr/src/linux-2.6.20.3'
> /usr/src/linux-2.6.20.3/Makefile:491: 
> /usr/src/linux-2.6.20.3/arch//Makefile: No such file or directory


If the kernel is compiled with Processor family = Pentium M, the 
external alsa drivers compile clean and the soundcard works.

So, Processor family = Core2 cannot be selected when using external 
alsa-driver-1.0.14rc3.

Chris Pemberton
