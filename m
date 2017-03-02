From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: fix invalid memory
 access due to wrong reference of pointer
Date: Thu, 2 Mar 2017 14:26:13 +0530
Message-ID: <20170302085612.GR2843@localhost>
References: <20170224024841.10515-1-takashi.sakamoto@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9869C266A8A
 for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2017 09:55:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170224024841.10515-1-takashi.sakamoto@miraclelinux.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Cc: alsa-devel@alsa-project.org, hirotaka.furukawa@miraclelinux.com, ichiro.suzuki@miraclelinux.com, ryotaro.shibata@miraclelinux.com, "# v4 . 5+" <stable@vger.kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, broonie@kernel.org, shreyas.nc@intel.com, jeeja.kp@intel.com, yukie.kato@miraclelinux.com
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 24, 2017 at 11:48:41AM +0900, Takashi Sakamoto wrote:
> In 'skl_tplg_set_module_init_data()', a pointer to 'params' member of
> 'struct skl_algo_data' is calculated, then casted to (u32 *) and assigned
> to a member of configuration data. The configuration data is passed to the
> other functions and used to process intel IPC. In this processing, the
> value of member is used to get message data, however this can bring invalid
> memory access in 'skl_set_module_params()' as a result of calculation of
> a pointer for actual message data.
> 
> (sound/soc/intel/skylake/skl-topology.c)
> skl_tplg_init_pipe_modules()
> ->skl_tplg_set_module_init_data() (has this bug)
> ->skl_tplg_set_module_params()
>   (sound/soc/intel/skylake/skl-messages.c)
>   ->skl_set_module_params()
>     ((char *)param) + data_offset
> 
> This commit fixes the bug.

Thanks Takashi San for the fix

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
