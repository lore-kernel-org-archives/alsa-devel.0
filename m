From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: multi-component - Fix DAI ID
 scanning from device name
Date: Tue, 03 Aug 2010 14:51:22 +0100
Message-ID: <1280843482.3112.39.camel@odin>
References: <1280816818-10154-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 0C3132449B
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 15:51:26 +0200 (CEST)
Received: by wyb42 with SMTP id 42so4268014wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Aug 2010 06:51:25 -0700 (PDT)
In-Reply-To: <1280816818-10154-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-08-03 at 09:26 +0300, Jarkko Nikula wrote:
> Format string specifier ".%d" for sscanf cannot scan integer from a string
> "driver-name.123". Fix this by starting the scan from a position after
> "driver-name".
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> Liam. This is a trivial fix. No need for separate patch, just embed to your
> next multi-component update. I noticed this because dai->id in mcbsp_dai_probe
> was always zero.
> ---

Thanks

Both Applied.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
