From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] ASoC: si476x: Remove custom register I/O
	implementation
Date: Fri, 27 Sep 2013 12:28:14 -0700
Message-ID: <CAHQ1cqHEaHSUR1hL5ybs511PdCiz5QWUi5uZ5qDMZcFnVHc3=w@mail.gmail.com>
References: <1380220461-16359-1-git-send-email-broonie@kernel.org>
 <CAHQ1cqG2Uwhw3M933OPwsX1R=ZrpdmKjsy_DYTL_+CpfQvdVag@mail.gmail.com>
 <20130926194350.GU19304@sirena.org.uk>
 <CAHQ1cqF=8+vW9Ug+5KE3qFamis-m8A+agRF7uJrMbOzd5qk5jQ@mail.gmail.com>
 <20130926205807.GV19304@sirena.org.uk>
 <CAHQ1cqFUNVsKAdimFooyraK3vpvZP=asxAimjzhyyD8T1YRP=Q@mail.gmail.com>
 <20130927100757.GA19304@sirena.org.uk>
 <CAHQ1cqHwqYpdrUnYfXOsVXcYHRPGWzkTNv5SJKACUdXN58=wew@mail.gmail.com>
 <20130927170232.GL19304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 37AE72650C1
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 21:28:16 +0200 (CEST)
Received: by mail-pa0-f49.google.com with SMTP id ld10so3161381pab.8
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 12:28:14 -0700 (PDT)
In-Reply-To: <20130927170232.GL19304@sirena.org.uk>
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

On Fri, Sep 27, 2013 at 10:02 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Sep 27, 2013 at 08:53:58AM -0700, Andrey Smirnov wrote:
>
>> > OK, so if it's purely about send_command() then why is the locking not
>> > being done in that function?  Surely the most obvious and robust place
>> > to protect the function is within the function itself?
>
>> Not having send_command acquire any locks allows me to have variable
>> levels of granularity of locking, for example in the worker thread
>> that fetches RDS data from the chip it allows me to get exclusive
>> access to the chip for the duration of the FIFO draining. Also any
>> band switch for that chip, like AM to FM, etc. require chip to be
>> power cycled which translates to multiple calls to send_command as
>> well, I think having those performed atomically simplifies the driver
>> as well.
>
> Right, so it's not just protecting send_command() but is instead
> protecting higher level things.  In that case shouldn't the locking be
> performed further up in this driver too rather than on each register
> write?

That is the case for the V4L driver, in that code the locking is
acquired for logical operations, such "tune" or "power up" rather than
for a single register write, but for the codec driver, to the best of
my knowledge, read and write register are the highest level operations
that it provides. Or am I just unaware of some codec driver
functionality that driver can provide and SoC sound subsystem will use
that would allow the lock to be obtained at higher levels?
