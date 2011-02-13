From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Ensure supplies are maintained for
 force enabled widgets
Date: Sun, 13 Feb 2011 16:19:55 +0000
Message-ID: <1297613995.3436.21.camel@odin>
References: <1297424653-20320-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 312921037EA
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 17:20:01 +0100 (CET)
Received: by wyi11 with SMTP id 11so3925606wyi.38
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 08:20:01 -0800 (PST)
In-Reply-To: <1297424653-20320-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, swarren@nvidia.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-02-11 at 11:44 +0000, Mark Brown wrote:
> If a widget has been force enabled then not only do we need to keep the
> widget itself enabled, we also need to keep any supplies the widget
> requires enabled. The user could force all the individual widgets on but
> this requires too much knowledge of device internals.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
