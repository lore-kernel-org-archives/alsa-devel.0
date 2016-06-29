From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [RFC 02/11] ASoC: Add dai_ops to set the stream
	tag.
Date: Wed, 29 Jun 2016 09:38:11 +0530
Message-ID: <20160629040810.GN14022@subhransu-desktop>
References: <1466999284-14782-1-git-send-email-subhransu.s.prusty@intel.com>
 <1466999284-14782-3-git-send-email-subhransu.s.prusty@intel.com>
 <20160627173009.GF17217@sirena.org.uk>
 <20160628052138.GI14022@subhransu-desktop>
 <20160628111520.GL17217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 81A962605D3
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 06:11:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160628111520.GL17217@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, lgirdwood@gmail.com, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 28, 2016 at 12:15:20PM +0100, Mark Brown wrote:
> On Tue, Jun 28, 2016 at 10:51:38AM +0530, Subhransu S. Prusty wrote:
> > On Mon, Jun 27, 2016 at 06:30:09PM +0100, Mark Brown wrote:
> 
> > > This seems incredibly HDMI specific...  what are these tags, can we
> > > represent this as TDM (which seems to be what this is really)?
> 
> > This is HDA specific and the tag is to support use of same DMA channel by
> > both host and codec.
> 
> What is a "DMA channel"?

Ok. I agree this looks like TDM and we should model it like that :)

Now, the issue is how? The current TDM API doesn't seem so intutive to
invoke for this case. What do you suggest...

Regards,
Subhransu



-- 
