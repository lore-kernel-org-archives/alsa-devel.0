From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] ASoC: si476x: Remove custom register I/O
	implementation
Date: Fri, 27 Sep 2013 08:53:58 -0700
Message-ID: <CAHQ1cqHwqYpdrUnYfXOsVXcYHRPGWzkTNv5SJKACUdXN58=wew@mail.gmail.com>
References: <1380220461-16359-1-git-send-email-broonie@kernel.org>
 <CAHQ1cqG2Uwhw3M933OPwsX1R=ZrpdmKjsy_DYTL_+CpfQvdVag@mail.gmail.com>
 <20130926194350.GU19304@sirena.org.uk>
 <CAHQ1cqF=8+vW9Ug+5KE3qFamis-m8A+agRF7uJrMbOzd5qk5jQ@mail.gmail.com>
 <20130926205807.GV19304@sirena.org.uk>
 <CAHQ1cqFUNVsKAdimFooyraK3vpvZP=asxAimjzhyyD8T1YRP=Q@mail.gmail.com>
 <20130927100757.GA19304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C654265098
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 17:54:02 +0200 (CEST)
Received: by mail-pa0-f52.google.com with SMTP id kl14so2933105pab.25
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 08:54:00 -0700 (PDT)
In-Reply-To: <20130927100757.GA19304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

>
> OK, so if it's purely about send_command() then why is the locking not
> being done in that function?  Surely the most obvious and robust place
> to protect the function is within the function itself?

Not having send_command acquire any locks allows me to have variable
levels of granularity of locking, for example in the worker thread
that fetches RDS data from the chip it allows me to get exclusive
access to the chip for the duration of the FIFO draining. Also any
band switch for that chip, like AM to FM, etc. require chip to be
power cycled which translates to multiple calls to send_command as
well, I think having those performed atomically simplifies the driver
as well.

Even if such fine granularity could be made to work, I think it is a
big change that would need to be tested on the real HW and
unfortunately I don't have any now and I don't believe there are or
has ever been any users of that driver besides me and the company I
used to work for(which no longer ships the device with that chip, so
we can exclude them). I am trying to get some sort of evaluation board
from SiLabs, but until and if they give it to me, any changes like
that can not be verified to work on a real HW.
