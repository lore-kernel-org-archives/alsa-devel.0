From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] regulator: Update LDO2 for WM8958
Date: Mon, 13 Dec 2010 17:27:39 +0000
Message-ID: <1292261259.3320.84.camel@odin>
References: <1292255527-10016-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B7FA24689
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 18:27:42 +0100 (CET)
Received: by wwe15 with SMTP id 15so6190542wwe.20
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 09:27:41 -0800 (PST)
In-Reply-To: <1292255527-10016-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Mon, 2010-12-13 at 15:52 +0000, Mark Brown wrote:
> LDO2 has a slightly different range of supported voltages on WM8958
> so update the selector<->voltage mappings to match.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> As the WM8958 support is currently sitting in the ASoC tree for the next
> merge window this should get merged that way.  I've done some test
> merges here and git seems to be able to figure out the overlaps with the
> code in your tree so are you OK with applying to ASoC?
> 

Fine by me.

>  drivers/regulator/wm8994-regulator.c |   23 +++++++++++++++++++++--
>  1 files changed, 21 insertions(+), 2 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
