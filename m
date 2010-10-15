From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add max98088 CODEC driver
Date: Fri, 15 Oct 2010 11:04:24 +0100
Message-ID: <1287137064.3271.5.camel@odin>
References: <B2150E1E4418E1438554A300EA5040E40D469C124D@ITSVLEX06.it.maxim-ic.internal>
	,
	<B2150E1E4418E1438554A300EA5040E40D469C124F@ITSVLEX06.it.maxim-ic.internal>
	<B2150E1E4418E1438554A300EA5040E40D469C1251@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CFF4E103C34
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 12:04:27 +0200 (CEST)
Received: by wyb32 with SMTP id 32so473234wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 15 Oct 2010 03:04:27 -0700 (PDT)
In-Reply-To: <B2150E1E4418E1438554A300EA5040E40D469C1251@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark@alsa-project.org, Jesse Marroquin <Jesse.Marroquin@maxim-ic.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-10-13 at 20:30 -0700, Peter Hsiang wrote:
> This patch adds the MAX98088 CODEC driver.
> 
> Signed-off-by: Peter Hsiang <peter.hsiang@maxim-ic.com>
> ---
>  include/sound/max98088.h    |   50 +
>  sound/soc/codecs/Kconfig    |    4 +
>  sound/soc/codecs/Makefile   |    2 +
>  sound/soc/codecs/max98088.c | 2097 +++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/max98088.h |  193 ++++
>  5 files changed, 2346 insertions(+), 0 deletions(-)
>  create mode 100644 include/sound/max98088.h
>  create mode 100644 sound/soc/codecs/max98088.c
>  create mode 100644 sound/soc/codecs/max98088.h
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
