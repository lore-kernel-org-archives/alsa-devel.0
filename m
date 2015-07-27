From: Andy Ng <andreas2025@gmail.com>
Subject: pcm prepare
Date: Mon, 27 Jul 2015 22:01:36 +0100
Message-ID: <CAAVaN8woRd9Xvp3kE-=8gW-diB4KSWjEw+hU=bfi7cQdBvdQkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id DFBAD2604B3
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 23:01:36 +0200 (CEST)
Received: by lafd3 with SMTP id d3so46349878laf.1
 for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2015 14:01:36 -0700 (PDT)
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

Hi,

I am quite surprised that by sending hardware params with alsa-lib the
prepare function is called automatically in the driver.

In my case, I would like to open and configure pcmNp and pcmNc and
then call prepare for pcmNp and pcmPc channels.

It is quite imperative to execute specific configuration steps after
both channels are opened and configured.

I was wondering if there is any ioctl interface that can be hooked in
alsa-lib to pass extra configuration info before start the streams.

Any ideas?

Andy
