From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DaVinci: Fix McASP hardware FIFO
	configuration
Date: Tue, 15 Jun 2010 11:16:54 +0100
Message-ID: <20100615101653.GA14510@rakim.wolfsonmicro.main>
References: <1276264491-4942-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5CC24103898
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 12:16:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1276264491-4942-1-git-send-email-sudhakar.raj@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 11, 2010 at 07:24:51PM +0530, Sudhakar Rajashekhara wrote:
> On DA830/OMAP-L137 and DA850/OMAP-L138 SoCs, the McASP peripheral
> has FIFO support. This FIFO provides additional data buffering. It
> also provides tolerance to variation in host/DMA controller response
> times. More details of the FIFO operation can be found at

Applied, thanks.
