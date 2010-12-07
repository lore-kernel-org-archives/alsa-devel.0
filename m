From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 15/15] ASoC: twl6040: Fix TLV dB step
	values for gains
Date: Tue, 7 Dec 2010 13:36:49 +0000
Message-ID: <20101207133649.GV4698@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCD5@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 91C63103AB1
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 14:36:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCD5@dlee06.ent.ti.com>
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

On Mon, Dec 06, 2010 at 06:18:23PM -0600, Olaya, Margarita wrote:
> Some gains were incorrectly configured for dB values.
> 
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but:

>  /*
>   * AFMGAIN volume control:
>   * from 18 to 24 dB in 6 dB steps
>   */
> -static DECLARE_TLV_DB_SCALE(afm_amp_tlv, 600, 600, 0);
> +static DECLARE_TLV_DB_SCALE(afm_amp_tlv, 1800, 600, 0);

this was only added earlier in the series - please fix up the original
patch if resubmitting.
