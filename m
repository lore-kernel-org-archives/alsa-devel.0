From: William King <quentusrex@gmail.com>
Subject: Alsa 1.0.23 problems with VIA VT1708S
Date: Fri, 18 Jun 2010 15:14:57 -0600
Message-ID: <4C1BE1D1.6020304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 009CA243A1
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jun 2010 23:15:01 +0200 (CEST)
Received: by gxk5 with SMTP id 5so841334gxk.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Jun 2010 14:15:00 -0700 (PDT)
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

A few different issues with this system, but for devel and debugging I
have 3 laptops of the exact same hardware. Asus k50AB laptops with the
VIA VT1708S sound card. I am documenting as best as I can on this ubuntu
bug ticket:

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/595606

Currently the issues are:
1. Front mic does not work. No audio with any tests, even arecord test.
2. headphone jack does not work. When headphones are plugged in, the
sound continues to come out of the speakers, and no sound out of the
headphones.

I am able to test patches easily. I have just installed from source
1.0.23 release.
