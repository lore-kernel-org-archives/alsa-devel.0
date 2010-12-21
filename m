From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: twl6040: Convert HF and HS drivers
 to use DAPM OUT_DRV widget
Date: Tue, 21 Dec 2010 13:56:28 +0000
Message-ID: <1292939788.3296.41.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCEA4F6D2E0@dlee06.ent.ti.com>
	<20101220164401.GD14986@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 61246244FF
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 14:56:31 +0100 (CET)
Received: by wyi11 with SMTP id 11so3831284wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 21 Dec 2010 05:56:31 -0800 (PST)
In-Reply-To: <20101220164401.GD14986@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-12-20 at 16:44 +0000, Mark Brown wrote:
> On Mon, Dec 20, 2010 at 10:39:20AM -0600, Olaya, Margarita wrote:
> > Make the phoenix HS and HF drivers use the new DAPM driver
> > widget in order to guarantee power ON/OFF order sequence.
> > 
> > Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
