From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/5] compress: add the core file
Date: Thu, 22 Sep 2011 14:01:32 +0100
Message-ID: <20110922130132.GA10125@opensource.wolfsonmicro.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-5-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2FE3324641
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 15:01:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314943585-11670-5-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 02, 2011 at 11:36:24AM +0530, Vinod Koul wrote:
> This patch ads core.c, the file which implements the ioctls and
> registers the devices
> 
> Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/compress_offload/core.c |  632 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 632 insertions(+), 0 deletions(-)
>  create mode 100644 sound/compress_offload/core.c
> 
> diff --git a/sound/compress_offload/core.c b/sound/compress_offload/core.c
> new file mode 100644
> index 0000000..1797dba
> --- /dev/null
> +++ b/sound/compress_offload/core.c
> @@ -0,0 +1,632 @@

Hi Vinod,

Any chance you could share your latest changes somehow?  It'd be worth
setting up a repository for further development on this.  I've got some
patches sitting locally, some of them are bug fixes, some others are
expected to mess with the API itself.

Thanks for your time,
Dimitris
