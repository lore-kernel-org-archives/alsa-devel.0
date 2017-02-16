From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v7 1/1] ALSA: Tascam US-16x08 DSP mixer
	quirk
Date: Thu, 16 Feb 2017 10:30:24 +0100
Message-ID: <a578d0ed-3bf5-01c9-e481-7affebcaa096@ladisch.de>
References: <1487237237-4121-1-git-send-email-onkel@paraair.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EEA1266F84
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 10:30:25 +0100 (CET)
In-Reply-To: <1487237237-4121-1-git-send-email-onkel@paraair.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: OnkelDead <onkel@paraair.de>, alsa-devel@alsa-project.org
Cc: tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

OnkelDead wrote:
> +	int i;
> +
> +	return snd_ctl_enum_info(uinfo, 1, 10, route_names);
> +
> +	return 0;

Of those five lines, four are superfluous.


Regards,
Clemens
