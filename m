From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: cht_bsw_rt5672: Use HID translation
	unit
Date: Wed, 30 Nov 2016 22:01:24 +0530
Message-ID: <20161130163123.GF6408@localhost>
References: <20161125144018.28896-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F699266912
 for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2016 17:21:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20161125144018.28896-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 25, 2016 at 03:40:18PM +0100, Takashi Iwai wrote:
> Instead of hard-coded "i2c-10EC5670:00", use the translation helper to
> avoid the mismatch between i2c-codec and ACPI strings just like what
> we've done for bytcr_rt5640.  This gives more robust binding on funky
> devices like Dell Wyse 3040.

Looks good to me.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
