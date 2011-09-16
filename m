From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 17:44:13 +0100
Message-ID: <20110916164412.GD23727@opensource.wolfsonmicro.com>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D609243A1
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 18:44:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316182614-9666-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2011 at 09:16:54AM -0500, Timur Tabi wrote:

> Although the WM8776 driver includes a .set_sysclk function, it was also
> hard-coding the list of supported sample rates.  We change the hard-coded
> list to a range within the capabilities of the WM8776 itself.

No, it doesn't - it just blindly stores the sample rate in the private
data.  There's no list at all there, the only checking that's done is
for the DAI ID.

Anyway, I've applied with a rewritten changelog.
