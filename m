From: ABDUL MOIZ <abdulmoiz786@gmail.com>
Subject: USB mic delay problem on OMAP4 PandaBoard
Date: Fri, 5 Aug 2011 13:04:15 +0530
Message-ID: <CADw9Y1eEDA4mZOX=uyqPHd_N8nn=O_mpMnfR8ZBRVjMPK+rJBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E081D10397B
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Aug 2011 09:34:18 +0200 (CEST)
Received: by yib12 with SMTP id 12so1421818yib.38
	for <alsa-devel@alsa-project.org>; Fri, 05 Aug 2011 00:34:16 -0700 (PDT)
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

       I am working on OMAP4 platform (Panda Board) using ubuntu
10.10(kernel: 2.6.35) and recording audio with USB mic and getting the
following problem:

When I am recording with the arecord utility as shown below:

*$ arecord -Dplughw:1,0 -f cd foo.wav
*
audio is recorded with XRUN.

So we have tested by changing buffer size and period size as shown below,

*$ arecord -Dplughw:1,0 -f cd --buffer-size=65536 --period-size=128 foo.wav
*

and we are getting good recorded audio quality.

I found from other posts that buffer-size of 65536 is very large and it
should work with size of only 1024. same usb mic works without xruns on my
desktop with buffer size 1024.

The problem is that the application has to be told to use insanely large
buffers in order to avoid xruns. I suspect the problem is either in the
kernel (possibly just a misconfiguration) or in hardware.

So Can anyone suggest, how to solve the above problem?

Regards,
Abdul Moiz
