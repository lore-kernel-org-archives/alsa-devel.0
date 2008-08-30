From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [PATCH] ASoC: fix pxa2xx-i2s clk_get call
Date: Sun, 31 Aug 2008 01:52:09 +0400
Message-ID: <bc64b4640808301452x3acec2der2a153d0218706587@mail.gmail.com>
References: <1220129102-20140-1-git-send-email-dbaryshkov@gmail.com>
	<20080830215137.GA28645@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E3272480C
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Aug 2008 23:52:10 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so218815and.80
	for <alsa-devel@alsa-project.org>; Sat, 30 Aug 2008 14:52:09 -0700 (PDT)
In-Reply-To: <20080830215137.GA28645@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/8/31 Mark Brown <broonie@sirena.org.uk>:
> On Sun, Aug 31, 2008 at 12:45:02AM +0400, Dmitry Baryshkov wrote:
>> pxa2xx-isa: probe actual device and use it for clk_get call
>> thus fixing error during startup hook
>
> i2s, not isa.  Other than that
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> and IIRC Liam acked it already as well.
>

... and asked to repost on alsa-devel

-- 
With best wishes
Dmitry
