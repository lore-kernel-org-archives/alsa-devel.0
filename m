From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: Add CS4271 codec support
Date: Wed, 6 Oct 2010 17:49:41 -0700
Message-ID: <20101007004940.GC30751@opensource.wolfsonmicro.com>
References: <4CAD16A5.1090501@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A6051039C2
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 02:49:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CAD16A5.1090501@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, timur@freescale.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 07, 2010 at 01:39:01PM +1300, Ryan Mallon wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Added support for Cirrus CS4271 codec to ALSA SoC subsystem.
> 
> Applies on: 2.6.36-rc6

Unfortunately there have been major changes in the ASoC APIs in -next
for Liam's multi-component work so you'll need to update this before it
can be applied.  You should always submit code against -next (except for
bug fixes to be sent to Linus).

See

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

for current code.

I gave the driver a quick review and it looks really good - it just
needs to be updated for current APIs.

> +static const struct snd_kcontrol_new cs4271_snd_controls[] = {
> +	SOC_DOUBLE_R("Master Playback Volume", CS4271_VOLA, CS4271_VOLB, 0, 0x7F, 1),

TLV information would be nice but isn't essential.

> +	SOC_SINGLE("Digital Loopback Switch", CS4271_MODE2, 4, 1, 0),

This should probably be done as part of DAPM.  Again probably not
essential.
