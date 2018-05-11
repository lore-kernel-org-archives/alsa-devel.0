From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 00/13] soundwire: Add stream support
Date: Fri, 11 May 2018 15:27:25 +0200
Message-ID: <20180511132725.GB31231@kroah.com>
References: <1524748809-21860-1-git-send-email-vkoul@kernel.org>
 <CAEKRB2deCT59YS=YZ8HSqfTXBtfmfO0SKhU0GrZj+PdC0vfZGQ@mail.gmail.com>
 <20180511114840.GB30118@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id DAE60267828
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 15:30:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180511114840.GB30118@vkoul-mobl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vkoul@kernel.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 11, 2018 at 05:18:40PM +0530, Vinod Koul wrote:
> On 06-05-18, 11:15, Vinod Koul wrote:
> > Hi Greg,
> > 
> > On Thu, Apr 26, 2018 at 6:49 PM, Vinod Koul <vkoul@kernel.org> wrote:
> > > This series adds support in SoundWire subsystem for:
> > >  - Documentation for stream support
> > >  - stream management
> > >  - data port management
> > >  - DAI ops in cadence and Intel drivers
> > >  - ASoC API to propagate SDW stream
> > 
> > Any feedback on this series?
> 
> Greg,
> 
> Am sure you are busy with lots of stuff, would appreciate if you can help with
> the series and a tiny patch [1].

I don't see [1] anywhere :(

> Now if you are too busy with things, I am willing to help out.
> 
> I can:
> a) collate and send you a pull request, or
> b) Collect everything and send to Linus as I do with dmaengine, with your
> blessing of course...
> 
> Please do let me know, thanks

Am I the conduit for this subsystem now?  If so, ok, I'll pick it up, I
didn't realize I was.  But if you could collate and send me a pull
request, that would be the easiest.

thanks,

greg k-h
