From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 0/3] make the sgtl5000-codec work
Date: Tue, 19 Jul 2011 10:56:51 +0800
Message-ID: <CAA+hA=RGJHjEVfgosgWOB0hWKfroAAJZV+d=5pq-KA+S05NK9w@mail.gmail.com>
References: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B2F68243BC
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 04:56:53 +0200 (CEST)
Received: by gxk1 with SMTP id 1so1620911gxk.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Jul 2011 19:56:52 -0700 (PDT)
In-Reply-To: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>, Zeng Zhaoming <b32542@freescale.com>
List-Id: alsa-devel@alsa-project.org

2011/7/18 Wolfram Sang <w.sang@pengutronix.de>:
> These are three patches I developed while trying to make the sgtl5000 work on
> an mx28evk with the mxs-support provided by Dong Aisheng. The chip used to
> lock up before, because a wrong value was written to the power control.
>
> The first patch removes code duplication
> The second one is for user-comfort
> The third one makes the device work
>
> Aisheng: This should make your hack for the sgtl5000 obsolete. Could you please
> test it and add your Tested-by-tag if it also works for you? (Or Reviewed-by if
> you want to review the code).
I'm willing to do that.
I'll give the result soon.

Regards
Dong Aisheng
