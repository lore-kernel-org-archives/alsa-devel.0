From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: TWL4030: Capture route runtime DAPM
	ordering fix
Date: Wed, 04 Aug 2010 00:43:34 +0100
Message-ID: <1280879014.3112.89.camel@odin>
References: <1280826061-24099-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100803141941.GE25306@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BAD22417D
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 01:43:38 +0200 (CEST)
Received: by wwb17 with SMTP id 17so1823837wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 16:43:38 -0700 (PDT)
In-Reply-To: <20100803141941.GE25306@rakim.wolfsonmicro.main>
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

On Tue, 2010-08-03 at 15:19 +0100, Mark Brown wrote:
> On Tue, Aug 03, 2010 at 12:01:01PM +0300, Peter Ujfalusi wrote:
> > Fix the ordering problem in DAPM domain, when the user
> > changes between digital and analog sources during active
> > capture (or loopback) scenario.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
