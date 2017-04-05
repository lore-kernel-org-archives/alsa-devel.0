From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] ASoC: wm8978: Add OF device ID table
Date: Wed, 5 Apr 2017 09:51:54 +0100
Message-ID: <20170405085154.GY6986@localhost.localdomain>
References: <20170404192630.11408-1-javier@osg.samsung.com>
 <20170404192630.11408-6-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 36201266F95
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 10:50:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170404192630.11408-6-javier@osg.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 04, 2017 at 03:26:29PM -0400, Javier Martinez Canillas wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
> 
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.
> 
> Before this patch:
> 
> $ modinfo sound/soc/codecs/snd-soc-wm8978.ko | grep alias
> alias:          i2c:wm8978
> 
> After this patch:
> 
> $ modinfo sound/soc/codecs/snd-soc-wm8978.ko | grep alias
> alias:          i2c:wm8978
> alias:          of:N*T*Cwlf,wm8978C*
> alias:          of:N*T*Cwlf,wm8978
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
