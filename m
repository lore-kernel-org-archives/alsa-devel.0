From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/15] ASoC: twl6040: Clear interrupt
 status at boot time
Date: Tue, 7 Dec 2010 13:30:52 +0000
Message-ID: <20101207133051.GR4698@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCD1@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A36BD103AB1
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 14:30:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCD1@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 06, 2010 at 06:18:13PM -0600, Olaya, Margarita wrote:
> From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> 
> On Phoenix 1.1, the INTID register default value is an invalid
> one, causing the interrupt handler to think the phoenix power on
> sequence is ready before it actually finishes.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

2.6.37?
