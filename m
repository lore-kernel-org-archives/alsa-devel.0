From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: p1022ds: fix incorrect
 referencing of device tree properties
Date: Thu, 9 Jun 2011 10:45:10 +0100
Message-ID: <4DF09626.1060503@ti.com>
References: <1307563376-13055-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id E06DF24156
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 11:45:14 +0200 (CEST)
In-Reply-To: <1307563376-13055-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 08/06/11 21:02, Timur Tabi wrote:
> Device tree integer properties are encoded in big-endian format, but some of
> the Freescale ASoC drivers were assuming that the host is in big-endian format
> as well.  Although this is true, it's better to use endian-safe accessors.
> 
> Also add a check for a failed ioremap() call in the SSI driver.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Both 

Acked-by: Liam Girdwood <lrg@ti.com>
