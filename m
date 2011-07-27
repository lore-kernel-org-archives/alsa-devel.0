From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [RME - hdsp] alsa-lib's hdsp.h out of sync
Date: Wed, 27 Jul 2011 19:50:38 +0200
Message-ID: <4E304FEE.4000302@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 16ABE24426
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 19:50:57 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi!

While hacking on RPM support for hdspmixer, I've noticed that alsa-lib's
hdsp.h doesn't reflect the kernel's hdsp.h: RPM is missing in
HDSP_IO_Type.

AFAIK, somebody has to regenerate alsa-lib's hdsp.h, right? Please do
so. ;)


Cheers
