From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 08/11] ASoC: tegra: Add tegra-pcm driver
Date: Wed, 22 Dec 2010 20:16:23 +0000
Message-ID: <20101222201622.GC8167@opensource.wolfsonmicro.com>
References: <1292622090-21896-1-git-send-email-swarren@nvidia.com>
	<1292622090-21896-9-git-send-email-swarren@nvidia.com>
	<20101217220658.GG25609@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF030FD78DB5@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3E6C224582
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 21:16:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF030FD78DB5@HQMAIL01.nvidia.com>
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
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Colin Cross (ccross@google.com)" <ccross@google.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 22, 2010 at 11:03:29AM -0800, Stephen Warren wrote:

> Given all that, I'm tempted to simply stick with single-shot mode for now.

That sounds fair enough, it's just a bit surprising to see code doing
single shot mode since it is very unusual for an audio DMA controller
and tends to cause pain due to the more active management needed.
