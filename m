From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm97xx: Reset AC'97
	device	before registering it
Date: Mon, 26 Jan 2015 13:14:35 +0000
Message-ID: <20150126131435.GG14516@opensource.wolfsonmicro.com>
References: <1422026497-23180-1-git-send-email-lars@metafoo.de>
 <1422026497-23180-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E17C26057D
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 14:14:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1422026497-23180-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 23, 2015 at 04:21:37PM +0100, Lars-Peter Clausen wrote:
> The wm97xx touchscreen driver binds itself to the snd_ac97 device that gets
> registered by the CODEC driver and expects that the device has already been
> reset. Before commit 6794f709b712 ("ASoC: ac97: Drop delayed device
> registration") the device was only registered after the probe function of
> the CODEC driver had finished running, but starting with the mentioned
> commit the device is registered as soon as snd_soc_new_ac97_codec() is
> called. This causes the touchscreen driver to no longer work. Modify the
> CODEC drivers to use snd_soc_alloc_ac97_codec() instead of
> snd_soc_new_ac97_codec() and make sure that the AC'97 device is reset before
> the snd_ac97 device gets registered.
> 
> Fixes: 6794f709b712 ("ASoC: ac97: Drop delayed device registration")
> Reported-by: Manuel Lauss <manuel.lauss@gmail.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Looks fine to me.

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
