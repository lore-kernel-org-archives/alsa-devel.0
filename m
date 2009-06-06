From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and
	add	Left_J support
Date: Sat, 6 Jun 2009 21:12:26 +0100
Message-ID: <20090606201225.GA1029@sirena.org.uk>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 01C0D103824
	for <alsa-devel@alsa-project.org>;
	Sat,  6 Jun 2009 22:12:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 08:33:42PM +0800, Eric Miao wrote:

> +/* frame size definitions for I2S and Left_J formats - default is
> + * 32fs, other possibilities are 48fs, 64fs and 96fs
> + */
> +#define PXA_SSP_FRM_32FS	(0 << 16)
> +#define PXA_SSP_FRM_48FS	(1 << 16)
> +#define PXA_SSP_FRM_64FS	(2 << 16)
> +#define PXA_SSP_FRM_96FS	(3 << 16)
> +#define PXA_SSP_FRM_WIDTH(x)	(((((x) >> 16) & 0x3) + 2) << 4)
> +

I still haven't checked this on Zylonite but I wanted to mention these
new DAI format bits just now - as previously discussed I'm not
enthusiastic about this.  As well as the previous issues I raised with
this approach I also meant to mention is that the use of a bitfield will
inevitably restrict what can be expressed, causing real problems for
some systems.  For example, the WM9081 supports systems using up to 3
stereo TDM slots and up to 32 bit samples so could be used in a system
which needs a 192fs bit clock.

If we did decide to adopt this approach then these defines should be in
the ASoC headers rather than private to this driver - apart from
anything else, there's every chance that additions to the standard bits
could end up colliding with this.

I'm still not sure what the best way to handle this is due to the
interaction with TDM mode.  The fact that TDM mode really wants to
always explicitly specify the frame width in order to allow the sample
size in each slot to vary suggests that one option would be to add a
sample width parameter to set_tdm_slot() - given the very small number
of in tree users it'd cause little disruption.  A set_sample_width()
operation could also be added.
