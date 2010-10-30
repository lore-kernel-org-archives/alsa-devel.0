From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tlv320dac33: Limit the US_TO_SAMPLES
 macro
Date: Sat, 30 Oct 2010 17:38:57 +0100
Message-ID: <1288456737.3286.52.camel@odin>
References: <1288350445-17913-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101029171849.GA3921@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 18D851037F8
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Oct 2010 18:39:00 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 17so2073199wwi.20
	for <alsa-devel@alsa-project.org>; Sat, 30 Oct 2010 09:39:00 -0700 (PDT)
In-Reply-To: <20101029171849.GA3921@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-10-29 at 10:18 -0700, Mark Brown wrote:
> On Fri, Oct 29, 2010 at 02:07:25PM +0300, Peter Ujfalusi wrote:
> > Limit the time window to maximum 1s in the macro.
> > The driver deals with much shorter times (<200ms).
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

All Peter's fixes applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
