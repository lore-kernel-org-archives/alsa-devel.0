From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: DaVinci: McASP FIFO related updates
Date: Wed, 30 Sep 2009 13:46:25 +0100
Message-ID: <20090930124625.GA3988@rakim.wolfsonmicro.main>
References: <1254346347-21711-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 76D1E1037F1
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 14:46:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254346347-21711-1-git-send-email-chaithrika@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chaithrika U S <chaithrika@ti.com>
Cc: khilman@deeprootsystems.com, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 30, 2009 at 05:32:27PM -0400, Chaithrika U S wrote:
> The DMA params for McASP with FIFO has been updated so that it works for
> various FIFO levels. A member- 'fifo_level' has been added to the DMA
> params data structure. The fifo_level can be adjusted by the tx[rx]_numevt
> platform data. This is relevant only for DA8xx/OMAP-L1xx platforms. This
> implementation has been tested for numevt values 1, 2, 4, 8.

> Signed-off-by: Chaithrika U S <chaithrika@ti.com>

Applied, thanks.
