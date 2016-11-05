From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Always acquire
 runtime pm ref on unload
Date: Sat, 5 Nov 2016 11:43:29 -0600
Message-ID: <20161105174327.GJ22568@vkoul-mobl.gar.corp.intel.com>
References: <77d6a9761c9461b3aee4ca49ee1978bb783d2531.1476958905.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 78866266884
 for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2016 18:43:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <77d6a9761c9461b3aee4ca49ee1978bb783d2531.1476958905.git.lukas@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 20, 2016 at 12:26:16PM +0200, Lukas Wunner wrote:
> skl_probe() releases a runtime pm ref unconditionally wheras
> skl_remove() acquires one only if the device is wakeup capable.
> Thus if the device is not wakeup capable, unloading and reloading
> the module will result in the refcount being decreased below 0.
> Fix it.

Hi Lukas,

Thanks for the patch, have you tested this?

I did some tests last week and I dont remember module load/unload having an
issue.. I will test again next week and get back.

Was this found on hardware or by code inspection..


-- 
~Vinod
