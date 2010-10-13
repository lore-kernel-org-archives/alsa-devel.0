From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2] ASoC: tlv320dac33: Control for line
 output gain
Date: Wed, 13 Oct 2010 11:41:32 +0100
Message-ID: <1286966492.3282.36.camel@odin>
References: <1286960188-29334-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101013085717.GC29239@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 590B1103A13
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 12:41:36 +0200 (CEST)
Received: by wyb32 with SMTP id 32so3706167wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2010 03:41:36 -0700 (PDT)
In-Reply-To: <20101013085717.GC29239@opensource.wolfsonmicro.com>
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

On Wed, 2010-10-13 at 01:57 -0700, Mark Brown wrote:
> On Wed, Oct 13, 2010 at 11:56:28AM +0300, Peter Ujfalusi wrote:
> > New control to select the line output gain.
> > This gain control affects the linein-to-lineout and
> > dac-to-loneout gain differently.
> > Use enum type to select the desired gain combination.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Looks good!
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
