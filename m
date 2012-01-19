From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] Revert "ASoC: tlv320dac33: Use core to
 set the msbits constraint"
Date: Thu, 19 Jan 2012 18:26:02 +0000
Message-ID: <20120119182602.GM3178@opensource.wolfsonmicro.com>
References: <1326997456-16296-1-git-send-email-peter.ujfalusi@ti.com>
	<1326997456-16296-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B776624386
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 19:26:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326997456-16296-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 19, 2012 at 07:24:13PM +0100, Peter Ujfalusi wrote:
> The core implementation applies the msbits constraint to samples
> where it should not.
> Do not ask core to do this, the original code does the right thing.

Peter, grow up.  With my last patch (well, a typo fixed version of it)
userspace will do what you want.
