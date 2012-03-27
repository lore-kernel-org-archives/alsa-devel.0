From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH] ASoC: ep93xx-i2s: use devm_* helpers to
	cleanup probe
Date: Tue, 27 Mar 2012 21:02:18 +0300
Message-ID: <20120327180218.GG5812@mwesterb-mobl.ger.corp.intel.com>
References: <201203261600.17787.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 34FCC2437D
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Mar 2012 20:03:11 +0200 (CEST)
Received: by bkwj10 with SMTP id j10so164104bkw.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2012 11:03:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201203261600.17787.hartleys@visionengravers.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, Linux Kernel <linux-kernel@vger.kernel.org>, vinod.koul@intel.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 26, 2012 at 04:00:17PM -0700, H Hartley Sweeten wrote:
> Use the devm_* helpers to cleanup the probe routine. This also eliminates
> having to carry the mem value in the private data for the remove.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>

Acked-by: Mika Westerberg <mika.westerberg@iki.fi>

> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Jaroslav Kysela <perex@perex.cz>
> CC: Takashi Iwai <tiwai@suse.de>
> Cc: Vinod Koul <vinod.koul@intel.com>
