From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC don't clobber platform DMA driver ops
Date: Wed, 2 Nov 2011 10:24:55 +0000
Message-ID: <20111102102455.GA27100@sirena.org.uk>
References: <1320181516-14186-1-git-send-email-alan.tull@freescale.com>
	<CAOZdJXULdoVU7qxwh+af=UO_ZxY5=Bu3PEO66DiMu-4Yr0gi4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 81D2724615
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 11:24:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAOZdJXULdoVU7qxwh+af=UO_ZxY5=Bu3PEO66DiMu-4Yr0gi4g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tull Alan-R80115 <R80115@freescale.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 02, 2011 at 03:40:48AM +0000, Tabi Timur-B04825 wrote:
> On Tue, Nov 1, 2011 at 4:05 PM, Alan Tull <alan.tull@freescale.com> wrote:

> > This patch creates and populates a ops struct for each call
> > to soc_pcm_new. ?Also creates a common soc_pcm_ioctl function
> > that calls all the driver components for ioctl calls.

> Maybe I'm missing something, but it looks like the ioctl stuff is not
> related to the ops stuff.  In other words, it looks like this patch
> does two completely different things.  Shouldn't it be broken into two
> patches?

Ideally.  The relationship is that it's making all the ops per-PCM
overridable rather than just a few as is the case currently.
