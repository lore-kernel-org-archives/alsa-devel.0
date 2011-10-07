From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/11] ASoC: wm8990: Convert to
	snd_soc_cache_sync
Date: Fri, 7 Oct 2011 11:23:27 +0100
Message-ID: <20111007102326.GE19080@opensource.wolfsonmicro.com>
References: <1317944619.5579.1.camel@phoenix>
	<1317945413.5579.17.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DBC61103810
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 12:23:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317945413.5579.17.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 07, 2011 at 07:56:53AM +0800, Axel Lin wrote:
> Convert codec->hw_write to snd_soc_cache_sync

This doesn't apply against current code, mostly due to a version of the
patch already having been applied and a conflict with your subsequent
patch updating the comments.
