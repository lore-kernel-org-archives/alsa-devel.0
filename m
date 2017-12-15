From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v5] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Fri, 15 Dec 2017 11:36:54 +0000
Message-ID: <20171215113654.a47ddf2bo44ziucl@localhost.localdomain>
References: <20171211195403.3irxp7g3n326ub3g@localhost.localdomain>
 <20171212163254.GL16323@sirena.org.uk>
 <20171212213114.n5pcgy6q6m3qu5s4@localhost.localdomain>
 <20171214093244.udrjwgfvpxpc3jq7@localhost.localdomain>
 <20171214222955.qicmzltikkwaazly@localhost.localdomain>
 <20171214224309.btsuh3ew5lkqfpcf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 76584267B4F
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 12:36:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171214224309.btsuh3ew5lkqfpcf@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 14, 2017 at 04:43:10PM -0600, Steven Eckhoff wrote:
> On Thu, Dec 14, 2017 at 04:36:17PM -0600, Steven Eckhoff wrote:
> > On Thu, Dec 14, 2017 at 09:32:44AM +0000, Charles Keepax wrote:
> > 
> > > Not sure what you mean here but setting up CODEC registers
> > > directly from the machine driver is probably not ideal. You
> > > should probably be looking into regmap_register_patch this lets
> > > you apply a bunch of register settings to the chip every time you
> > > do a regmap_cache_sync. This is useful for situations like the
> > > chip has terrible register defaults you want to correct.
> > 
> > Thanks I will keep that in mind. For now our defaults are okay, but
> > this may come in handy in other drivers. I have removed this bit from
> > the next version since this can be set by the machine driver and it
> > makes more sense there since the settings were configuring how the I2S
> > interfaces were connected.
> 
> I apologize I had to reread that.
> 
> The settings were setting whether the bclk and lrclk would be shared
> between the DAC and ADC interfaces. I thought this would make sense in
> the machine driver since it knows how the devices are connected. Is
> there a better way to do this?

Hmm... might need to think about the case of whether to share a
clock depends a little on what the hardware actually looks like.

But basically my point is that writing random CODEC registers
from the machine driver is not very nice. You want to be making
use of ASoC calls etc. to have the CODEC driver apply the setting
you want.

For example you might call snd_soc_dai_set_fmt to configure
who is master/slave, but you wouldn't want to write the bit
that selects master mode on the CODEC directly from the machine
driver.

Thanks,
Charles
