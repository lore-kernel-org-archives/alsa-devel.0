From: Jon Smirl <jonsmirl@gmail.com>
Subject: 6-channel output and i2s
Date: Wed, 29 Apr 2009 08:58:52 -0400
Message-ID: <9e4733910904290558n60f71bbdn8b85d64e1c0ad4dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 001F4243E8
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 14:58:54 +0200 (CEST)
Received: by ewy23 with SMTP id 23so556230ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2009 05:58:53 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

My hardware was has three stereo i2s lines. These three lines are all
tied to the same external clock so they are synchronized. Because
there are three i2s lines, each with it's own DMA queue and FIFO, I
need three independent output buffers. What is the correct way to set
this up in ALSA?

-- 
Jon Smirl
jonsmirl@gmail.com
