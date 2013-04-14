From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v2 05/11] ASoC: fsl-ssi: Add support for imx-pcm-fiq
Date: Sun, 14 Apr 2013 10:25:49 -0500
Message-ID: <516ACA7D.60807@tabi.org>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
 <51620CEA.3010703@tabi.org> <20130414103819.GA27394@pengutronix.de>
 <516AB111.3000007@tabi.org> <20130414141015.GC27394@pengutronix.de>
 <516AC305.2000800@tabi.org> <20130414152016.GE27394@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130414152016.GE27394@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Markus Pargmann wrote:
> I only ported the imx-ssi ac97 driver code and tested twice using DMA
> without success. But there is a good description of the problem in
> imx-ssi:
>
> " The WM9712 with which this driver
> was developed with always sends GPIO status data in slot 12 which
> we receive in our (PCM-) data stream. The only chance we have is to
> manually skip this data in the FIQ handler."

Ah, so this is a work-around for a bug, where the codec is incompatible 
with the SoC?  Mark, are you familiar with this issue?  Is there a way to 
reconfigure the codec so that it works better with the SoC?  It seems 
ridiculous to add all this code just because an incompatible codec was 
chosen for some board.

Either way, the board DTS needs to clearly state *why* we're enabling FIQ 
mode when DMA mode should work.  And the patch that adds FIQ support needs 
to say that it's for boards with broken DMA support.

-- 
Timur Tabi
