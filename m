From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Fix inverted Bass, Treble,
	Mono volume and Phone volume WM9712 mixer controls.
Date: Tue, 20 Nov 2007 17:40:47 +0000
Message-ID: <20071120174047.GD1744@sirena.org.uk>
References: <1195550746-6892-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1195550746-6892-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4742CE41.3010107@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C52024A33
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 18:40:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4742CE41.3010107@compulab.co.il>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: tiwai@suse.de, liam.girdwood@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Joe Sauer <jsauer@vernier.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 20, 2007 at 02:08:33PM +0200, Mike Rapoport wrote:

> I think there also should be "Mono Playback Switch", otherwise there's no way
> you can unmute mono playback:
> + SOC_SINGLE("Mono Playback Switch", AC97_MASTER_MONO, 15, 1, 1),

Yes, I'll add that hunk to the patch.  It's already in our development
branch.
