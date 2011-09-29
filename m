From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] fix the bug for WM8962 DSP_A and DSP_B
	settings
Date: Thu, 29 Sep 2011 11:11:59 +0100
Message-ID: <20110929101159.GE3697@opensource.wolfsonmicro.com>
References: <1317234480.4164.57.camel@susan-PowerEdge-T100>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9EFFC103A2B
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Sep 2011 12:12:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317234480.4164.57.camel@susan-PowerEdge-T100>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Susan Gao <sgao@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 28, 2011 at 11:28:00AM -0700, Susan Gao wrote:
> Signed-off-by: Susan Gao <sgao@opensource.wolfsonmicro.com>

Applied, though there were a couple of issues - I'm not entirely sure
what's going on here but I had to apply this by hand.  There was a word
wrapping issue but I fixed that and there was still an issue so I ended
up hand applying.  Please also remember to include the relevant prefix
in the commit log (ASoC: for audio drivers).
