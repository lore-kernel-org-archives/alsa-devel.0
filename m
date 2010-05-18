From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: OMAP4: Add support for Earphone speaker
Date: Tue, 18 May 2010 08:00:53 -0700
Message-ID: <20100518150052.GA27313@opensource.wolfsonmicro.com>
References: <1274192636-1430-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71E7F243C8
	for <alsa-devel@alsa-project.org>;
	Tue, 18 May 2010 17:00:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1274192636-1430-1-git-send-email-jorge.candelaria@ti.com>
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
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 18, 2010 at 09:23:56AM -0500, Jorge Eduardo Candelaria wrote:
> Add control to enable earphone driver in TWL6040 codec. This driver
> is connected to HSDAC Left.
> 
> Also enable earphone speaker in sdp4430 machine driver.

Please don't merge patches like this - you should patch the machine
driver separately to the CODEC driver unless required for building.
This helps reduce merge problems, makes the changelogs easier to follow
and makes it easier to apply patches if there's review issues with one
part of them.

> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
