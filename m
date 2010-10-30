From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tpa6130a2: Fix unbalanced regulator
 disables
Date: Sat, 30 Oct 2010 17:38:27 +0100
Message-ID: <1288456707.3286.51.camel@odin>
References: <1288263940-4602-1-git-send-email-jhnikula@gmail.com>
	<20101028183326.GB14076@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 20D751037F8
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Oct 2010 18:38:32 +0200 (CEST)
Received: by wwi17 with SMTP id 17so2073199wwi.20
	for <alsa-devel@alsa-project.org>; Sat, 30 Oct 2010 09:38:30 -0700 (PDT)
In-Reply-To: <20101028183326.GB14076@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Peter@alsa-project.org, Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-10-28 at 19:33 +0100, Mark Brown wrote:
> On Thu, Oct 28, 2010 at 02:05:40PM +0300, Jarkko Nikula wrote:
> > This driver has unbalanced regulator_disable when doing module loading and
> > unloading. This is because tpa6130a2_probe followed by tpa6130a2_remove
> > calls twice tpa6130a2_power(0). Fix this by implementing a state checking
> > in tpa6130a2_power.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> > Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
