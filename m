From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v4 1/6] ASoC: core: add
 snd_soc_add_dai_pcm_controls helper
Date: Thu, 10 Mar 2016 18:28:18 +0530
Message-ID: <20160310125817.GB6839@subhransu-desktop>
References: <1457441641-7501-1-git-send-email-arnaud.pouliquen@st.com>
 <1457441641-7501-2-git-send-email-arnaud.pouliquen@st.com>
 <20160310050646.GD11154@localhost> <56E13971.9030909@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 245FE2606F3
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 13:58:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56E13971.9030909@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, "Koul, Vinod" <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, David Airlie <airlied@linux.ie>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Moise GERGAUD <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 10, 2016 at 02:38:01PM +0530, Arnaud Pouliquen wrote:
> 
> 
> On 03/10/2016 06:06 AM, Vinod Koul wrote:
> > On Tue, Mar 08, 2016 at 01:53:56PM +0100, Arnaud Pouliquen wrote:
> >> Add helper function to register DAI controls that need to be 
> >> linked to pcm device.
> >> A list is handled in case controls are created before dai_link probe
> > 
> > Overall this patch looks good to us. But on first read it is not very clear
> > how PCM and DAIs are inter related and why you need to do this. Since we are
> > having similar issues we were able to quickly understand this, the
> > suggestion would be to elborate a bit more in changelog.
> Right, i will provide more details in commit message.
> > 
> > Second, why do we need a new API for this. Why not use existing asoc
> > concepts and add one more field in dai_driver for dai_controls.
> > Core can automagically create those controls and link to PCM.
> Yes this was my first approach. Finally, i created a separate API, to be
> able to support iec generic control in DAI ( patch 3/6 and 4/6).
> These patches need possibility to attach private data to control.
> If patches 3/6 and 4/6 are rejected, for sure i will rework it to use
> existing API.
> Today It is more on compromise than an optimized solution...
> But, creating a generic iec control also implies a compatibility with
> ASoC and none ASoC drivers...

In our view, iec controls should be made generic alsa controls and asoc
should have wrapper over these and create these controls on card enumeration
and use these wrappers.

> 
> > 
> > Lastly, this doesn't help our usecase of DPCM where the HDMI codec is
> > connected to a BE, so that rtd cannot be used and we need to link to FE, so
> > not sure how we can solve that...
> DPCM seems another story... I'm not fully up to date on DPCM concept,
> but as i can remember no link between FE and BE except DAPM routing.
> Perhaps, for DPCM, a solution should be to use index field for control,
> instead of trying to dynamically link the codec control to PCM device?

That calls for a discussion on how the controls should be represented for
DPCM. Takashi/Mark/Liam we need your opinion on how the PCM related controls
should be represented in DPCM concepts.

> 
> Thanks
> Arnaud
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
