From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [asoc:for-next 110/115] sound/soc/soc-core.c:901
 soc_bind_dai_link() error: we previously assumed
 'dai_link->platform_of_node' could be null (see line 887)
Date: Tue, 11 Sep 2012 11:26:21 +0800
Message-ID: <20120911032619.GA4541@opensource.wolfsonmicro.com>
References: <20120911030003.GB23365@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D8B35264F25
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 05:26:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120911030003.GB23365@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 11, 2012 at 11:00:03AM +0800, Fengguang Wu wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> head:   bffb28a4233d25d37a444785f766e98a041b4413
> commit: a6179d2741640a1ec88a1c5b9c2c28bdf45666db [110/115] ASoC: core: display the platform node name if there is no platform name
> 
> All smatch warnings:
> 
> + sound/soc/soc-core.c:901 soc_bind_dai_link() error: we previously assumed 'dai_link->platform_of_node' could be null (see line 887)

I've dropped the patch.
