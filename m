From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC V2] Update snd_soc_card_get_codec()
	to take the	codec number
Date: Fri, 6 Jun 2008 21:00:47 +0100
Message-ID: <20080606200047.GA3989@opensource.wolfsonmicro.com>
References: <1212768105-20738-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B83A244D7
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jun 2008 22:00:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1212768105-20738-1-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 06, 2008 at 11:01:45AM -0500, Timur Tabi wrote:
> Update function snd_soc_card_get_codec() and all the drivers that call it
> to take a codec number in addition to a codec name.  This is necessary for
> codec drivers that register multiple instances of themselves that differ
> only by codec number.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>

Looks good - thanks!
