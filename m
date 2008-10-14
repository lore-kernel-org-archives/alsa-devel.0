From: Manuel Naranjo <manuel@aircable.net>
Subject: Possible regression on Sigmatel 9205
Date: Tue, 14 Oct 2008 11:32:22 -0300
Message-ID: <48F4AD76.8010409@aircable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E9AC24535
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 16:32:49 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so1508995nfd.32
	for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2008 07:32:31 -0700 (PDT)
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

Hello everyone,

Sorry to interrupt you all, but I had been trying to get the digital mic
of my Dell Inspiron 1521 for the last 5 days without any sucess.

I'm running kernel 2.6.27 with included ALSA, I also tried GIT alsa, and
the result is the same, the mic works, but the volume is so damn low
that there's no way to hear it.

I checked dell's windows drivers and my board belongs to the M4_8 line
and not to the M4_2 as suggested in alsa source. I also did a diff
between M4_2 and M4_8 and there are some differences, specially in GPIO.

I don't know what else to do now, I had tried everything. Last working
alsa was 1.15 if I'm not wrong, but I'm not able to backport 1.15 to the
new kernel, for some reason it fails to compile.

Any help would be appreciate.

Thanks,
Manuel
