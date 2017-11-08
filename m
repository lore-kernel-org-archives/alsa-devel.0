From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC PATCH v2 5/7] uapi: sound: Avoid using
 timespec for struct snd_ctl_elem_value
Date: Wed, 8 Nov 2017 22:44:59 +0900
Message-ID: <df2acbf0-c37e-78fd-9a8d-5ab0c6553612@sakamocchi.jp>
References: <cover.1509612175.git.baolin.wang@linaro.org>
 <24089861471214ca49cf56e8a34a6304861cc170.1509612176.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id BD229266D45
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 14:45:06 +0100 (CET)
In-Reply-To: <24089861471214ca49cf56e8a34a6304861cc170.1509612176.git.baolin.wang@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Baolin Wang <baolin.wang@linaro.org>, perex@perex.cz, tiwai@suse.com, arnd@arndb.de
Cc: fabf@skynet.be, arvind.yadav.cs@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, lgirdwood@gmail.com, mingo@kernel.org, gudishax.kranthikumar@intel.com, broonie@kernel.org, bhumirks@gmail.com, naveen.m@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com, elfring@users.sourceforge.net, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Nov 2 2017 20:06, Baolin Wang wrote:
> The struct snd_ctl_elem_value will use 'timespec' type variables to record
> timestamp, which is not year 2038 safe on 32bits system.
> 
> Since there are no drivers will implemented the tstamp member of the
> struct snd_ctl_elem_value, and also the stucture size will not be changed
> if we change timespec to s64 for tstamp member of struct snd_ctl_elem_value.
> 
> Thus we can simply change timespec to s64 for tstamp member to avoid
> using the type which is not year 2038 safe on 32bits system.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>   include/uapi/sound/asound.h |    8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index 1949923..fabb283 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -943,8 +943,12 @@ struct snd_ctl_elem_value {
>   		} bytes;
>   		struct snd_aes_iec958 iec958;
>   	} value;		/* RO */
> -	struct timespec tstamp;
> -	unsigned char reserved[128-sizeof(struct timespec)];
> +#ifndef __KERNEL__
> +	struct { s64 tv_sec; s64 tv_nsec; } tstamp;
> +	unsigned char reserved[128-sizeof(struct { s64 tv_sec; s64 tv_nsec; })];
> +#else
> +	unsigned char reserved[128];
> +#endif
>   };
>   
>   struct snd_ctl_tlv {

As long as I know, via any APIs in alsa-lib[1], 'struct 
snd_ctl_elem_value.tstamp' is not available, fortunately.

In the library, applications are not expected to access to this 
structure directly. The applications get opaque pointer to the structure 
and must use any control APIs to operate it. Actually the library 
produce no API to handle 'struct snd_ctl_elem_value.tstamp'. This means 
that we can drop this member from alsa-lib without decline of functionality.

As you know, the member is abandoned in kernel side as well. This allows 
us to judge that this feature is not practically used by any userspace 
implementations such as tinyalsa[2].

In my opinion, we can have a plan to drop this useless member instead of 
this patch. Of course, we should have enough investigation and 
consideration about its meaning on ALSA control interface in advance of 
actual removal.

[1] http://git.alsa-project.org/?p=alsa-lib.git
[2] https://android.googlesource.com/platform/external/tinyalsa/


Thanks

Takashi Sakamoto
