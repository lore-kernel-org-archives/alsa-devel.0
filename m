From: "Reddy, MR Swami" <MR.Swami.Reddy@nsc.com>
Subject: Re: [PATCH] ASoC: Add National Semiconductor LM49352
 Codec Support
Date: Wed, 16 Mar 2011 06:38:15 -0700
Message-ID: <290463D19D2E064191F1F96ECA480A89432CDF2C4D@EXMAIL02.scwf.nsc.com>
References: <290463D19D2E064191F1F96ECA480A89432CDF2B49@EXMAIL02.scwf.nsc.com>
	<20110316100353.GC2688@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sc-mailgw03.nsc.com (mail6.nsc.com [12.24.21.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 21F4D243F3
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 14:38:36 +0100 (CET)
Received: from SCNTRDCSS8.nsc.com (scntrdcss8.nsc.com [10.188.130.179])
	by sc-mailgw03.nsc.com (Tumbleweed MailGate 3.7.1) with ESMTP id
	21BDD13AC566
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 06:38:28 -0700 (PDT)
In-Reply-To: <20110316100353.GC2688@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 

>As previously mentioned this is pretty much up to you - you can apply a range of techniques, either from starting from >scratch or reviewing the kernel changelogs for the core and other drivers and making gradual changes to forward port.  >Which approach works best for you is largely a matter of personal preference.  If you have questions on specific things >then please feel free to ask.

OK. I will look into the kernel changelogs and update the LM49352 driver to use the latest ALSA APIs and sync with latest kernel sources. If there are any other comments (ie apart from the coding standards), please let me know.


>I've had a brief glance at the driver and there are a number of obvious coding style issues, please before resubmitting >review the coding style you are using and ensure that your driver is following a similar coding style to the existing >kernel code.  For example comments like this:

I ran the scripts/chcekpatch.pl script for lm49352.c and lm49352.h file, there no warnings/errors. 
OK, I could remove the comments for all functions in the next patch submission.

Thanks
Swami
