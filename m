From: Rob Nertney <rob@rob-otics.com>
Subject: --max-file-time producing incorrect results
Date: Tue, 29 Nov 2016 08:52:24 -0800
Message-ID: <CALAeOVOjBUJ2rYQ4ph9xuScwM0-K2fSrg5JROKeHK_vxP5zPHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wj0-f177.google.com (mail-wj0-f177.google.com
 [209.85.210.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AE032669BD
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 17:52:25 +0100 (CET)
Received: by mail-wj0-f177.google.com with SMTP id mp19so150971208wjc.1
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 08:52:25 -0800 (PST)
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

I have a diagnostic mode for my hardware, which gives me a known pattern in
1 second increments (for my predetermined frame size/rate). If I simply
pass a -d duration flag over and over with arecord, every capture is
perfect when I inspect it.

When I use the --max-file-time=1, my first PCM is perfect, then the
following ones aren't. It appears that in between these 1-second PCM files,
I am losing 128 frames between the 1-second files.

I'm not sure what could be causing this type of error; any thoughts?

Thanks,
Rob
