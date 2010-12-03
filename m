From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: When disabling WM8994 FLL force a
 source selection
Date: Fri, 03 Dec 2010 17:07:03 +0000
Message-ID: <1291396023.3271.144.camel@odin>
References: <1291394701-30574-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F13BB103B83
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 18:07:07 +0100 (CET)
Received: by wyi11 with SMTP id 11so9680618wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2010 09:07:07 -0800 (PST)
In-Reply-To: <1291394701-30574-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-12-03 at 16:45 +0000, Mark Brown wrote:
> When we disable the WM8994 FLL code path sharing means that we end up
> writing out a configuration. Currently this is the currently active
> input and output frequency (which causes snd_soc_update_bits() to
> suppress actual writes both immediately and in the common case where
> we reenable the same configuration later) but we allow machine drivers
> to pass through a source of zero. Since the register values written
> are one less than the source constants this causes corruption of other
> bitfields in the register.
> 
> Fix this by using the most recently configured FLL source when none is
> provided.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
