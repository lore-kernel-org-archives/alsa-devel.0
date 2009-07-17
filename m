From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: SDP3430: Add support for EXTMUTE
	using TWL GPIO6
Date: Fri, 17 Jul 2009 10:11:13 +0100
Message-ID: <20090717091112.GB3439@rakim.wolfsonmicro.main>
References: <2256F256009DAA4CBE661E9F41EAC84B533409F1@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4DF1F10389F
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jul 2009 11:11:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B533409F1@dlee01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 14, 2009 at 08:04:08PM -0500, Candelaria Villareal, Jorge wrote:
> Board sdp3430 has hardware support for EXTMUTE using TWL4030 GPIO6
> line, controlled by register INTBR_PMBR1. Machine driver takes care
> of enabling gpio line through i2c and codec driver manipulates the
> line during headset ramp up/down sequence.

> Signed-off-by: Jorge Eduardo Candelaria <x0107209@ti.com>

Applied, thanks.
