From: Adish Kuvelker <adkuvi@gmail.com>
Subject: snddevices issue
Date: Tue, 29 Jun 2010 20:17:42 +0530
Message-ID: <AANLkTikzjyDqClZopaTvVmT7wwazRHE4K3XbH2m48rgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0A783246C4
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jun 2010 16:47:45 +0200 (CEST)
Received: by vws11 with SMTP id 11so4843225vws.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Jun 2010 07:47:43 -0700 (PDT)
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

I find that the device nodes created in the /dev/snd for Control,
Timer and pcmC0D0 have different minor numbers from the class devices
created by the ALSA core. I just did kernel prints to capture the
minor numbers of audio Control, Timer and pcmC0D0p creatd by ALSA core
and found that they are different.

My ALSA core version is ALSA 1.0.13 and the snddevices file is also
from the ALSA 1.0.13. How do I do a workabout for this?

Regards;
Aadish
