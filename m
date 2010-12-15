From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/2] ASoC: twl6040: Set default gains to
 minimun value
Date: Wed, 15 Dec 2010 13:55:13 +0000
Message-ID: <20101215135513.GB9275@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCEA4EDD708@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 93A31103859
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 14:55:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4EDD708@dlee06.ent.ti.com>
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

On Tue, Dec 14, 2010 at 07:18:36PM -0600, Olaya, Margarita wrote:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but...

>  		/* initialize vdd/vss registers with reg_cache */
>  		twl6040_init_vdd_regs(codec);
> +
> +		/* Set external boost GPO */
> +		twl6040_write(codec, TWL6040_REG_GPOCTL, 0x02);

This sounds like it should be managed as a DAPM widget?  
