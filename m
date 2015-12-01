From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 15/15] ASoC: hdac_hdmi: Keep display active
 while enumerating codec
Date: Wed, 2 Dec 2015 03:18:41 +0530
Message-ID: <20151201214841.GD5624@subhransu-desktop>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-15-git-send-email-subhransu.s.prusty@intel.com>
 <s5hr3j6pbs2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F88C264F31
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 17:18:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hr3j6pbs2.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 01, 2015 at 01:57:01PM +0100, Takashi Iwai wrote:
> On Tue, 01 Dec 2015 18:47:11 +0100,
> Subhransu S. Prusty wrote:
> > 
> > From: Ramesh Babu <ramesh.babu@intel.com>
> > 
> > Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  sound/soc/codecs/hdac_hdmi.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> > index 46aa5cc..fa3cfa5 100644
> > --- a/sound/soc/codecs/hdac_hdmi.c
> > +++ b/sound/soc/codecs/hdac_hdmi.c
> > @@ -1136,6 +1136,14 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
> >  	INIT_LIST_HEAD(&hdmi_priv->pin_list);
> >  	INIT_LIST_HEAD(&hdmi_priv->cvt_list);
> >  
> > +	ret = snd_hdac_display_power(edev->hdac.bus, true);
> > +	if (ret < 0) {
> > +		dev_err(&edev->hdac.dev,
> > +			"Cannot turn on display power on i915 err: %d\n",
> > +			ret);
> > +		return ret;
> > +	}
> > +
> >  	ret = hdac_hdmi_parse_and_map_nid(edev, &hdmi_dais, &num_dais);
> >  	if (ret < 0) {
> >  		dev_err(&codec->dev, "Failed in parse and map nid with err: %d\n", ret);
> > -- 
> > 1.9.1
> 
> No counterpart to turn off?
turned off in runtime suspend during first explicit suspend call.
> 
> 
> Takashi

-- 
