From: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Subject: Custom IOCTL call
Date: Fri, 10 Dec 2010 11:42:30 -0800
Message-ID: <AANLkTinRmEkLL8Lhp9uZVCWjn2Z3Qh0cgwKZGqJG8o0p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 982EC10380C
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 20:42:30 +0100 (CET)
Received: by wwe15 with SMTP id 15so3860151wwe.20
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 11:42:30 -0800 (PST)
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

I am writing custom IOCTL calls for my card. I have made hwdep interface and
set ioctl ops call for it. But, now the question is which device I need to
open in my user space app to talk to correct ioctl?
I have tried /dev/snd/controlC0
and /dev/snd/pcmC0D0p
Both of theses returned invalid IOCTL.
Cheers
Ogi
