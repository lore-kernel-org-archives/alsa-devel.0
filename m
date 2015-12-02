From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 15/15] ASoC: hdac_hdmi: Keep display active
 while enumerating codec
Date: Wed, 2 Dec 2015 21:07:36 +0530
Message-ID: <20151202153736.GA22880@subhransu-desktop>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-15-git-send-email-subhransu.s.prusty@intel.com>
 <s5hr3j6pbs2.wl-tiwai@suse.de>
 <20151201214841.GD5624@subhransu-desktop>
 <s5h8u5ecen8.wl-tiwai@suse.de>
 <32F4D3A311A1404B92CF923AFF38C3C52E37CB32@BGSMSX104.gar.corp.intel.com>
 <s5h1tb6cd0z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 91756261543
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 11:07:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h1tb6cd0z.wl-tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Patches Audio <patches.audio@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Babu,
 Ramesh" <ramesh.babu@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 01, 2015 at 06:08:28PM +0100, Takashi Iwai wrote:
> On Tue, 01 Dec 2015 17:48:43 +0100,
> Babu, Ramesh wrote:
> > 
> > > On Tue, 01 Dec 2015 22:48:41 +0100,
> > > Subhransu S. Prusty wrote:
> > > >
> > > > On Tue, Dec 01, 2015 at 01:57:01PM +0100, Takashi Iwai wrote:
> > > > > On Tue, 01 Dec 2015 18:47:11 +0100,
> > > > > Subhransu S. Prusty wrote:
> > > > > >
> > > > > > From: Ramesh Babu <ramesh.babu@intel.com>
> > > > > >
> > > > > > Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
> > > > > > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > > > > > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > > > > > ---
> > > > > >  sound/soc/codecs/hdac_hdmi.c | 8 ++++++++
> > > > > >  1 file changed, 8 insertions(+)
> > > > > >
> > > > > > diff --git a/sound/soc/codecs/hdac_hdmi.c
> > > b/sound/soc/codecs/hdac_hdmi.c
> > > > > > index 46aa5cc..fa3cfa5 100644
> > > > > > --- a/sound/soc/codecs/hdac_hdmi.c
> > > > > > +++ b/sound/soc/codecs/hdac_hdmi.c
> > > > > > @@ -1136,6 +1136,14 @@ static int hdac_hdmi_dev_probe(struct
> > > hdac_ext_device *edev)
> > > > > >  	INIT_LIST_HEAD(&hdmi_priv->pin_list);
> > > > > >  	INIT_LIST_HEAD(&hdmi_priv->cvt_list);
> > > > > >
> > > > > > +	ret = snd_hdac_display_power(edev->hdac.bus, true);
> > > > > > +	if (ret < 0) {
> > > > > > +		dev_err(&edev->hdac.dev,
> > > > > > +			"Cannot turn on display power on i915 err: %d\n",
> > > > > > +			ret);
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > >  	ret = hdac_hdmi_parse_and_map_nid(edev, &hdmi_dais, &num_dais);
> > > > > >  	if (ret < 0) {
> > > > > >  		dev_err(&codec->dev, "Failed in parse and map nid with err:
> > > %d\n", ret);
> > > > > > --
> > > > > > 1.9.1
> > > > >
> > > > > No counterpart to turn off?
> > > > turned off in runtime suspend during first explicit suspend call.
> > > 
> > > It's a refcount, hence it does matter how many times it's called.
> > > Does it really balance well?  It smells suspicious if you add only a
> > > call to turn on without turning off...
> > 
> > Display power is turned ON during device probe. When soc codec probe
> > completes, runtime suspend call is invoked and display power is turned OFF.
> > So refcount is balanced. 
> 
> The runtime suspend of the codec, or of the controller?  I haven't
> seen the codec suspend/resume doing it in this patchset, so I wonder.

It is turned off in the runtime suspend of the codec. It was added in the
basic driver patch series as part of PM enabling where it enables the
display during runtime resume and disable during runtime suspend. But
when the device runtime PM is first enabled and the device is put to
suspend, only runtime suspend gets called which doesn't actually decrement
the display reference count but throws a warning. With this patch that
gets fixed as well.

> 
> if it's really well balanced, you should add the proper comment in the
> code who turns off at when and where.  Otherwise reader will be lost.

Sure. Will udpate the changelog and add some comments in the code as well.

> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
