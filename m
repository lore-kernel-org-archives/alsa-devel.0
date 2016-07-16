From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 0/5] topology: Enhance support for
	private data
Date: Sat, 16 Jul 2016 21:58:27 +0900
Message-ID: <578A2F73.8080508@sakamocchi.jp>
References: <cover.1468583255.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 49FE52614E3
 for <alsa-devel@alsa-project.org>; Sat, 16 Jul 2016 14:58:34 +0200 (CEST)
In-Reply-To: <cover.1468583255.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@intel.com, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

On Jul 15 2016 21:17, mengdong.lin@linux.intel.com wrote:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> There is no ABI change in this series.
> 
> We finished verification on latest Intel platforms. There will be 4 or 5
> series. Later series will come with some ABI update for topology. The size
> check on ABI objects in current ASoC kernel will detect possible ABI
> version mismatch between user space and kernel
> 
> History:
> v2: fix compiler warnings. There are 2 warnings left in topology/pcm.c
>     that are not caused by this series and will be fixed in later patches.
> 
> Mengdong Lin (5):
>   topology: An element can refer to multipe data sections in text conf
>     file
>   topology: Merge lookup for data reference into tplg_copy_data()
>   topology: Change uuid value to 16 separate characters in text conf
>     file
>   topology: Parse vendor private data for manifest
>   topology: Tuple type can have an extenstion
> 
>  include/topology.h        |  69 ++++++++++-
>  src/topology/ctl.c        |  52 +++-----
>  src/topology/dapm.c       |  17 ++-
>  src/topology/data.c       | 307 ++++++++++++++++++++++++++++++++++++++--------
>  src/topology/elem.c       |   4 +
>  src/topology/parser.c     |  28 ++++-
>  src/topology/tplg_local.h |  15 ++-
>  7 files changed, 395 insertions(+), 97 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Current implementation of ALSA SoC part in kernel has no call
corresponding to sys_ioctl(SNDRV_CTL_IOCTL_ELEM_ADD) or something like
that, thus I recommend you to drop this line by an additional patch:
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/topology/ctl.c;h=b948ac021ceecc116bc1087075743243e4b14055;hb=HEAD#l44


Regards

Takashi Sakamoto
