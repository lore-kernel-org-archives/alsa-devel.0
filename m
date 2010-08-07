From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/6] ASoC: add ADAU1361 codec driver
Date: Sat, 07 Aug 2010 22:20:35 +0100
Message-ID: <1281216035.3088.19.camel@odin>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 66E53103806
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 23:20:37 +0200 (CEST)
Received: by wwd20 with SMTP id 20so294705wwd.2
	for <alsa-devel@alsa-project.org>; Sat, 07 Aug 2010 14:20:37 -0700 (PDT)
In-Reply-To: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

Hi Mike,

On Sat, 2010-08-07 at 16:28 -0400, Mike Frysinger wrote:
> From: Cliff Cai <cliff.cai@analog.com>
> 
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  sound/soc/codecs/Kconfig    |    4 +
>  sound/soc/codecs/Makefile   |    2 +
>  sound/soc/codecs/adau1361.c |  992 +++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/adau1361.h |  264 ++++++++++++
>  4 files changed, 1262 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/adau1361.c
>  create mode 100644 sound/soc/codecs/adau1361.h

As Mark has mentioned, please re-work your CODEC probe() and remove()
calls against the soon to be merged multi-component branch :-

git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git topic/multi-component

The machine drivers will also need modified to use the component
dev_name() now instead of a pointer when creating a DAI link.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
