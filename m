From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 5/6] sound/usb: pcm changes to use media
 token api
Date: Thu, 16 Oct 2014 14:00:52 +0200
Message-ID: <543FB374.8020604@metafoo.de>
References: <cover.1413246370.git.shuahkh@osg.samsung.com>
 <cf1059cc2606f20d921e5691e3d59945a19a7871.1413246372.git.shuahkh@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-102.synserver.de (smtp-out-102.synserver.de
 [212.40.185.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 533652605DA
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 14:00:56 +0200 (CEST)
In-Reply-To: <cf1059cc2606f20d921e5691e3d59945a19a7871.1413246372.git.shuahkh@osg.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuah Khan <shuahkh@osg.samsung.com>, m.chehab@samsung.com, akpm@linux-foundation.org, gregkh@linuxfoundation.org, crope@iki.fi, olebowle@gmx.com, dheitmueller@kernellabs.com, hverkuil@xs4all.nl, ramakrmu@cisco.com, sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com, perex@perex.cz, tiwai@suse.de, prabhakar.csengg@gmail.com, tim.gardner@canonical.com, linux@eikelenboom.it
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10/14/2014 04:58 PM, Shuah Khan wrote:
[...]
>   	switch (cmd) {
>   	case SNDRV_PCM_TRIGGER_START:
> +		err = media_get_audio_tkn(&subs->dev->dev);
> +		if (err == -EBUSY) {
> +			dev_info(&subs->dev->dev, "%s device is busy\n",
> +					__func__);

In my opinion this should not dev_info() as this is out of band error 
signaling and also as the potential to spam the log. The userspace 
application is already properly notified by the return code.

> +			return err;
> +		}
>   		err = start_endpoints(subs, false);
>   		if (err < 0)
>   			return err;
