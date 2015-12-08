From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 14/15] ASoC: hdac_hdmi: Add jack
 reporting for user space
Date: Tue, 8 Dec 2015 12:01:36 +0530
Message-ID: <20151208063135.GN1854@localhost>
References: <1449523078-4311-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-14-git-send-email-subhransu.s.prusty@intel.com>
 <s5hy4d6kzb5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B6A85265D92
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 07:28:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy4d6kzb5.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 07, 2015 at 05:18:06PM +0100, Takashi Iwai wrote:
> On Mon, 07 Dec 2015 22:24:28 +0100,
> > +		sprintf(jack_name, "HDMI/DP, Pin=%d Jack", pin->nid);
> 
> Such a name makes sense only to be compatible for PA, and then this
> string isn't compatible.  Note that it's not about pin but for PCM
> stream.  You may wonder why it matters -- see the whole discussion on
> MST support.

So in our case we have added only one PCM Backend in DSP. In codec we have
one DAI supported, thus creating a DAIlink

The Codec DAI is mapped to a stream which we fix to a CVT. Future we
will add two more streams which are mapped to other two CVTs.

We use MUX controls to allow user to specfiy how CVT and PINs are connected
togther, this way we can route stream to any pin.

Extending this concept, behind a pin for MST there may be different 'ports',
right? Shouldn't that be another mux configuration :) So we can treat three
streams coming to codec to be routed to any pin and then any port. Since we
have only 3 CVTs we will have only 3 streams...

Back on present :), what do you recommend for us for jack name.

Thanks
-- 
~Vinod
