From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] NUC900/audio: add nuc900 audio driver
	support
Date: Mon, 17 May 2010 06:46:22 -0700
Message-ID: <20100517134622.GA5257@opensource.wolfsonmicro.com>
References: <4BF01069.6060102@gmail.com>
	<20100517024425.GA2485@opensource.wolfsonmicro.com>
	<4BF0E184.204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E31EE2465C
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 15:46:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BF0E184.204@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, May 17, 2010 at 02:26:12PM +0800, Wan ZongShun wrote:
> >On Sun, May 16, 2010 at 11:34:01PM +0800, Wan ZongShun wrote:

> >>+	if (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACIS0) & CODEC_READY))
> >>+		dev_err(nuc900_audio->dev, "AC97 codec cold reset failed!\n");

> >What is this actually checking in the hardware?  Not all CODECs enable
> >the AC97 link by default after a cold reset, the standard allows them to
> >power up in a low power state which will

> The bit 'CODEC_READY' indicates the external AC97 audio CODEC is ready,
> I just forget to implement the warm reset operation, if need, I will do
> it. In addition, Can I add the checking CODEC_READY operation to
> warm reset function?

That sounds fine.  For defensiveness it might be worth checking the
CODEC on register reads and writes too (it'd make diagnostics a bit
easier).

> >>+#define	IIS_EN			0x0002

> >Looks like there's I2S support to come?

> Yes,nuc900 supports both IIS and AC97,but my board only enable AC97 support,
> what's up here?

Nothing, just curious.
