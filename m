From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for MAX98089 CODEC
Date: Thu, 18 Nov 2010 11:07:31 +0000
Message-ID: <20101118110731.GC7233@rakim.wolfsonmicro.main>
References: <4CE43A80.4050209@maxim-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1F93D10390A
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 12:07:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CE43A80.4050209@maxim-ic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jesse Marroquin <jesse.marroquin@maxim-ic.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 17, 2010 at 02:26:40PM -0600, Jesse Marroquin wrote:
> This patch adds initial support for the MAX98089 CODEC.

Applied, thanks.  One thing:

>  struct max98088_priv {
>         u8 reg_cache[M98088_REG_CNT];
> +       enum max98088_type devtype;

You currently never actually read the devtype anywhere - if the devices
really are fully register compatible (eg, if the differences are in
physical or electrical characteristics which aren't visible to software)
then there's no need to bother doing this, though equally well it does
no harm.
