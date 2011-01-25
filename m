From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [GIT PULL] Branch to add harmony_audio.h to Tegra
	and ASoC
Date: Tue, 25 Jan 2011 20:21:56 +0000
Message-ID: <20110125202156.GA4605@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310955A8F@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C92CF244D8
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 21:21:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310955A8F@HQMAIL01.nvidia.com>
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
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Colin Cross (ccross@google.com)" <ccross@google.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 21, 2011 at 10:18:35PM -0800, Stephen Warren wrote:

> Please pull:

> http://avon.wwwdotorg.org/downloads/kernel.git tegra_harmony_asoc_platform_data
> 

That doesn't seem to work, git can't find the branch there (git
request-pull is your friend for checking this stuff).  I've created a
branch

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git tegra-arch

with the patch you posted to the mailing list and merged that into my
for-2.6.39 branch.
