From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [GIT PULL] ASoC updates for v3.18
Date: Tue, 7 Oct 2014 11:12:44 -0700
Message-ID: <20141007181243.GB2796@Alpha>
References: <20141006115105.GL4609@sirena.org.uk>
 <s5htx3hxtjy.wl-tiwai@suse.de>
 <20141007171436.GA23707@sirena.org.uk>
 <20141007180135.GA2796@Alpha> <s5hegujlpmb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id B260D260453
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 20:12:48 +0200 (CEST)
Received: by mail-pd0-f172.google.com with SMTP id ft15so5440869pdb.17
 for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2014 11:12:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hegujlpmb.wl-tiwai@suse.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Sachin Kamat <sachin.kamat@samsung.com>, Mark Brown <broonie@kernel.org>, Sean Cross <xobs@kosagi.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 07, 2014 at 08:08:12PM +0200, Takashi Iwai wrote:
> At Tue, 7 Oct 2014 11:01:36 -0700,
> Nicolin Chen wrote:
> > 
> > On Tue, Oct 07, 2014 at 06:14:36PM +0100, Mark Brown wrote:
> > > On Mon, Oct 06, 2014 at 02:37:53PM +0200, Takashi Iwai wrote:
> > > > Mark Brown wrote:
> > > 
> > > > However, this resulted in a few new build warnings, and some of them
> > > > look correctly reported.
> > > 
> > > > *  sound/soc/codecs/mc13783.c:787:13: warning: 'np' may be used uninitialized in this function [-Wuninitialized]
> > > 
> > > > The call of_node_put(np) is done unconditionally even for non-NULL
> > > > pdata where np isn't initialized.  This may lead to a real crash.
> > > 
> > > > * sound/soc/fsl/eukrea-tlv320.c:221:14: warning: 'ssi_np' may be used uninitialized in this function [-Wuninitialized]
> > > 
> > > > A similar bug: of_node_put(ssi_np) is reached even before ssi_np is
> > > > initialized.
> > > 
> > > > * sound/soc/fsl/imx-es8328.c:196:13: warning: 'codec_np' may be used uninitialized in this function [-Wuninitialized]
> > > > * sound/soc/fsl/imx-es8328.c:195:13: warning: 'ssi_np' may be used uninitialized in this function [-Wuninitialized]
> > > 
> > > > Ditto. 
> > > 
> > > > Relevant people put in Cc.  I hope I'll get a new pull request soon
> > > > later :)
> > > 
> > > You missed CCing the Freescale guys and Timur so you're missing most of
> > > the relevant people here; adding them now.
> > 
> > Generally we fetch ssi_np and codec_np before other operations.
> > But somehow these two are doing the fetching a bit later.
> > 
> > However, I think the below change can be a quick reasonable fix:
> > -       struct device_node *ssi_np, *codec_np;
> > +       struct device_node *codec_np = NULL;
> > +       struct device_node *ssi_np = NULL;
> > 
> > I'm patching and taking build test. Will send them soon.
> 
> Patches have been already sent, check ML :)

Oh..a bit late I'm...

Thank you for the patches :)

Nicolin
