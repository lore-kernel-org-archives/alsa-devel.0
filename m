From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [RFC] ASoC: fsl-ssi: Missing DMA-Request workaround
Date: Mon, 11 Nov 2013 17:26:53 +0100
Message-ID: <20131111162653.GC30263@pengutronix.de>
References: <1384185816-7730-1-git-send-email-mpa@pengutronix.de>
 <528100AE.60901@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <528100AE.60901@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On Mon, Nov 11, 2013 at 02:07:10PM -0200, Fabio Estevam wrote:
> Hi Markus,
> 
> 
> On 11/11/2013 02:03 PM, Markus Pargmann wrote:
> >There is a hardware issue when using capture and playback at the same
> >time. In the tested scenario, the capture stream was started slightly
> 
> Just to confirm: do you have this patch applied?
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/sound/soc/fsl/fsl_ssi.c?id=64d2307c3b7daa03dbc0c3a6b514709dd7b6eaee

I just applied this patch and tested, but the issue is still there
(DMA-Request missing).

Regards,

Markus Pargmann

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
