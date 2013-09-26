From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] ASoC: si476x: Remove custom register I/O
	implementation
Date: Thu, 26 Sep 2013 15:48:09 -0700
Message-ID: <CAHQ1cqFUNVsKAdimFooyraK3vpvZP=asxAimjzhyyD8T1YRP=Q@mail.gmail.com>
References: <1380220461-16359-1-git-send-email-broonie@kernel.org>
 <CAHQ1cqG2Uwhw3M933OPwsX1R=ZrpdmKjsy_DYTL_+CpfQvdVag@mail.gmail.com>
 <20130926194350.GU19304@sirena.org.uk>
 <CAHQ1cqF=8+vW9Ug+5KE3qFamis-m8A+agRF7uJrMbOzd5qk5jQ@mail.gmail.com>
 <20130926205807.GV19304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E632264F1E
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 00:48:10 +0200 (CEST)
Received: by mail-pd0-f171.google.com with SMTP id g10so1759952pdj.30
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 15:48:09 -0700 (PDT)
In-Reply-To: <20130926205807.GV19304@sirena.org.uk>
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

On Thu, Sep 26, 2013 at 1:58 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Sep 26, 2013 at 12:58:27PM -0700, Andrey Smirnov wrote:
>> On Thu, Sep 26, 2013 at 12:43 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > What exactly is the locking you're talking about here?
>
>> I am talking about locking specific for si476x MFD device that is
>> hadled by si476x_core_lock / si476x_core_unlock. The code before the
>> patch has both externally exposed functions via V4L2 driver and SoC
>> driver obtain said lock for the duration of their interaction with the
>> device. The patch appears to remove lock acquisition for SoC
>> functions.
>
> But what exactly are these locks supposed to be protecting?
>
>> > The way the code is written it looks like the lock is being held to
>> > ensure there's no race due to a power state change.
>
>> That lock is being held to prevent device access contention between
>> all of the code that can be triggered to be executed via V4L2 ioctl
>> API and SoC API. As an example, I can open the radio device and start
>> tuning it using corresponding ioctl, meanwhile, parallel to that
>> process my other code is trying to change the sample rate of the
>> codec. To prevent those two from clashes both of them try to acquire
>> "core lock" with si476x_core_lock before the start doing anything with
>> chip/MFD.
>
> In what way might these things conflict?  What are the clashes you are
> concerned about?

That lock serves the purpose of making sure that
si476x_core_send_command, calls to which all the rest of the functions
boil down to, is not executed in parallel to itself. So I am concerned
that with the lock acquisition removal it would be possible to make
that condition happen.
