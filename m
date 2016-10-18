From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [patch] ASoC: Intel: Skylake: Fix a shift wrapping bug
Date: Tue, 18 Oct 2016 19:26:07 +0530
Message-ID: <20161018135606.GV2467@localhost>
References: <20161013085548.GK16198@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161013085548.GK16198@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Dharageswari R <dharageswari.r@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shreyas NC <shreyas.nc@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, Colin Ian King <colin.king@canonical.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Kranthi G <gudishax.kranthikumar@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 13, 2016 at 11:55:48AM +0300, Dan Carpenter wrote:
> "*val" is a u64.  It definitely looks like we intend to use the high 32
> bits as well.
> 
> Fixes: 700a9a63f9c1 ("ASoC: Intel: Skylake: Add module instance id generation APIs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Kranthi G <gudishax.kranthikumar@intel.com>

-- 
~Vinod
