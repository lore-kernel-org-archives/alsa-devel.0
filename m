From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 10/10] ASoC: mrst_machine: add initial
 config to machine driver
Date: Fri, 6 May 2011 13:54:40 +0100
Message-ID: <20110506125437.GJ23729@opensource.wolfsonmicro.com>
References: <20110506053852.26312.79083.stgit@localhost>
	<20110506054649.26312.81715.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 111AC24395
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 14:54:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110506054649.26312.81715.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 06, 2011 at 01:46:49PM +0800, Lu Guanqun wrote:

> +	/* DMIC configuration: mono output to PCM2 */
> +	snd_soc_update_bits(codec, UPD9976_MICCTRL, BIT(1)|BIT(0), 0x1);
> +
> +	/* Set MIC2 to pseudo-differential */
> +	snd_soc_update_bits(codec, UPD9976_MICSELVOL, BIT(4), BIT(4));
> +

These look like regular routing controls to me...  If they do need to be
set with magic writes they should be platform data but things like
pseudo differential inputs are normally just represented as two single
ended inputs for which userspace just happens to choose a path that
looks differential.
