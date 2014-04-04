From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 28/44] fireworks: Add command/response
 functionality into hwdep interface
Date: Sat, 05 Apr 2014 00:13:11 +0900
Message-ID: <533ECC07.2060607@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
 <1395400229-22957-29-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 00FB32657E4
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 17:13:20 +0200 (CEST)
In-Reply-To: <1395400229-22957-29-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Clemens,

I realized this patch include another bug...

> +static long
> +hwdep_write(struct snd_hwdep *hwdep, const char __user *data, long count,
> +	    loff_t *offset)
> +{
> ...
> +	/* check seqnum is not for kernel-land */
> +	seqnum = ((struct snd_efw_transaction *)buf)->seqnum;
> +	if (seqnum + 2 > SND_EFW_TRANSACTION_SEQNUM_MAX) {
> +		count = -EINVAL;
> +		goto end;
> +	}

I expect that the user data consists of __be32 array. So the correct way 
to calculate seqnum is:

seqnum = be32_to_cpu(((struct snd_efw_transaction *)buf)->seqnum);


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
