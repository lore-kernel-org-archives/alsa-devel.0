From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
 headsetl_event: POST_PMD
Date: Tue, 12 May 2009 15:21:55 +0300
Message-ID: <20090512152155.7c82fd2d.jhnikula@gmail.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090512145229.bf93fb01.jhnikula@gmail.com>
	<20090512150246.2dac1488.jhnikula@gmail.com>
	<200905121516.40246.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A92B103840
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 14:20:14 +0200 (CEST)
Received: by ewy23 with SMTP id 23so4518803ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2009 05:20:13 -0700 (PDT)
In-Reply-To: <200905121516.40246.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 12 May 2009 15:16:40 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> > Looks like the beep is caused by the ramp operation since beep is
> > gone in power-down when reverting both of your patches but it's
> > still present in power-up.
> 
> But the 'tuck' still there after you have reverted the patches?
> 
Yep it was there even it sounds bit more silent when going to longer
ramp times. Beep was present only with '109/81/55 ms'.


-- 
Jarkko
