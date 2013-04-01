From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: dapm: Remove redundant clear_walk()
 for supply widgets
Date: Mon, 01 Apr 2013 17:55:19 +0100
Message-ID: <1364835319.2416.13.camel@loki>
References: <1364769467-17146-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 890FF264F42
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2013 18:55:35 +0200 (CEST)
In-Reply-To: <1364769467-17146-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Ryo Tsutsui <Ryo.Tsutsui@wolfosonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 2013-03-31 at 23:37 +0100, Mark Brown wrote:
> From: Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>
> 
> We already clear the walked state in dapm_widget_power_check(), no need
> to do it again.
> 
> Signed-off-by: Ryo Tsutsui <Ryo.Tsutsui@wolfosonmicro.com>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
