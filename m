From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fix SND_PXA2XX_LIB Kconfig warning
Date: Thu, 25 Nov 2010 11:13:29 +0000
Message-ID: <20101125111329.GC22298@rakim.wolfsonmicro.main>
References: <1290635175-30501-1-git-send-email-mad_soft@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BF51A103C14
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 12:13:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1290635175-30501-1-git-send-email-mad_soft@inbox.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 25, 2010 at 12:46:15AM +0300, Dmitry Artamonow wrote:
> Fix following warning observed when SND_PXA2XX_SOC is set and SND_ARM isn't:
> 
> warning: (SND_PXA2XX_AC97 && SOUND && !M68K && SND && SND_ARM && ARCH_PXA ||
> SND_PXA2XX_SOC && SOUND && !M68K && SND && SND_SOC && ARCH_PXA) selects
> SND_PXA2XX_LIB which has unmet direct dependencies (SOUND && !M68K && SND &&
> SND_ARM)
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>

Applied, thanks.
