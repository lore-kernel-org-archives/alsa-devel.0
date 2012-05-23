From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ucm: Handle repeat device and modifier
	enables/disables
Date: Wed, 23 May 2012 14:27:24 +0100
Message-ID: <1337779644.14677.0.camel@odin>
References: <1337149499-10705-1-git-send-email-arun.raghavan@collabora.co.uk>
	<1337777193-26611-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BD9C24519
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2012 15:27:31 +0200 (CEST)
Received: by wibhn6 with SMTP id hn6so4094836wib.10
	for <alsa-devel@alsa-project.org>; Wed, 23 May 2012 06:27:29 -0700 (PDT)
In-Reply-To: <1337777193-26611-1-git-send-email-arun.raghavan@collabora.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Feng Wei <feng.wei@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-05-23 at 18:16 +0530, Arun Raghavan wrote:
> [Re-re-send with appropriate CC list. Sorry about the spam!]
> 
> Currently, enabling a device twice can cause it to be added to
> snd_use_case_mgr_t->active_devices twice, causing the list to become a
> loop and subsequent uses to result in an infinite loop.
> 
> This patch makes sure we don't enable/disable a device twice, and avoid
> doing the same for modifiers.
> 
> Signed-off-by: Arun Raghavan <arun.raghavan@collabora.co.uk>

Acked-by: Liam Girdwood <lrg@ti.com>
