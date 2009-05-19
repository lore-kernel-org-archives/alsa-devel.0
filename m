From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Fix Analog capture path
	for AUXR
Date: Tue, 19 May 2009 15:18:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03056A1739@dbde02.ent.ti.com>
References: <1242719463-17508-1-git-send-email-peter.ujfalusi@nokia.com>
	<1242719463-17508-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090519085006.GA24884@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 473EB243EF
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 11:48:23 +0200 (CEST)
In-Reply-To: <20090519085006.GA24884@rakim.wolfsonmicro.main>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

What should be the quickest way to merge all the ASoC patches which have come after my 2.6.29-rc3 release? I have a found a solution for my tuck noise problem now but cannot apply the patch as it is, because the tip has moved ahead from my baseline by several commits. I cannot move my baseline so have to pull only sound/soc related patches.

Is there any repository where I will find only asoc related patches? Or what should be the ideal way to handle this?

Thanks and Regards,
Anuj Aggarwal

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Tuesday, May 19, 2009 2:20 PM
> To: Peter Ujfalusi
> Cc: alsa-devel@alsa-project.org; sakoman@gmail.com; Aggarwal, Anuj
> Subject: Re: [PATCH 1/1] ASoC: TWL4030: Fix Analog capture path for AUXR
> 
> On Tue, May 19, 2009 at 10:51:03AM +0300, Peter Ujfalusi wrote:
> > AUXR is selected by bit 2 and not by bit 1 in the ANAMICR register.
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Applied, thanks.
