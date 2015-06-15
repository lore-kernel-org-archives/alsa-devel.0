From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [asoc:topic/topology 104/105] :undefined reference
 to `snd_soc_dapm_new_control'
Date: Mon, 15 Jun 2015 17:46:44 +0100
Message-ID: <1434386804.2434.36.camel@loki>
References: <201506041837.OFTVnhYj%fengguang.wu@intel.com>
 <20150604120418.GE14071@sirena.org.uk> <1433427189.19747.53.camel@loki>
 <20150615054205.GR28601@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B4B8265469
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 18:47:42 +0200 (CEST)
In-Reply-To: <20150615054205.GR28601@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-06-15 at 11:12 +0530, Vinod Koul wrote:
> On Thu, Jun 04, 2015 at 03:13:09PM +0100, Liam Girdwood wrote:
> > On Thu, 2015-06-04 at 13:04 +0100, Mark Brown wrote:
> > > On Thu, Jun 04, 2015 at 06:58:38PM +0800, kbuild test robot wrote:
> > > 
> > > > All error/warnings (new ones prefixed by >>):
> > > > 
> > > >    sound/built-in.o: In function `soc_tplg_dapm_widget_create':
> > > > >> :(.text+0x25a90): undefined reference to `snd_soc_dapm_new_control'
> > > 
> > > The fix for the build bug in your patch exporting this was to add a
> > > static prototype (you were in the CC for that fix) so now the topology
> > > code still doesn't have the export.
> > > 
> > > Can you send a fixup please?
> > 
> > Sorry, appended below. I can resend separately if required.
> I dont think Mark applied this, can you please resend
> 

Resending.

Liam
