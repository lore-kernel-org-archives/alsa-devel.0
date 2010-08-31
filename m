From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC/2.6.37: fix au1x platform
Date: Tue, 31 Aug 2010 12:01:15 +0100
Message-ID: <20100831110115.GC20849@rakim.wolfsonmicro.main>
References: <1282827231-17323-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5E69103817
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 13:01:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282827231-17323-1-git-send-email-manuel.lauss@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: alsa-devel@alsa-project.org, alsa-devel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 26, 2010 at 02:53:51PM +0200, Manuel Lauss wrote:
> This patch fixes up the au1x audio platform after the multi-component
> merge:
> - compile fixes and updates to get DB1200 platform audio working again,
> - removal of global variables in AC97/I2S/DMA(PCM) modules.
> 
> The AC97 part is limited to one instance only for now due to issues
> with getting at driver data in the soc_ac97_ops.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>

Applied, thanks - we can work on fixing up the remaining issues with
AC'97 incrementally.
