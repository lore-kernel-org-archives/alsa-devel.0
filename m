From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [tinycompress][PATCH 0/2] Fixes for write loop
 logic
Date: Fri, 7 Jun 2013 06:00:25 +0530
Message-ID: <20130607003025.GE23045@intel.com>
References: <20130605120827.GA21556@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A8C9265567
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 03:09:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130605120827.GA21556@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.jf.intel.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 05, 2013 at 01:08:27PM +0100, Richard Fitzgerald wrote:
> Two small patches which correct the logic of compress_write()
> so that it will work correctly if asked to write a buffer
> shorter than the fragment length. The first patch is needed
> to ensure that if the client requests auto-configuration
> of fragment size the internal copy of the config contains the
> configured fragment size. The second patch contains the actual
> fix to the write loop logic.
> 
> Richard Fitzgerald (2):
>   compress: copy final version of config struct
>   compress: do not poll if enough space to write remaining data
Applied thanks

--
~Vinod
> 
>  compress.c |   13 ++++++-------
>  1 files changed, 6 insertions(+), 7 deletions(-)
> 
> -- 
> 1.7.2.5
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
