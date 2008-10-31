From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA: ASoC codec: remove unused #include
	<version.h>
Date: Fri, 31 Oct 2008 14:51:41 +0000
Message-ID: <20081031145140.GA8842@rakim.wolfsonmicro.main>
References: <20081031223910.0F26.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1F9E724574
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 15:51:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081031223910.0F26.WEIYI.HUANG@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 31, 2008 at 10:50:00PM +0800, Huang Weiyi wrote:
> The file(s) below do not use LINUX_VERSION_CODE nor KERNEL_VERSION.
>   sound/soc/codecs/ad73311.c
> 
> This patch removes the said #include <version.h>.
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
