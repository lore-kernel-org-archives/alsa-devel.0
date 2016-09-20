From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: DAPM over two regmaps (and a mailbox)
Date: Tue, 20 Sep 2016 23:54:30 +0800
Message-ID: <CAGb2v67kgOAfy0LctN-s02zuZqVHL_9w5Dqp52woy9QA6u42kQ@mail.gmail.com>
References: <20160919105419.GK8719@lukather>
 <20160919111247.GL10189@sirena.org.uk>
 <20160919113415.GM8719@lukather>
 <CAGb2v67FSOKKREr49xkD6J6APs=sc=iVvmBJxQ4n9d2L9_oGjg@mail.gmail.com>
 <20160919191543.GU8719@lukather>
 <CAGb2v65qARPr1cEL5oU6bsiwK61rFQx4Gma=Z0r8DK5WTBOnmA@mail.gmail.com>
 <CAGb2v67dm6UYJhy0ZLkLhp2J3HOotHWUKroEpv31GMvFnL9PVQ@mail.gmail.com>
 <20160920064159.GZ8719@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 48BA72666F6
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 17:54:56 +0200 (CEST)
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
 [209.85.223.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 4E7662087A
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 22:58:47 +0800 (CST)
Received: by mail-io0-f179.google.com with SMTP id m186so24201336ioa.2
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 08:54:52 -0700 (PDT)
In-Reply-To: <20160920064159.GZ8719@lukather>
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
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Mylene Josserand <mylene.josserand@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 20, 2016 at 2:41 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Sep 20, 2016 at 08:41:02AM +0800, Chen-Yu Tsai wrote:
>> Turns out I hadn't even added the file to git, so it's still there!
>>
>>     http://wens.tw/sun6i-a31s-codec-analog.c
>>
>> Looks like I finished the register definitions, but only copied the
>> widgets/controls from my A31 driver, and haven't fixed them up yet.
>>
>> Also, my use of SOC_DAPM_DOUBLE requires some work to the DAPM code
>> to support updates to two registers, rather than two fields in one
>> register, which I already implemented. This is, and the driver, are
>> on my TODO list.
>>
>> Let me know how you would like to proceed, so we don't end up doing
>> double the work.
>
> We'll probably have something ready by next week. Maybe we can just
> send the patches and start from there?

OK! Hopefully I'll have some time next week to get some work done on
mine. I'll take a look at the 3 SoCs and compare the analog controls
over the weekend, and see if we can't reuse them, at least between
A23/A33.

ChenYu
