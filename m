From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 1/1] ASoC: Intel: Use acpi_dev_present()
Date: Mon, 25 Jan 2016 22:13:58 +0100
Message-ID: <20160125211358.GA10561@wunner.de>
References: <cover.1452787340.git.lukas@wunner.de>
 <04b22878b2fa0a00bad68e1570502fe64f94fb25.1452787340.git.lukas@wunner.de>
 <20160125154846.GV6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [176.9.242.54]) by alsa0.perex.cz (Postfix) with ESMTP id 670D726058F
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 22:14:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160125154846.GV6588@sirena.org.uk>
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
Cc: Vinod Koul <vinod.koul@intel.com>, "Fang, Yang A" <yang.a.fang@intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Jan 25, 2016 at 03:48:46PM +0000, Mark Brown wrote:
> On Thu, Jan 14, 2016 at 09:57:20PM +0100, Lukas Wunner wrote:
> > Use shiny new acpi_dev_present() and remove all the boilerplate
> > to search for a particular ACPI device. No functional change.
> > Cf. 2d12b6b381ba ("ACPI / utils: Add acpi_dev_present()").
> > 
> > v2: Rebase on commit 95f098014815 ("ASoC: Intel: Move apci find
> >     machine routines").
> 
> As covered in SubmittingPatches don't include inter-version changelogs
> in the body of your commit log, put them after the ---.  They are
> meaningless once the change is applied without the rest of the history. 

I'm used to the drm and drm-intel practice of including the changelog
in the commit message, but will remember to move it to the git notes
when posting to alsa-devel in the future.

Thanks,

Lukas
