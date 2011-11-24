From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 1/1] ASoC: mxs-saif: remove function in
	platform_data
Date: Thu, 24 Nov 2011 15:31:56 +0800
Message-ID: <20111124073155.GH17979@S2100-06.ap.freescale.net>
References: <y>
 <1321977141-14882-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	by alsa0.perex.cz (Postfix) with ESMTP id E2F57103AB7
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 08:20:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321977141-14882-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, kernel@pengutronix.de, u.kleine-koenig@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 11:52:21PM +0800, Dong Aisheng wrote:
> Add master_mode and master_id in platfrom_data since it's board
> specific and board knows it.
> Then we can remove the function pointer in platfrom_data to make
> the driver more devicetree friendly.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
Applied, thanks.

-- 
Regards,
Shawn
