From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Subject: ASoC: TWL4030 audio issue with PM
Date: Wed, 11 Feb 2009 10:46:45 +0530
Message-ID: <ef0d8a250902102116t71ea79cs6c1cb94a05cee407@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 295A224478
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 06:16:47 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so20381yxh.2
	for <alsa-devel@alsa-project.org>; Tue, 10 Feb 2009 21:16:46 -0800 (PST)
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Hi Developers,

I am using 2.6.28 kernel on OMAP3430 and TWL4030 for audio (ASoC).

When i play or record a 8Khz or 48Khz file and try suspending the machine
the PM works well.

" while playing a file if the we put machine into suspend the play back
should stop and it should
start playing back from that point where it stopped when we resume our
machine"

Is this the exact behavior expected from a audio codec driver of ASoC during
kernels PM.

-- 
Cheers
(: Naveen Krishna Ch :)
