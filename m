From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [patch] ASoC: sun4i-i2s: remove some dead code
Date: Wed, 8 Feb 2017 17:01:36 +0800
Message-ID: <CAGb2v67m5n4R+7jSpTq=_BYN1wFP=vwnPWSq6aCKmcyx8M7Jjw@mail.gmail.com>
References: <20170207131934.GD28207@mwanda>
 <20170207134215.f47cufvs7tngrabk@lukather>
 <20170207135008.GL11103@mwanda> <20170208085841.rilib45uhwgu24j4@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C8FF26695F
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 10:02:01 +0100 (CET)
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
 [209.85.223.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 68C0F20615
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 17:01:58 +0800 (CST)
Received: by mail-io0-f173.google.com with SMTP id l66so111044222ioi.1
 for <alsa-devel@alsa-project.org>; Wed, 08 Feb 2017 01:01:58 -0800 (PST)
In-Reply-To: <20170208085841.rilib45uhwgu24j4@lukather>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 8, 2017 at 4:58 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Feb 07, 2017 at 04:50:08PM +0300, Dan Carpenter wrote:
>> On Tue, Feb 07, 2017 at 02:42:15PM +0100, Maxime Ripard wrote:
>> > > - if (!IS_ERR(i2s->rst)) {
>> > > -         ret = reset_control_deassert(i2s->rst);
>> > > -         if (ret) {
>> > > -                 dev_err(&pdev->dev,
>> > > -                         "Failed to deassert the reset control\n");
>> > > -                 return -EINVAL;
>> > > -         }
>> > > + ret = reset_control_deassert(i2s->rst);
>> > > + if (ret) {
>> > > +         dev_err(&pdev->dev,
>> > > +                 "Failed to deassert the reset control\n");
>> > > +         return -EINVAL;
>> >
>> > In the case where has_reset is false, rst is NULL and will trigger a
>> > WARN_ON in reset_control_deassert.
>> >
>>
>> No it won't.  reset_control_deassert(NULL) just returns success
>> immediately.
>
> Not in current Linus' tree at least:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/reset/core.c#n217

The changes were just pulled into arm-soc. I suggest waiting for -rc1 at least
before merging this change.

ChenYu
