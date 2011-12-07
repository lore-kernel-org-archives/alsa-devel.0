From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8903: Add of_match_table
Date: Wed, 7 Dec 2011 21:51:14 +0800
Message-ID: <20111207135113.GC18837@opensource.wolfsonmicro.com>
References: <1323206141-3065-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8A60624708
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2011 14:51:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323206141-3065-1-git-send-email-swarren@nvidia.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 06, 2011 at 02:15:41PM -0700, Stephen Warren wrote:
> This allows the device to be matched against the device tree using the
> compatible flag directly, as is standard, rather than falling back to
> matching .id_table against the non-vendor portion of the first compatible
> property value.

Applied, thanks.
