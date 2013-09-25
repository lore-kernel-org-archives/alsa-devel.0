From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] ASoC: ab8500: Explicitly set I/O up
Date: Wed, 25 Sep 2013 08:49:19 -0700
Message-ID: <CAOesGMiS=MnSSD7yT8NwShJuK0xBETANMeNLJvGK3p3hZW3=NA@mail.gmail.com>
References: <1380020163-20496-1-git-send-email-broonie@kernel.org>
 <20130924120115.GK2185@lee--X1>
 <20130924141910.GC3226@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f47.google.com (mail-qe0-f47.google.com
 [209.85.128.47])
 by alsa0.perex.cz (Postfix) with ESMTP id DE8202654FB
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 17:49:20 +0200 (CEST)
Received: by mail-qe0-f47.google.com with SMTP id b4so4249092qen.20
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 08:49:20 -0700 (PDT)
In-Reply-To: <20130924141910.GC3226@sirena.org.uk>
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
Cc: LinusW <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 24, 2013 at 7:19 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 24, 2013 at 01:01:15PM +0100, Lee Jones wrote:
>> On Tue, 24 Sep 2013, Mark Brown wrote:
>> > From: Mark Brown <broonie@linaro.org>
>
>> > We do some I/O in probe so we need to ensure the I/O operations are fully
>> > set up then.
>
>> Olof, would you mind testing this please?
>
> It's in -next so should be caught by the build tomorrow if you don't
> mind waiting.

Looks like the overnight -next run passed without problems on
snowball, thanks for the quick fix.


-Olof
