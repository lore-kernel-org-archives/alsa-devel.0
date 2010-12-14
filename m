From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: dapm: Add output driver widget
Date: Tue, 14 Dec 2010 14:22:37 +0000
Message-ID: <20101214142237.GC13649@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCEA4E225E0@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AEE6C245D1
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 15:22:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4E225E0@dlee06.ent.ti.com>
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

On Fri, Dec 10, 2010 at 09:11:44PM -0600, Olaya, Margarita wrote:
> In some cases it was not possible to follow the appropiate power
> ON/OFF sequence like in cases where the PGA needs to be enabled
> before the driver and disabled before the PGA for pop reduction.
> 
> Add a widget to support output driver (speaker, haptic, vibra, etc)
> drivers where power ON/OFF ordering is important.
> 
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>

Applied, thanks.
