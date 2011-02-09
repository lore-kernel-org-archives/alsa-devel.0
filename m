From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Sync initial widget state with
 hardware
Date: Wed, 09 Feb 2011 21:50:17 +0000
Message-ID: <1297288217.3297.182.camel@odin>
References: <1297274651-16959-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 652CE24402
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 22:50:59 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 11so650555wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Feb 2011 13:50:59 -0800 (PST)
In-Reply-To: <1297274651-16959-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 2011-02-09 at 18:04 +0000, Mark Brown wrote:
> ASoC generally uses the register defaults for everything, but in some
> cases the hardware will default to enabling some of the DAPM widgets
> (clocks for example). Ensure that DAPM knows about the actual widget
> state at initialisation by reading the enable bits after instantiating
> the widgets so they don't get left enabled needlessly.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
