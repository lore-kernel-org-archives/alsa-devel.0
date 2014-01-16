From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v4 9/9] ARM: DTS: imx5* imx6*, use imx51-ssi
Date: Thu, 16 Jan 2014 16:55:14 +0100
Message-ID: <20140116155514.GA6464@pengutronix.de>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
 <1387545096-2334-10-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1387545096-2334-10-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Shawn,

On Fri, Dec 20, 2013 at 02:11:36PM +0100, Markus Pargmann wrote:
> imx51-ssi and imx21-ssi are different IPs. imx51-ssi supports online
> reconfiguration and needs this for correct interaction with SDMA. This
> patch adds imx51-ssi before each imx21-ssi for all imx5/imx6 SoCs.
> 

Mark Brown applied all other patches of this series. Could you please
take this one?

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
