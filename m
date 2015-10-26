From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/6] ASoC: hdac-hdmi: Add hdmi driver
Date: Mon, 26 Oct 2015 08:30:45 +0000
Message-ID: <1445848243.5321.45.camel@intel.com>
References: <1445821673-4947-1-git-send-email-vinod.koul@intel.com>
 <1445821673-4947-3-git-send-email-vinod.koul@intel.com>
 <s5h1tci9jfd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1840C260522
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 09:31:10 +0100 (CET)
In-Reply-To: <s5h1tci9jfd.wl-tiwai@suse.de>
Content-Language: en-US
Content-ID: <240444C3854A534EB051F76F083E0063@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "tiwai@suse.de" <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Patches Audio <patches.audio@intel.com>, "arnaud.pouliquen@st.com" <arnaud.pouliquen@st.com>, "jsarha@ti.com" <jsarha@ti.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "ykk@rock-chips.com" <ykk@rock-chips.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-10-26 at 08:29 +0100, Takashi Iwai wrote:
> On Mon, 26 Oct 2015 02:07:49 +0100,
> Vinod Koul wrote:
> > +/*
> > + * Parse all nodes and store the cvt/pin nids in array
> > + * Add one time initialization for pin and cvt widgets
> > + */
> > +static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
> > +{
> ....
> > +	/*
> > +	 * Currently on board only 1 pin and 1 converter enabled.
> > +	 * So using fixed map for dai_id:pin:cvt
> > +	 */
> > +	return hdac_hdmi_init_dai_map(edev, &hdmi->dai_map[0], hdmi->pin_nid[0],
> > +			hdmi->cvt_nid[0], 0);
> 
> Isn't this assumption too naive?
> And such a restriction has to be written more clearly in the
> changelog.

The intention here in this series is to have basic HDMI features enabled :) The
intention is to keep adding stuff to support multichannel, IEC, multiple outputs, SW
notification etc once basic driver is merged

Agreed we can add this to changelog. I can send updated rev, once I have other
comments

-- 
~Vinod
