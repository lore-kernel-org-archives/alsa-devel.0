From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: davinci-i2c,pcm updates
Date: Mon, 6 Jul 2009 22:41:49 +0100
Message-ID: <20090706214149.GC25548@sirena.org.uk>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090705114122.GA5334@sirena.org.uk>
	<4A526CED.7050606@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 37CDD24533
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 23:41:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A526CED.7050606@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: khilman@deeprootsystems.com, Chaithrika U S <chaithrika@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 06, 2009 at 02:30:21PM -0700, Troy Kisky wrote:

> ARM: DaVinci: Interface changes visible to EDMA clients

> But the last patch in series needs rebased on to this. Unfortunately,
> this patch is not yet in your for-2.6.32 branch. So, unless this patch
> is going to merge first, I show remove the need for this patch???

Unless you can make your changes such that the above patch will merge in
cleanly there's no point - we'll need to deal with the cross tree merge
issues somehow.  That'll require coordination with Kevin; probably the
best approach is to make a small branch which can be merged into both
trees but that may be too involved.

The other options are to punt on the patch until after the merges have
happened, cherry pick a small number of commits over in one direction or
another to preserve buildability or just accept that DaVinci ASoC will
need to be built from -next for this merge window.  Since pretty much
everyone working on DaVinci appears to be using the DaVinci tree rather
than mainline at the minute the latter option isn't as bad as it could
be.  I'm not sure what works best for you guys?
