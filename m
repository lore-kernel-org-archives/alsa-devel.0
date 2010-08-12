From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: multi-component: TWL4030: Restore
 registers on removal
Date: Thu, 12 Aug 2010 14:13:35 +0100
Message-ID: <1281618815.3067.40.camel@odin>
References: <1281594592-2251-1-git-send-email-peter.ujfalusi@nokia.com>
	(sfid-20100812_073026_680583_FF14829A)
	<2DCC5BA4-C46A-4CD7-ABF5-A7F5498394E7@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CF0110389E
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 15:13:40 +0200 (CEST)
Received: by ewy21 with SMTP id 21so596306ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2010 06:13:39 -0700 (PDT)
In-Reply-To: <2DCC5BA4-C46A-4CD7-ABF5-A7F5498394E7@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-08-12 at 09:20 +0100, Mark Brown wrote:
> On 12 Aug 2010, at 07:29, Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:
> 
> > Add back the register restore call, when the codec driver is
> > removed.
> > This does not affect normal operation, but it is usefull when
> > debugging audio through the twl4030 class codecs.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
