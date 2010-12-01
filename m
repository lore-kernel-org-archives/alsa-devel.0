From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix build failure in soc-core.c
Date: Wed, 1 Dec 2010 11:36:23 +0000
Message-ID: <20101201113623.GI24176@rakim.wolfsonmicro.main>
References: <20101201113138.f6146790.sfr@canb.auug.org.au>
 <1291187447-1247-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1291187447-1247-1-git-send-email-jhnikula@gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 01, 2010 at 09:10:47AM +0200, Jarkko Nikula wrote:
> Commit 2eea392 "ASoC: Add support for optional auxiliary dailess codecs"
> causes a build failure in soc-core.c: soc_probe_aux_dev since code tries to
> access non-existing struct snd_soc_dapm_context and struct snd_soc_card
> members.

Applied, thanks.
