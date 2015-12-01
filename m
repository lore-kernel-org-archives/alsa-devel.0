From: "Babu, Ramesh" <ramesh.babu@intel.com>
Subject: Re: [PATCH 15/15] ASoC: hdac_hdmi: Keep display active
 while enumerating codec
Date: Tue, 1 Dec 2015 16:48:43 +0000
Message-ID: <32F4D3A311A1404B92CF923AFF38C3C52E37CB32@BGSMSX104.gar.corp.intel.com>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-15-git-send-email-subhransu.s.prusty@intel.com>
 <s5hr3j6pbs2.wl-tiwai@suse.de>	<20151201214841.GD5624@subhransu-desktop>
 <s5h8u5ecen8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B6E0261AFF
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 17:48:49 +0100 (CET)
In-Reply-To: <s5h8u5ecen8.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Prusty, Subhransu S" <subhransu.s.prusty@intel.com>
Cc: Patches Audio <patches.audio@intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> On Tue, 01 Dec 2015 22:48:41 +0100,
> Subhransu S. Prusty wrote:
> >
> > On Tue, Dec 01, 2015 at 01:57:01PM +0100, Takashi Iwai wrote:
> > > On Tue, 01 Dec 2015 18:47:11 +0100,
> > > Subhransu S. Prusty wrote:
> > > >
> > > > From: Ramesh Babu <ramesh.babu@intel.com>
> > > >
> > > > Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
> > > > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > > > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > > > ---
> > > >  sound/soc/codecs/hdac_hdmi.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/sound/soc/codecs/hdac_hdmi.c
> b/sound/soc/codecs/hdac_hdmi.c
> > > > index 46aa5cc..fa3cfa5 100644
> > > > --- a/sound/soc/codecs/hdac_hdmi.c
> > > > +++ b/sound/soc/codecs/hdac_hdmi.c
> > > > @@ -1136,6 +1136,14 @@ static int hdac_hdmi_dev_probe(struct
> hdac_ext_device *edev)
> > > >  	INIT_LIST_HEAD(&hdmi_priv->pin_list);
> > > >  	INIT_LIST_HEAD(&hdmi_priv->cvt_list);
> > > >
> > > > +	ret = snd_hdac_display_power(edev->hdac.bus, true);
> > > > +	if (ret < 0) {
> > > > +		dev_err(&edev->hdac.dev,
> > > > +			"Cannot turn on display power on i915 err: %d\n",
> > > > +			ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > >  	ret = hdac_hdmi_parse_and_map_nid(edev, &hdmi_dais, &num_dais);
> > > >  	if (ret < 0) {
> > > >  		dev_err(&codec->dev, "Failed in parse and map nid with err:
> %d\n", ret);
> > > > --
> > > > 1.9.1
> > >
> > > No counterpart to turn off?
> > turned off in runtime suspend during first explicit suspend call.
> 
> It's a refcount, hence it does matter how many times it's called.
> Does it really balance well?  It smells suspicious if you add only a
> call to turn on without turning off...

Display power is turned ON during device probe. When soc codec probe
completes, runtime suspend call is invoked and display power is turned OFF.
So refcount is balanced. 
