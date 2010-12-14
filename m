From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: Fix 24bit support
Date: Tue, 14 Dec 2010 11:49:14 +0000
Message-ID: <20101214114914.GB13649@rakim.wolfsonmicro.main>
References: <1292327129-19417-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 44D8410384B
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 12:49:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1292327129-19417-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 14, 2010 at 01:45:29PM +0200, Peter Ujfalusi wrote:
> twl4030 series of codecs supports S32_LE with msbits=24.
> Replace the S24_LE with S32_LE format, and add constraint
> for 24msbit in case of 32 S32_LE format.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

There's no real need to add the constraint for 24 bit - the CODEC will
quite happily consume 32 bit data, it'll just ignore the 8 LSB.  We
should probably do something more sensible with the format stuff, it's
never been a terribly pressing issue though.
