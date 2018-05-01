From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: fsl_ssi: Switch to SPDX
	identifier
Date: Tue, 1 May 2018 09:14:47 -0300
Message-ID: <CAOMZO5Dr6+Z9SFWsRS4FH9HhXUUR+dNdJ-k_ELjLM2_a+orYEg@mail.gmail.com>
References: <1525132518-27663-1-git-send-email-festevam@gmail.com>
 <83529f99-dfa0-25d3-fa2c-fd69a74c3ead@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f51.google.com (mail-oi0-f51.google.com
 [209.85.218.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D66226735E
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 14:14:49 +0200 (CEST)
Received: by mail-oi0-f51.google.com with SMTP id b130-v6so9901946oif.12
 for <alsa-devel@alsa-project.org>; Tue, 01 May 2018 05:14:49 -0700 (PDT)
In-Reply-To: <83529f99-dfa0-25d3-fa2c-fd69a74c3ead@tabi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 30, 2018 at 11:06 PM, Timur Tabi <timur@tabi.org> wrote:
> On 4/30/18 6:55 PM, Fabio Estevam wrote:
>>
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>
>
> I thought only the SPDX header is supposed to use // and the rest of the
> comment should still be /* */.

I think Mark's preference is to switch all the initial comments to // style.

>
>> - * Copyright 2007-2008 Freescale Semiconductor, Inc.
>
>
> I don't think you're supposed to remove copyright statements.

You are right. It was not done on purpose. Will send a v2. Thanks
