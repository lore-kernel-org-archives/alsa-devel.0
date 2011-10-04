From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: wm8994: Is the rate_reg for wm8994-aif2
	correct?
Date: Tue, 4 Oct 2011 15:44:54 +0100
Message-ID: <20111004144453.GG6934@opensource.wolfsonmicro.com>
References: <1317737239.6419.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 941A424651
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 16:44:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317737239.6419.6.camel@phoenix>
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

On Tue, Oct 04, 2011 at 10:07:18PM +0800, Axel Lin wrote:

> While reading wm8994.c, it seems the correct rate_reg for wm8994-aif2
> should be WM8994_AIF2_RATE.
> I cannot find wm8994 datasheet, could you help checking it?

Looks good, I've applied - thanks!
