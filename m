From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/7] ASoC: Move card list initialization to
 snd_soc_register_card
Date: Mon, 31 Jan 2011 13:17:16 +0000
Message-ID: <20110131131715.GG5123@opensource.wolfsonmicro.com>
References: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D0334103897
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 14:17:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
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
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 28, 2011 at 02:26:35PM -0700, Stephen Warren wrote:
> All ASoC cards need snd_soc_initialize_card_lists called. Previously, it was
> only called for cards backed by a "soc-audio" platform device, via
> soc_probe(). However, it's also needed for cards backed by other platform
> devices, and registered directly via snd_soc_register_card().

All applied, thanks.
