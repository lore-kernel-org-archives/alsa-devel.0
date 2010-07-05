From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC 04/16] ASoC: multi-component - TI CODECs
Date: Mon, 05 Jul 2010 22:15:46 +0100
Message-ID: <1278364546.3258.215.camel@odin>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
	, <1277488383-31287-5-git-send-email-lrg@slimlogic.co.uk>
	<C358A26273CF2948B8BCDBA661A581782A6FBF945E@NOK-EUMSG-03.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CEE6103807
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Jul 2010 23:15:45 +0200 (CEST)
Received: by fxm15 with SMTP id 15so4089922fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Jul 2010 14:15:44 -0700 (PDT)
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A6FBF945E@NOK-EUMSG-03.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@nokia.com
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-06-30 at 14:08 +0200, peter.ujfalusi@nokia.com wrote:
> Hello Liam,
> 
> I'm on holiday, and I have limited access to e-mail, but I did taken a brief look at the series..

Same here, I'm just back from some travels....

> I have few question:
> Is the support for the former codec->idle_bias_off is gone? This patch removes it from the
> tlv320dac33, and t2l4030 codec drivers.
> I'm not really sure about the restructure of the tlv320dac33 driver:
> - The codec ID register read has been removed, which is really useful, and it is going to be
>   used to enable/disable features of DAC33 based on the ID.
> - Originally the codec was off by default, now it is on all the time.
> - What is the reason to move the IRQ, GPIO, and regulator request from the i2c_probe to soc_probe?
> 
> Some of these valid for the twl4030 codec as well (especially the idle_bias_off support).
> 
> I don't claim, that I have checked all the patches, and changes, but at least with the tlv320dac33,
> and twl4030 codec drivers I can see some unwanted (for me) PM related regressions.
> Are these removals intentional?

Nope, this can all be explained my merge issues since both these codecs
did go though a lot of churn in the last few months. I'll fix up soon.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
