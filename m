From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2] ASoC: TWL6040: Correct widget handling
 for drivers
Date: Sat, 17 Jul 2010 19:28:22 +0100
Message-ID: <1279391302.3070.12.camel@odin>
References: <1279211881-31416-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 94C08246E1
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jul 2010 20:28:24 +0200 (CEST)
Received: by wyf19 with SMTP id 19so3068248wyf.38
	for <alsa-devel@alsa-project.org>; Sat, 17 Jul 2010 11:28:24 -0700 (PDT)
In-Reply-To: <1279211881-31416-1-git-send-email-jorge.candelaria@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-07-15 at 11:38 -0500, Jorge Eduardo Candelaria wrote:
> In order to reduce pop-noise at powering up/down of the DACs and Drivers,
> these components have to be handled in a specific sequence. Headset,
> Handsfree, and Earphone drivers are now registered as PGA components to
> ensure DACs are enabled first.
> 
> Also, add a delay to leave time for DACs to settle before
> continuing power up/down sequence.
> 
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
