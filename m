From: Uros Bizjak <ubizjak@gmail.com>
Subject: Trouble compiling alsa-driver-1.0.23 on Fedora 13
Date: Tue, 1 Jun 2010 18:47:36 +0200
Message-ID: <AANLkTikkHZto-FJv268ZnB_WI4kLoMXopSCgKFijfv8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FB4B1037E3
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Jun 2010 18:47:45 +0200 (CEST)
Received: by wwf26 with SMTP id 26so1699987wwf.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Jun 2010 09:47:36 -0700 (PDT)
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

Hello!

Trying to compile alsa-driver-1.0.23 on Fedora 13, I got following failure:

gmake -C /lib/modules/2.6.33.5-112.fc13.x86_64/source
SUBDIRS=/home/uros/alsa-driver-1.0.23  CPP="gcc -E" CC="gcc" modules
gmake[1]: Entering directory `/usr/src/kernels/2.6.33.5-112.fc13.x86_64'
Makefile:535: /usr/src/kernels/2.6.33.5-112.fc13.x86_64/arch//Makefile:
No such file or directory
gmake[1]: *** No rule to make target
`/usr/src/kernels/2.6.33.5-112.fc13.x86_64/arch//Makefile'.  Stop.
gmake[1]: Leaving directory `/usr/src/kernels/2.6.33.5-112.fc13.x86_64'
gmake: *** [compile] Error 2

I have installed required kernel-devel package.

Am I missing something else to successfully compile alsa-kernel drivers?

Thanks,
Uros.
