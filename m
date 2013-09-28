From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] ASoC: si476x: Remove custom register I/O
	implementation
Date: Fri, 27 Sep 2013 21:37:01 -0700
Message-ID: <CAHQ1cqEeHa+JbDZ8S0ySztRpe09zL1r9BYstyu+unzMn5UeymA@mail.gmail.com>
References: <1380220461-16359-1-git-send-email-broonie@kernel.org>
 <CAHQ1cqG2Uwhw3M933OPwsX1R=ZrpdmKjsy_DYTL_+CpfQvdVag@mail.gmail.com>
 <20130926194350.GU19304@sirena.org.uk>
 <CAHQ1cqF=8+vW9Ug+5KE3qFamis-m8A+agRF7uJrMbOzd5qk5jQ@mail.gmail.com>
 <20130926205807.GV19304@sirena.org.uk>
 <CAHQ1cqFUNVsKAdimFooyraK3vpvZP=asxAimjzhyyD8T1YRP=Q@mail.gmail.com>
 <20130927100757.GA19304@sirena.org.uk>
 <CAHQ1cqHwqYpdrUnYfXOsVXcYHRPGWzkTNv5SJKACUdXN58=wew@mail.gmail.com>
 <20130927170232.GL19304@sirena.org.uk>
 <CAHQ1cqHEaHSUR1hL5ybs511PdCiz5QWUi5uZ5qDMZcFnVHc3=w@mail.gmail.com>
 <20130927194816.GO19304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id CEC162650DB
 for <alsa-devel@alsa-project.org>; Sat, 28 Sep 2013 06:37:02 +0200 (CEST)
Received: by mail-pd0-f171.google.com with SMTP id g10so3399406pdj.2
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 21:37:01 -0700 (PDT)
In-Reply-To: <20130927194816.GO19304@sirena.org.uk>
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
> Since the driver doesn't expose any controls to userspace the only
> things that can cause register writes are the operations provided by the
> CODEC driver, they could take the lock for their runtime (which is about
> the level the v4l stuff is running at AIUI).

Do you mean moving it to si476x_codec_set_dai_fmt and
si476x_codec_hw_params? If those are the only two places where
register read and write are called by SoC sound subsystem then I think
that would work.

> This still won't fix the issue with the device being powered off but I
> guess that normal usage patterns will have powered the device up to do
> tuning or something prior to audio being started

You mean the issue cause by my forgetting to sync cache on power up?
That would be a subject for a separate patch.
