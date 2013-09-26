From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] ASoC: si476x: Remove custom register I/O
	implementation
Date: Thu, 26 Sep 2013 12:58:27 -0700
Message-ID: <CAHQ1cqF=8+vW9Ug+5KE3qFamis-m8A+agRF7uJrMbOzd5qk5jQ@mail.gmail.com>
References: <1380220461-16359-1-git-send-email-broonie@kernel.org>
 <CAHQ1cqG2Uwhw3M933OPwsX1R=ZrpdmKjsy_DYTL_+CpfQvdVag@mail.gmail.com>
 <20130926194350.GU19304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id A9BC5262631
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 21:58:28 +0200 (CEST)
Received: by mail-pa0-f46.google.com with SMTP id fa1so1772153pad.5
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 12:58:27 -0700 (PDT)
In-Reply-To: <20130926194350.GU19304@sirena.org.uk>
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

On Thu, Sep 26, 2013 at 12:43 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Sep 26, 2013 at 12:33:33PM -0700, Andrey Smirnov wrote:
>> On Thu, Sep 26, 2013 at 11:34 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > A better and more idiomatic approach would be to have the MFD manage the
>> > cache, making the device cache only when it powers things down. This also
>> > allows ASoC to use the standard regmap helpers for the device which helps
>
>> Correct me if my understanding is wrong but using standard helper
>> function would mean using hw_write and hw_read from soc-io.c. Looking
>> at the source code of those functions I don't believe the are
>> performing any sort of locking(once again I may be wrong) and rely on
>> regmap_* implementation to do it internally. With si476x driver it is
>> not the case and it is important that codec write/read functions
>> perform si476x_core_lock(core) before they call regmap functions. If
>> that is not done it is possible to wreak havoc on I2C bus by trying to
>> access the registers of the codec and doing some V4L2 operations on
>> the corresponding radio device.
>
>> Although I completely agree that cache managing should be moved to MFD.
>
> What exactly is the locking you're talking about here?

I am talking about locking specific for si476x MFD device that is
hadled by si476x_core_lock / si476x_core_unlock. The code before the
patch has both externally exposed functions via V4L2 driver and SoC
driver obtain said lock for the duration of their interaction with the
device. The patch appears to remove lock acquisition for SoC
functions.

>  Both regmap and I/O have locking at those levels, if you try to do a bus interaction
> using them it shouldn't conflict with any other register write.  If it's
> something higher level then shouldn't the locking be higher level too?
>
> The way the code is written it looks like the lock is being held to
> ensure there's no race due to a power state change.

That lock is being held to prevent device access contention between
all of the code that can be triggered to be executed via V4L2 ioctl
API and SoC API. As an example, I can open the radio device and start
tuning it using corresponding ioctl, meanwhile, parallel to that
process my other code is trying to change the sample rate of the
codec. To prevent those two from clashes both of them try to acquire
"core lock" with si476x_core_lock before the start doing anything with
chip/MFD.
