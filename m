From: abhijit naik <abhijitnaik27@gmail.com>
Subject: Support for ASP DM6446 in main-line Linux Kernel
Date: Mon, 14 Jul 2014 21:28:16 +0530
Message-ID: <CANaY3hMvw6W0+KsdCKLbXELxjv8Dka1Drvoe3AMHmD0v1oF-cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f172.google.com (mail-lb0-f172.google.com
 [209.85.217.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C7D3261A95
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 17:58:17 +0200 (CEST)
Received: by mail-lb0-f172.google.com with SMTP id z11so605361lbi.31
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 08:58:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: peter.ujfalusi@ti.com
List-Id: alsa-devel@alsa-project.org

Hi,

I am studying ASP driver of DM6446 EVM in main line kernel 3.14.
I referred to both sound/soc/davinci/davinci-mcasp.c
and sound/soc/davinci/davinci-i2s.c

Which one among the two is correct for DM6446 ASP and I am seeing that
there is a device tree code in sound/soc/davinci/davinci-evm.c but
corresponding support code is not present
in sound/soc/davinci/davinci-mcasp.c

Please let me know whether this support is complete or can some one guide
me to working code for DM6446 ASP

-- 
Best wishes,
Abhijit Naik
