From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 2/2] hda - delayed ELD repoll
Date: Wed, 16 Nov 2011 00:56:23 +0800
Message-ID: <20111115165623.GA4487@localhost>
References: <20111115143155.GA28175@localhost>
	<20111115143315.GA28561@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id D4524103922
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 17:56:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111115143315.GA28561@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, Jeremy Bush <contractfrombelow@gmail.com>, Christopher White <c.white@pulseforce.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

> -	if (eld_valid)
> +	if (eld_valid) {
>  		if (!snd_hdmi_get_eld(eld, codec, pin_nid))
>  			snd_hdmi_show_eld(eld);
> +		else {

Oops, forgot testing @retry here! Updated patch follows.

> +			queue_delayed_work(codec->bus->workq,
> +					   &eld->work,
> +					   msecs_to_jiffies(300));
> +		}
> +	}
