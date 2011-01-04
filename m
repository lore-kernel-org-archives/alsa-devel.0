From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Change Samsung Kconfig from ASOC_ to
	SND_SOC_
Date: Tue, 04 Jan 2011 16:44:41 +0000
Message-ID: <1294159481.3490.349.camel@odin>
References: <1293977528-6141-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id B120224463
	for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2011 17:44:44 +0100 (CET)
Received: by wyi11 with SMTP id 11so14263665wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 04 Jan 2011 08:44:44 -0800 (PST)
In-Reply-To: <1293977528-6141-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 2011-01-02 at 14:12 +0000, Mark Brown wrote:
> The rest of ASoC is using SND_SOC_ as the prefix for all the Kconfig
> symbols so do so for the new Samsung drivers too, rather than using
> ASOC_ as they currently are.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/samsung/Kconfig  |   72 ++++++++++++++++++++++----------------------
>  sound/soc/samsung/Makefile |   36 +++++++++++-----------
>  2 files changed, 54 insertions(+), 54 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
