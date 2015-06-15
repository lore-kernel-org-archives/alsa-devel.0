From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: DAPM: fix build errors for missing
 snd_soc_dapm_new_control symbol
Date: Mon, 15 Jun 2015 18:10:33 +0100
Message-ID: <1434388233.2434.52.camel@loki>
References: <1434386871-24325-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20150615165723.GY18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4209726527F
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 19:10:36 +0200 (CEST)
In-Reply-To: <20150615165723.GY18309@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-06-15 at 17:57 +0100, Mark Brown wrote:
> On Mon, Jun 15, 2015 at 05:47:51PM +0100, Liam Girdwood wrote:
> > Fix the following error:-
> > 
> > All error/warnings (new ones prefixed by >>):
> > >
> > >    sound/built-in.o: In function `soc_tplg_dapm_widget_create':
> > > >> :(.text+0x25a90): undefined reference to `snd_soc_dapm_new_control'
> > 
> > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> 
> This doesn't apply, I appear to have this already?

Oh, ok - Vinod reported it was missing earlier and I could not see it in
your topic/topology either ?

Liam 
