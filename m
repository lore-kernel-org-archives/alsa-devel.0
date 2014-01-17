From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v4 9/9] ARM: DTS: imx5* imx6*, use imx51-ssi
Date: Fri, 17 Jan 2014 13:32:25 +0800
Message-ID: <20140117053223.GC1565@shlinux1.ap.freescale.net>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
 <1387545096-2334-10-git-send-email-mpa@pengutronix.de>
 <20140116155514.GA6464@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 7182F265012
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 07:15:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140116155514.GA6464@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 16, 2014 at 04:55:14PM +0100, Markus Pargmann wrote:
> Hi Shawn,
> 
> On Fri, Dec 20, 2013 at 02:11:36PM +0100, Markus Pargmann wrote:
> > imx51-ssi and imx21-ssi are different IPs. imx51-ssi supports online
> > reconfiguration and needs this for correct interaction with SDMA. This
> > patch adds imx51-ssi before each imx21-ssi for all imx5/imx6 SoCs.
> > 
> 
> Mark Brown applied all other patches of this series. Could you please
> take this one?

Can you please regenerate the patch against my for-next branch to get
imx50 SSI nodes covered as well?

Shawn
