From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Sync initial widget state with
	hardware
Date: Wed, 9 Feb 2011 17:59:08 +0000
Message-ID: <20110209175908.GA23747@opensource.wolfsonmicro.com>
References: <1297274183-12466-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65F31103999
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 18:59:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1297274183-12466-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 09, 2011 at 05:56:23PM +0000, Mark Brown wrote:
> ASoC generally uses the register defaults for everything, but in some
> cases the hardware will default to enabling some of the DAPM widgets
> (clocks for example). Ensure that DAPM knows about the actual widget
> state at initialisation by reading the enable bits after instantiating
> the widgets so they don't get left enabled needlessly.

Sorry, that's the wrong way to do this - will send an updated patch
shortly.
