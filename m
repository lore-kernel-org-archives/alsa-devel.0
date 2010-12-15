From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v3 2/2] ASoC: twl6040: Add ramp up/down
 volume for HS and HF
Date: Wed, 15 Dec 2010 21:42:45 +0000
Message-ID: <1292449365.3348.35.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCEA4EDD709@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 502D72465A
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 22:42:51 +0100 (CET)
Received: by wwe15 with SMTP id 15so1632993wwe.20
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 13:42:50 -0800 (PST)
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4EDD709@dlee06.ent.ti.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-12-14 at 19:18 -0600, Olaya, Margarita wrote:
> Add ramp functions for the headset and handsfree outputs
> in order to reduce the pops during power on/off sequences.
> 
> In order to give more control to volume ramp, step size and delay
> between steps can be specified.
> 
> The patches are based on wm8350 implementation from Liam
> Girdwood.
> 
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Magi, looks like your editor has automatically inserted spaces for tabs
on this patch. Could you change back to tabs and resend.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
