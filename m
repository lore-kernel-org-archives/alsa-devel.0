From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: MAX9877: separate callback functions
Date: Wed, 22 Jul 2009 10:41:34 +0100
Message-ID: <20090722094134.GA21171@rakim.wolfsonmicro.main>
References: <4A669EF4.2070504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 061EF1037E3
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 11:41:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A669EF4.2070504@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 22, 2009 at 02:09:08PM +0900, Joonyoung Shim wrote:
> The callback function to control register was used by whole controls in
> MAX9877 driver, but this causes using many if statement for double
> register control or invert.
> So, the callback function for double register control is separate
> differently, and the code for invert is added in the callback function.

> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>

Applied, thanks.
