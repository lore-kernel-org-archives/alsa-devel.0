From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH RFC 1/1] ASoC: WL1273 FM Radio: Eliminate
 unnecessary error return value.
Date: Sat, 11 Sep 2010 09:04:30 +0100
Message-ID: <1284192270.3409.1.camel@odin>
References: <1284104490-11226-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1284104490-11226-2-git-send-email-matti.j.aaltonen@nokia.com>
	<20100910112937.GD7259@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 964D7244DE
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Sep 2010 10:04:34 +0200 (CEST)
Received: by wyb32 with SMTP id 32so3691386wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Sep 2010 01:04:34 -0700 (PDT)
In-Reply-To: <20100910112937.GD7259@rakim.wolfsonmicro.main>
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
Cc: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-09-10 at 12:29 +0100, Mark Brown wrote:
> On Fri, Sep 10, 2010 at 10:41:30AM +0300, Matti J. Aaltonen wrote:
> > With this change it's not a error to call wl1273_set_audio_route
> > when the codec is active if the new routing value is the same
> > as the current active setting.
> > 
> > Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen@nokia.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
