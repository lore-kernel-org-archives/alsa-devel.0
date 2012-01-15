From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH] alsa: export compress headers
Date: Sun, 15 Jan 2012 17:44:51 +0000
Message-ID: <8D3F6266AEB6384E807C6FFC6FE195E398B1D9@BGSMSX101.gar.corp.intel.com>
References: <1325164351-18396-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id D0006243F8
	for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2012 18:45:00 +0100 (CET)
In-Reply-To: <1325164351-18396-1-git-send-email-vinod.koul@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "tiwai@suse.de" <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@linux.intel.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


> 
> Export compress_offload.h and compress_params.h for userland to use
> 
> Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
> ---
>  include/sound/Kbuild |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/sound/Kbuild b/include/sound/Kbuild
> index 802947f..6df30ed 100644
> --- a/include/sound/Kbuild
> +++ b/include/sound/Kbuild
> @@ -6,3 +6,5 @@ header-y += hdsp.h
>  header-y += hdspm.h
>  header-y += sb16_csp.h
>  header-y += sfnt_info.h
> +header-y += compress_params.h
> +header-y += compress_offload.h
> --

Takashi,
Was this queued up?

--
~Vinod
