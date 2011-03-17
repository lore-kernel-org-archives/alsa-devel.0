From: loody <miloody@gmail.com>
Subject: how to create alsa nodes?
Date: Thu, 17 Mar 2011 22:12:17 +0800
Message-ID: <AANLkTinUA1R-oGhQwykLiY0j7-MoB=4oJBMT=PQUTzY4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7449224390
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 15:12:32 +0100 (CET)
Received: by iym7 with SMTP id 7so2972264iym.38
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 07:12:31 -0700 (PDT)
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

Dear all:
In destop x86 system, the udev will automatically create the nodes in
snd directory, such as pcmC0D0c, pcmC0D1c, etc.
I try to let the usb sound device work on mips platform, but I have no
idea what is the proper way to create these nodes.
Should I
1. create them one by one by hand  from copying the attributes in my PC
    (if I have 2 or more usb sound devices, I have to first plug them
in pc and monitor the nodes)
2. smarter way to do so?


-- 
Regards,
miloody
