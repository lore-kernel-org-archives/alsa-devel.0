From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv4 00/20] OMAP ASoC changes in DMA
	utilization
Date: Wed, 19 Aug 2009 10:40:12 +0300
Message-ID: <20090819074011.GA25559__26014.5287648358$1250668496$gmane$org@esdhcp037198.research.nokia.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
	<20090817170549.f0adf2a4.jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20090817170549.f0adf2a4.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hello guys,

On Mon, Aug 17, 2009 at 04:05:49PM +0200, Jarkko Nikula wrote:
> On Mon, 17 Aug 2009 14:50:59 +0300
> Eduardo Valentin <eduardo.valentin@nokia.com> wrote:
> 
> > Hello again guys,
> > 
> > Here is version 4 of these changes. No real changes from previous versions.
> > The only thing is that now I've rebased on top of Takashi's tree:
> > http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=summary
> > 
> > as there are pending things there which Jarkko has pointed on previous series.
> > 
> Here's my ack to the ASoC part. I tested the set on top of these
> Janusz's patches:
> 
> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-August/020170.html
> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-August/020171.html
> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-August/020262.html
> 
> Note, that I posted modified version for the patch 16 based on Janusz's
> [PATCH 3/3 v3].
> 
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> > 
> >  arch/arm/mach-omap2/mcbsp.c             |    5 +
> >  arch/arm/plat-omap/include/mach/mcbsp.h |   49 ++++
> >  arch/arm/plat-omap/mcbsp.c              |  377 ++++++++++++++++++++++++++++++-
> >  sound/soc/omap/omap-mcbsp.c             |   78 ++++++-
> >  sound/soc/omap/omap-pcm.c               |   14 +-
> >  sound/soc/omap/omap-pcm.h               |    2 +
> >  6 files changed, 511 insertions(+), 14 deletions(-)
> > 
> Tony, if you are ok with the OMAP McBSP changes, how it would be best
> get these merged? Via ASoC, LKML or separately from both
> subsystems during the merge window?

Tony, Takashi,

About these changes. I have one doubt. What is the correct tree to base them?
There are changes under arch/arm/plat-omap/ and under sound/soc/omap/.

Should I base them:
- all 20 patches against sound-2.6.git tree (Takashi's tree),
- all 20 patches against linux-omap.git tree (Tony's tree),
- make mcbsp part against Tony's tree and asoc part against Takashi's tree

Please do not apply this version. Let's define this first, then I send
the correct version.

BR,

> 
> 
> -- 
> Jarkko

-- 
Eduardo Valentin
