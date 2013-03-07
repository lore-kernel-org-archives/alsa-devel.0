From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 09/12] ASoC: dmaengine_pcm:
	add	snd_dmaengine_generic_pcm_open()
Date: Thu, 7 Mar 2013 11:20:06 +0000
Message-ID: <20130307112006.GD17833@n2100.arm.linux.org.uk>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
 <20130306171333.GR17833@n2100.arm.linux.org.uk>
 <20130307023316.GA22554@opensource.wolfsonmicro.com>
 <20130307091804.GA17833@n2100.arm.linux.org.uk>
 <20130307093117.GB14315@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 41A34261605
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2013 12:20:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130307093117.GB14315@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marek.vasut@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Huang Shijie <b32955@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 07, 2013 at 05:31:23PM +0800, Mark Brown wrote:
> On Thu, Mar 07, 2013 at 09:18:04AM +0000, Russell King - ARM Linux wrote:
> > On Thu, Mar 07, 2013 at 10:33:19AM +0800, Mark Brown wrote:
> 
> > > Could you go into more detail here please?  Looking at the code I'm not
> > > seeing any allocations done by the library code at all, the allocations
> > > are all done by the individual platform DMA drivers so I don't see
> > > anything stopping them doing what they need.
> 
> > I don't know what else you require apart from the description above.  Isn't
> > it rather obvious that you can't preallocate the ALSA buffer against the
> > DMA engine device if you can only obtain the DMA engine device in the open
> > function?
> 
> The bit I'm missing is why this is particularly hard to change, it
> doesn't seem like a massive refactoring and there's not many users.

Well, it requires the thing to be reworked along with everyone who uses
it, specifically snd_dmaengine_pcm_open() and snd_dmaengine_pcm_close().

Now, I could use your excuse that you've given me in the past: "I don't
have much of that hardware so I can't test the changes, so I'm not going
to touch this code evar again!"  (That's basically what you said about
the AC'97 struct device stuff.)  You can't have it both ways and always
shovel what you don't like onto other people.

So... I'll just go back to quietly sitting on my SA11x0 ASoC support
and totally ignoring mainline with it because of obstructive
maintainers. :)
