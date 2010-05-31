From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: i.MX SSI Kconfig fixes
Date: Mon, 31 May 2010 10:40:00 +0100
Message-ID: <1275298800.3174.1.camel@odin>
References: <1275295794-3168-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EFF0103853
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 11:40:04 +0200 (CEST)
Received: by wyb32 with SMTP id 32so283784wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 31 May 2010 02:40:04 -0700 (PDT)
In-Reply-To: <1275295794-3168-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-05-31 at 10:49 +0200, Sascha Hauer wrote:
> Hi,
> 
> Two small fixes for i.MX SSI.
> 
> Sascha
> 
> The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:
> 
>   Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)
> 
> are available in the git repository at:
>   git://git.pengutronix.de/git/imx/linux-2.6.git imx-ssi-fixes
> 
> Sascha Hauer (2):
>       i.MX ssi: MX31ads sound support should depend on MACH_MX31ADS
>       i.MX ssi: Add missing Kconfig entry for Phytec boards
> 
>  sound/soc/imx/Kconfig |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
