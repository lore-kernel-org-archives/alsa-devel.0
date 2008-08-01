From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/14] ASoC: Allow codecs to
	override	register display
Date: Fri, 1 Aug 2008 11:00:03 +0100
Message-ID: <20080801100003.GA16420@rakim.wolfsonmicro.main>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<9e4733910807311841v3ebe98f5i327606d7d793f832@mail.gmail.com>
	<s5hk5f1jcl7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 87C3A24340
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 12:00:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk5f1jcl7.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 01, 2008 at 11:42:28AM +0200, Takashi Iwai wrote:
> Jon Smirl wrote:

> > Mark, I see this patch is already in your tree. I have rewritten it a
> > little differently to ensure that too many results can't be returned.
> > This is in my system and tested. I had a bug too so I know the
> > limiting it to pagesize code works.

> Mark's patch was already applied.  Could you re-generated your change
> based on that?

In general it's easiest if ASoC patches are generated against Takashi's
master branch - that's where ASoC gets merged and usually the diff
between the two trees is very small.
