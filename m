From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Making ALSA apps run on OSS driver
Date: Thu, 6 Dec 2007 14:26:53 +0530
Message-ID: <61445c750712060056w23b00084j5e5c6a30f1d38bc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6595B10380C
	for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2007 09:56:55 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so376611wag
	for <alsa-devel@alsa-project.org>; Thu, 06 Dec 2007 00:56:54 -0800 (PST)
Content-Disposition: inline
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

Hi

For my OMAP 2430 board, I have a working OSS driver , but all my audio/video
applications are written
for ALSA, since we had all ALSA drivers for previous board. Now I want to
use the OSS driver as it is
for 1 week and run my applications using it, I know this is not the best
thing to do but currently I dont
have time to write ALSA driver from scratch.

I have heard about OSS emulation in ALSA i.e. any read/write to /dev/dsp
will go to my ALSA driver
but is there any way to do the reverse i.e. apps using ALSA interface should
somehow talk to OSS
driver? What all changes I need to make and where?

-Pharaoh.
