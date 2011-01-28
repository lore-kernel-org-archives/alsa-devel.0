From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix typo in snd_soc_dapm_put_volsw
Date: Fri, 28 Jan 2011 13:21:02 +0000
Message-ID: <20110128132101.GB11125@sirena.org.uk>
References: <1296165245-10828-1-git-send-email-swarren@nvidia.com>
	<20110128131242.GA11125@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 274872457A
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 14:21:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110128131242.GA11125@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 28, 2011 at 01:12:43PM +0000, Mark Brown wrote:

> snd_soc_dapm_put_volsw() has variables for both the unshifted and
> shifted mask for updates commit 97404f (ASoC: Do DAPM control updates in
> the middle of DAPM sequences) got confused between the two of these.
> Since there's no need to keep a copy of the unshifted mask fix this and
> simplify the code by using only one mask variable.

Applied with the changelog rewritten to the above - good spot, thanks!
