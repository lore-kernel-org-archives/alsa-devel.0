From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: TWL6040: Correct widget handling
	for drivers
Date: Fri, 16 Jul 2010 09:21:13 +0100
Message-ID: <20100716082113.GC9082@rakim.wolfsonmicro.main>
References: <1279211881-31416-1-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E88524395
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 10:21:16 +0200 (CEST)
Content-Disposition: inline
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
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 15, 2010 at 11:38:01AM -0500, Jorge Eduardo Candelaria wrote:
> In order to reduce pop-noise at powering up/down of the DACs and Drivers,
> these components have to be handled in a specific sequence. Headset,
> Handsfree, and Earphone drivers are now registered as PGA components to
> ensure DACs are enabled first.
> 
> Also, add a delay to leave time for DACs to settle before
> continuing power up/down sequence.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
