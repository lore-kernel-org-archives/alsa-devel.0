From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: TWL4030: Fix 24bit support
Date: Tue, 14 Dec 2010 20:05:54 +0000
Message-ID: <1292357154.3316.31.camel@odin>
References: <1292327129-19417-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101214114914.GB13649@rakim.wolfsonmicro.main>
	<201012141411.00740.peter.ujfalusi@nokia.com>
	<20101214123504.GD5723@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 30A0B103848
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 21:05:58 +0100 (CET)
Received: by wwe15 with SMTP id 15so824455wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 12:05:57 -0800 (PST)
In-Reply-To: <20101214123504.GD5723@sirena.org.uk>
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

On Tue, 2010-12-14 at 12:35 +0000, Mark Brown wrote:
> On Tue, Dec 14, 2010 at 02:11:00PM +0200, Peter Ujfalusi wrote:
> 
> > AFAIK this constraint is for applications to know, that only the 24 bit MSB is 
> > valid in S32_LE (for example the ice1712 also sets this constraint to let 
> > application know).
> 
> Hrm, yeah.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
