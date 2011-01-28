From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ASoC: Fix typo in snd_soc_dapm_put_volsw
Date: Fri, 28 Jan 2011 08:16:27 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310C8DF11@HQMAIL01.nvidia.com>
References: <1296165245-10828-1-git-send-email-swarren@nvidia.com>
	<20110128131242.GA11125@sirena.org.uk>
	<20110128132101.GB11125@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DF052412E
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 17:16:31 +0100 (CET)
In-Reply-To: <20110128132101.GB11125@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote at: Friday, January 28, 2011 6:21 AM:
> 
> On Fri, Jan 28, 2011 at 01:12:43PM +0000, Mark Brown wrote:
> 
> > snd_soc_dapm_put_volsw() has variables for both the unshifted and
> > shifted mask for updates commit 97404f (ASoC: Do DAPM control updates in
> > the middle of DAPM sequences) got confused between the two of these.
> > Since there's no need to keep a copy of the unshifted mask fix this and
> > simplify the code by using only one mask variable.
> 
> Applied with the changelog rewritten to the above - good spot, thanks!

Yeah sorry, the original patch was:

-                update.mask = mask;
+                update.mask = val_mask;

But once that was done, there was an unused variable which I ended up
removing, but completely forgot that I should rewrite the commit
description. I realized this last night and was going to correct it
today.

Sorry.

-- 
nvpublic
