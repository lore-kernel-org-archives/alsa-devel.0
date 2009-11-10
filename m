From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3] ASoC: omap-mcbsp - add support for upto
 16 channels.
Date: Tue, 10 Nov 2009 12:05:08 +0000
Message-ID: <20091110120508.GA16200@rakim.wolfsonmicro.main>
References: <1257793335.3583.277.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 243AC24363
	for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2009 13:05:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257793335.3583.277.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 09, 2009 at 07:02:15PM +0000, Liam Girdwood wrote:
> This time we use wlen * channels when CODEC masters BCLK and FRAME,
> otherwise same as V2.

Applied, thanks.

> From: Graeme Gregory <gg@slimlogic.co.uk>

git am doesn't appear to notice From lines that aren't the very first
line of the body.
