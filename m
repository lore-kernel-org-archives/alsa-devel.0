From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/7] ASoC: Move card list initialization to
 snd_soc_register_card
Date: Mon, 31 Jan 2011 12:08:33 +0000
Message-ID: <1296475713.3316.52.camel@odin>
References: <1296250001-6348-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E6EE24509
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 13:08:38 +0100 (CET)
Received: by wwe15 with SMTP id 15so5478084wwe.20
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 04:08:37 -0800 (PST)
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
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-01-28 at 14:26 -0700, Stephen Warren wrote:
> All ASoC cards need snd_soc_initialize_card_lists called. Previously, it was
> only called for cards backed by a "soc-audio" platform device, via
> soc_probe(). However, it's also needed for cards backed by other platform
> devices, and registered directly via snd_soc_register_card().
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
