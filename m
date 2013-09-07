From: Michael Jordan <jordan.mymail@gmail.com>
Subject: Request for information
Date: Fri, 6 Sep 2013 22:18:36 -0400
Message-ID: <20130906221836.50bae68e@mach1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f46.google.com (mail-qe0-f46.google.com
 [209.85.128.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 358F8261ADA
 for <alsa-devel@alsa-project.org>; Sat,  7 Sep 2013 04:18:40 +0200 (CEST)
Received: by mail-qe0-f46.google.com with SMTP id x7so2139432qeu.33
 for <alsa-devel@alsa-project.org>; Fri, 06 Sep 2013 19:18:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I am developing a driver for the PCM3168A. We have created an expansion
board with the codec, op-amp buffers, etc. which is designed to connect
to the audio expansion connector on an OMAPL138 EXPKIT from LogicPD. I
have the rough draft of the pcm3168a.c and pcm3168a.h. Looking through
the code, I see that the DA850 is "hard-wired" in the code to expect
the TLV320AIC3106, which is the on-board codec on the kit.

My question is, would it be proper for me to create entries in
davinci-evm.c, mach-types.h, etc. in order to provide a way to register
this new driver? Or is there a different way I should proceed?

I'll be modifying my code base for testing purposes, but when it comes
time for submission, I would like to know the proper way to handle this.

Thank you,

Michael
