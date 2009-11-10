From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH V3] ASoC: omap-mcbsp - add support for upto
	16 channels.
Date: Tue, 10 Nov 2009 08:25:27 +0200
Message-ID: <200911100825.27587.peter.ujfalusi@nokia.com>
References: <1257793335.3583.277.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 72BB71037F9
	for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2009 07:25:35 +0100 (CET)
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
To: ext Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Monday 09 November 2009 21:02:15 ext Liam Girdwood wrote:
> This time we use wlen * channels when CODEC masters BCLK and FRAME,
> otherwise same as V2.
> 
> From: Graeme Gregory <gg@slimlogic.co.uk>
> 
> This patch increases the number of supported audio channels from 4
> to 16 and has been sponsored by Shotspotter Inc. It also fixes a
> FSYNC rate calculation bug when McBSP is FSYNC master.
> 
> Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>

Looks good, and works when OMAP McBSP is slave.
Thank you!

I'm not sure, if both acked and tested can be added...
Mark, please pick the relevant:

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
