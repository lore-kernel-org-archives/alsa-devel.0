From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/4] ASoC: tlv320aic3x: Fix remaining
 output pin switch names
Date: Sat, 28 Aug 2010 10:58:21 +0100
Message-ID: <1282989501.3041.6.camel@odin>
References: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
	<1282917410-12000-2-git-send-email-jhnikula@gmail.com>
	(sfid-20100827_145607_665728_84D99FCF)
	<5634BAA9-C9EC-47AF-A760-68E253CED608@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 0CA7C2412E
	for <alsa-devel@alsa-project.org>;
	Sat, 28 Aug 2010 11:58:27 +0200 (CEST)
Received: by wyb32 with SMTP id 32so4458859wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 28 Aug 2010 02:58:25 -0700 (PDT)
In-Reply-To: <5634BAA9-C9EC-47AF-A760-68E253CED608@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-08-27 at 15:17 +0100, Mark Brown wrote:
> On 27 Aug 2010, at 14:56, Jarkko Nikula <jhnikula@gmail.com> wrote:
> 
> > Bit 3 in output pin_CTRL register mutes the whole output pin not just the
> > route from DAC so remove misleading DAC from control name. Currently only
> > "Line[L | R] Playback Switch" were correct.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

All applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
