From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] BAT: fix missing header
Date: Fri, 23 Oct 2015 11:51:33 +0100
Message-ID: <1445597493.2491.30.camel@loki>
References: <CAG5mAdw1dO85AkuXgA7UuGmCcehWPMijrdYB5_NECgP8uoHHQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 54A892615C0
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 12:51:58 +0200 (CEST)
In-Reply-To: <CAG5mAdw1dO85AkuXgA7UuGmCcehWPMijrdYB5_NECgP8uoHHQg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Takashi Iwai <tiwai@suse.de>, "Lu, Han" <han.lu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Gautier,
 Bernard" <bernard.gautier@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-10-22 at 15:07 -0700, Caleb Crome wrote:
> There was no warning when compiling with -O3, but gave a warning without it.
> 
> commit a19fa1f7dff40e56dc4327c5e5fdde9e15bd8a55
> Author: Caleb Crome <ccrome@gmail.com>
> Date:   Tue Oct 20 20:59:50 2015 +0000
> 

Best to resend your patches using git format-patch and git send-email
with your Signed-off-by:

Liam

>     Add missing locale.h header.
> 
> diff --git a/bat/bat.c b/bat/bat.c
> index 57c9db8..14666b2 100644
> --- a/bat/bat.c
> +++ b/bat/bat.c
> @@ -23,6 +23,7 @@
>  #include <getopt.h>
>  #include <math.h>
>  #include <limits.h>
> +#include <locale.h>
> 
>  #include "aconfig.h"
>  #include "gettext.h"
