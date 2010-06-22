From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v4] alsa: ASoC: Add JZ4740 codec driver
Date: Tue, 22 Jun 2010 11:12:19 +0100
Message-ID: <1277201539.4537.2.camel@odin>
References: <1276958993-9012-1-git-send-email-lars@metafoo.de>
	<1277160391-14737-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B9711038B8
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jun 2010 12:12:23 +0200 (CEST)
Received: by wyb40 with SMTP id 40so3063458wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2010 03:12:22 -0700 (PDT)
In-Reply-To: <1277160391-14737-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-06-22 at 00:46 +0200, Lars-Peter Clausen wrote:
> This patch adds support for the JZ4740 internal codec.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> Cc: alsa-devel@alsa-project.org
> 
> ---
> Changes since v1
> - Put Kconfig entry in alphabetic order
> - Drop codec_set_fmt since the codec supports only one format
> - Rename "Capture Volume" control to "Master Capture Volume"
> - Drop unnecessary format checks
> - Add suspend/resume
> - Cleanup jz4740_codec_set_bias_level
> 
> Changes since v2
> - Drop codec prefix from the filename. Note that I keeped it for the object
>   name, because otherwise when build as a module it will clash with the ASoC
>   JZ4740 platform support.
> 
> Changes since v3
> - Hook up suspend/resume callbacks to the codec instead of the platform device

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
