From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [TINYCOMPRESS][PATCH] crec: Fix error with opening
 file using O_CREAT
Date: Fri, 17 Oct 2014 14:53:34 +0530
Message-ID: <20141017092334.GQ1638@intel.com>
References: <20140818084158.GA14810@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5095B265041
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 12:00:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140818084158.GA14810@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ammar.zhd@googlemail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 18, 2014 at 09:41:58AM +0100, Richard Fitzgerald wrote:
> From: Ammar Zahid Ali Syed <ammar.zhd@googlemail.com>
> 
> The code was not compiling when mode was not passed to open()
> while using O_CREAT offset. Passed mode to the open() alongwith
> O_CREAT to specify the attributes of file and fix compile issue.
> 
Sorry this slipped thru earlier.

Applied, now

Thanks
-- 
~Vinod
> Signed-off-by: Ammar Zahid Ali Syed <ammar.zhd@googlemail.com>
> ---
>  crec.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/crec.c b/crec.c
> index 31703c5..e3f189f 100644
> --- a/crec.c
> +++ b/crec.c
> @@ -66,6 +66,8 @@
>  #include <stdbool.h>
>  #include <getopt.h>
>  #include <sys/time.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
>  #define __force
>  #define __bitwise
>  #define __user
> @@ -256,7 +258,7 @@ void capture_samples(char *name, unsigned int card, unsigned int device,
>  	if (verbose)
>  		printf("%s: entry, reading %u bytes\n", __func__, length);
>  
> -	file = open(name, O_RDWR | O_CREAT);
> +	file = open(name, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP);
>  	if (file == -1) {
>  		fprintf(stderr, "Unable to open file '%s'\n", name);
>  		exit(EXIT_FAILURE);
> -- 
> 1.7.2.5
> 

-- 
