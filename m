From: "M R Swami Reddy" <MR.Swami.Reddy@ti.com>
Subject: Re: FW: [PATCH v3] ASoC: Add support for TI LM49453
	Audio codec
Date: Wed, 08 Feb 2012 14:40:13 +0530
Message-ID: <4F323BF5.4010309@ti.com>
References: <290463D19D2E064191F1F96ECA480A89434AC4A96E@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sc-mailgw05.nsc.com (mail2.nsc.com [12.238.8.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 559C9103D4E
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 10:10:39 +0100 (CET)
Received: from SCNTRDCSS7.nsc.com (scntrdcss7.nsc.com [10.188.130.178])
	by sc-mailgw05.nsc.com (Tumbleweed MailGate 3.7.1) with ESMTP id
	2F26A17B022D
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 01:10:29 -0800 (PST)
In-Reply-To: <290463D19D2E064191F1F96ECA480A89434AC4A96E@EXMAIL02.scwf.nsc.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
> Sent: Tuesday, February 07, 2012 10:34 PM
> To: Reddy, MR Swami
> Cc: Girdwood, Liam; alsa-devel@alsa-project.org
> Subject: Re: [PATCH v3] ASoC: Add support for TI LM49453 Audio codec
> 
> On Mon, Feb 06, 2012 at 06:20:26AM -0800, Reddy, MR Swami wrote:
> 
>> Changes made in v3:
>> o Updated the lm49453_set_dai_pll() as per review comments in v2 patch.
>>     o Removed pll disable code in _set_dai_pll().
> 
> This doesn't really seem to address the issue at all - you still have the problems with the set_pll() function not doing anything it's supposed to do with the input and output frequencies, and now there's no way to disable the PLL.

OK. So its ideal to remove the _set_dai_pll(), as its not doing anything here.

Thanks
Swami
