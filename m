From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: alsactl init - implementation and more..
Date: Wed, 13 Aug 2008 16:22:19 +0100
Message-ID: <20080813152218.GR30710@sirena.org.uk>
References: <Pine.LNX.4.61.0808131205130.21669@tm8103-a.perex-int.cz>
	<s5h3al99ixf.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0808131510350.21669@tm8103-a.perex-int.cz>
	<s5hskt980d3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 924CE10388D
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 17:22:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hskt980d3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 13, 2008 at 04:18:16PM +0200, Takashi Iwai wrote:

> Of course, it's a question how fine-grained each file should be.  But
> in general, modifying the default configuration just for adding a new,
> fairly independent item is a bad idea.  In my scenario: you want to
> add the support for a new hardware -- fine, just add the file without
> changing anything else.  This would make the maintenance a lot easier

Yeah, I can see embedded people liking this too - a relatively small
proportion of machines end up submitting their code to mainline for
various reasons and carrying patches is no fun.

> (imagine you maintain a distro package).

Or use one, for that matter - if you've got local changes then you need
to resolve the conflicts between them and the distro versions on every
upgrade.

> > I'm not sure. The restore action will always overwrite all 'init' values 
> > (at least when control identifier list is not changed in the driver). 
> > Probably, I would prefer a buildin procedure like 'if restore fails then 
> > do init'. What about 'alsactl boot' action name?

> The init makes sense in the case when the driver is updated and some
> new controls.  Then the newly added controls are set up properly, then
> the other values are overwritten via restore.

I've not looked at the new code yet but it would be *really* nice to
have a format where only the control names are used.
