From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: i.MX31L + AC97
Date: Thu, 10 Sep 2009 11:54:26 +0100
Message-ID: <20090910105426.GA15589@sirena.org.uk>
References: <200909091110.49628.gwossum@pager.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7ABEB24617
	for <Alsa-devel@alsa-project.org>;
	Thu, 10 Sep 2009 12:54:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200909091110.49628.gwossum@pager.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geoffrey Wossum <gwossum@pager.net>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 09, 2009 at 11:10:49AM -0500, Geoffrey Wossum wrote:

> It doesn't look like there are any AC97 SoC drivers for the i.MX31.  Is this 
> correct?  If so, should I try to get the board changed to use a codec on the 
> I2S bus (the board is being layed out right now), or would creating the AC97 
> driver simple enough that we should continue on with this hardware and write 
> the driver when needed?

The major problem with both AC97 and I2S on i.MX31 is that the SDMA
controller is not yet supported in mainline.  The recently merged i.MX
SSI driver should work fine on i.MX31 once the DMA is ready but, but on
the other hand the AC97 controller driver should be relatively simple
unless the hardware is particularly interesting.

In general I'd recommend I2S over AC97 for the wider range of CODECs.
