From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v3 3/4] ARM: tegra: Platform data fixes for
 ASoC driver updates
Date: Fri, 21 Jan 2011 10:22:11 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310AD4254@HQMAIL01.nvidia.com>
References: <1295393859-3396-1-git-send-email-swarren@wwwdotorg.org>
	<1295556731-25165-4-git-send-email-swarren@nvidia.com>
	<20110120212259.GA21324@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4251@HQMAIL01.nvidia.com>
	<20110121175034.GC6200@opensource.wolfsonmicro.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310AD4252@HQMAIL01.nvidia.com>,
	<20110121181103.GA22414@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E377103B15
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 19:22:28 +0100 (CET)
In-Reply-To: <20110121181103.GA22414@opensource.wolfsonmicro.com>
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
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Erik Gilling (konkers@google.com)" <konkers@google.com>, "Colin Cross
	(ccross@google.com)" <ccross@google.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> It'd also be helpful if you could stop burying patches in old threads -
> it makes it hard to find the most recent stuff.

Sorry. I read somewhere that threading updates into the existing thread was the 
preferred way. I'll stop doing it.

> > To be explicit, the only dependency is that the patch quoted above, which
> > adds some platform data types, needs to be checked in to te ASoC tree
> > rather than the usual ARM tree, before the following ASoC patch is
> > applied:
> 
> ...but possibly not?

Sorry, I don't follow. Possibly not what? Are you saying:

a) Possibly not the only dependency? It's certainly the only one I know of.

b) Possibly not that it needs to be checked into the ASoC git repo, even though
the header is located somewhere the Tegra git repo owns?

I'm fine moving the header into some directory that ASoC owns, and fixing my
arch/arm/mach-tegra patch for the new location. That would mean that when I
submit the Tegra changes to the Tegra tree, the Tegra trees needs to have picked
up the ASoC changes first, but that's fine I think? At the least, it defers any issue
until later.

Otherwise, yes, that patch is needed befoer the ASoC patch that uses it, or there
will be a build break, if anyone enables building that driver.

-- 
nvpublic
