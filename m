From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/3 v2] ASoC: Add ADAU1701 codec driver
Date: Mon, 13 Jun 2011 18:40:03 +0100
Message-ID: <4DF64B73.2060800@ti.com>
References: <1307971582-13532-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DCCD2433D
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 19:40:10 +0200 (CEST)
In-Reply-To: <1307971582-13532-1-git-send-email-lars@metafoo.de>
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
Cc: Mike Frysinger <vapier.adi@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
List-Id: alsa-devel@alsa-project.org

On 13/06/11 14:26, Lars-Peter Clausen wrote:
> This patch adds support for the Analog Devices ADAU1701 SigmaDSP.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> ---
> Changes since v1:
> Move the error message for unsupported register addresses to
> adau1701_register_size.
> ---
>  sound/soc/codecs/Kconfig    |    7 +-
>  sound/soc/codecs/Makefile   |    2 +
>  sound/soc/codecs/adau1701.c |  548 +++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/adau1701.h |   17 ++
>  4 files changed, 573 insertions(+), 1 deletions(-)
>  create mode 100644 sound/soc/codecs/adau1701.c
>  create mode 100644 sound/soc/codecs/adau1701.h

Patches 1 & 2

Acked-by: Liam Girdwood <lrg@ti.com>
