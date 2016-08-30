From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] ALSA: control: delegate checking the
 length of data payload to each drivers
Date: Tue, 30 Aug 2016 21:16:28 +0530
Message-ID: <20160830154628.GF9355@localhost>
References: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
 <1472514285-3769-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CB8E267B59
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 17:38:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1472514285-3769-3-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@linaro.org, clemens@ladisch.de, omair.m.abdullah@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 30, 2016 at 08:44:43AM +0900, Takashi Sakamoto wrote:
> In ioctl(2) for TLV feature of ALSA control interface, an argument is
> a pointer to a data of 'struct snd_ctl_tlv' type in user space.
> The first field of this structure is for numerical ID of control element
> (numid), the second is for the length of the rest in byte unit (length).
> The rest is data payload (tlv).
> 
> In current implementation, ALSA control core checks the length field
> so that the lest is bigger than sizeof(unsigned int) * 2. This is due to
> original design of this feature.
> 
> Originally, this feature is designed to allow each driver to handle
> threshold level information. The rest of array stores the information.
> The information is expected to be this formation:
>  - type: e.g. SNDRV_CTL_TLVT_CONTAINER.
>  - length: length of the rest
>  - the rest: information fields
> 
> Against the original design, this feature can also be used to operate I/O.
> In this case, the data field in 'struct snd_ctl_tlv' is not necessarily
> the formation. Therefore, the check in control core is unreasonable.
> Perhaps, there's a case to transfer just 1 byte by this feature.
> 
> This commit purges the check and delegate it to each drivers. Fortunately,
> each implementation in drivers already check the length of payload.

Shouldn't it be other way around, we want to core to check these type of
things and not duplicate over drivers...

> @@ -1438,8 +1438,6 @@ static int snd_ctl_tlv_ioctl(struct snd_ctl_file *file,
>  
>  	if (copy_from_user(&tlv, _tlv, sizeof(tlv)))
>  		return -EFAULT;
> -	if (tlv.length < sizeof(unsigned int) * 2)
> -		return -EINVAL;
>  	if (!tlv.numid)
>  		return -EINVAL;
>  	down_read(&card->controls_rwsem);

-- 
~Vinod
