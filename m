From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [GIT PULL] ASoC fixes for v4.14
Date: Tue, 31 Oct 2017 13:34:47 +0530
Message-ID: <20171031080447.GL3187@localhost>
References: <20171026141314.f7bckpfhy5p2ipmw@sirena.org.uk>
 <s5hinf1lmv8.wl-tiwai@suse.de>
 <20171027063916.xkhmpk673eqh7424@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A5AD5266A0C
 for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2017 09:01:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171027063916.xkhmpk673eqh7424@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Chintan Patel <chintan.m.patel@intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 27, 2017 at 08:39:16AM +0200, Mark Brown wrote:
> On Thu, Oct 26, 2017 at 09:39:39PM +0200, Takashi Iwai wrote:
> 
> > IMO, my PCM unbind workaround can be postponed to 4.15, as the unbind
> > is still broken even with this.  It can be combined with other unbind
> > fixes.
> 
> > Also, topology fixes are only potential issues, and no urgent fixes
> > for the bugs we're hitting now.  So they can be postponed, too.
> 
> For me I'd prioritize getting things into the core over other things
> (and both fixes are small) but these are the ones you want to drop.  I'd
> say the topology bugs are just straight up bugs, someone with the
> ability to replace the topology file can readily trigger them (as could
> disk corruption) and the null pointer dereference is definitely severe
> enough that we should just fix it.
> 
> I guess we could try to drop all the resource leak fixes but several of
> them are in with other patches in branches.
> 
> > One Skylake jack name fix is actually wrong.
> > It sets "HDMI/DP, pcm=%d Jack", but the right name is without space,
> > i.e. "HDMI/DP,pcm=%d Jack".
> 
> So how did they test that fix then...  bah.

Oops, this came from Chrome, so I guess CRAS is happy with space.

I will send fix and yes they can goto next merge window.

Sorry for the miss

-- 
~Vinod
