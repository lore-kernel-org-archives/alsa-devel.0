From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] ASoC: Add Jassi Brar as Samsung maintainer
Date: Mon, 27 Sep 2010 11:01:54 +0900
Message-ID: <AANLkTi=JOwQD9sJG603NEQuqJU_N9fAA6nPAtq3YuAvF@mail.gmail.com>
References: <1285402601-10131-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTik5q1B9B5V0rUHVfAXPHe7vWbxJm3dK_A6QfTJ=@mail.gmail.com>
	<AANLkTi=xEwPGsf756EG3c4sC5F4mDevoXwcMtSYnrXt_@mail.gmail.com>
	<AANLkTimf1BmDe0pPqPgi0qWYG9pb2tZVgvLQ4VVEh6K5@mail.gmail.com>
	<AANLkTimvdZP3pjYv56+AXGy5d7ceb+q1=NomH3fr1isC@mail.gmail.com>
	<20100927001959.GB10638@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id B991424381
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Sep 2010 04:01:54 +0200 (CEST)
Received: by wwc33 with SMTP id 33so1524738wwc.2
	for <alsa-devel@alsa-project.org>; Sun, 26 Sep 2010 19:01:54 -0700 (PDT)
In-Reply-To: <20100927001959.GB10638@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: =?UTF-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 27, 2010 at 9:20 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Sep 26, 2010 at 07:49:42PM +0900, Kyungmin Park wrote:
>
>> I'm not sure runtime PM is required for audio since ALSA control the
>> codec well. but try to reduce the power as we can.
>
> About all you can do with most CPUs is turn off the clocks within the
> block when they're not needed, the runtime PM subsystem itself is
> usually only useful if you've got support for power gating within the
> CPU (which tends to be done over multiple blocks so they all need to go
> idle before you can power them off).
Yes, recent Samsung SoC supports the clock & block gating. As the
word, clock gating means enable/disable the clock and block gating
means turn on/off some peripherals blocks to reduce the power. e..g,
In case of audio, AUDIO block including I2S, AC97 and so on.
However codec is different. even though it can turn on/off codec, I
think it have to re-initialize to use it and it takes some times.

To Jassi,
You can talk with Mr. Choi. he will explain our requirement.

Thank you,
Kyungmin Park
>
