From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: sdp4430: Add Jack support
Date: Mon, 6 Dec 2010 22:55:44 +0000
Message-ID: <20101206225544.GG2862@opensource.wolfsonmicro.com>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E83@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2801F10391A
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 23:55:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4C52E83@dlee06.ent.ti.com>
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

On Mon, Dec 06, 2010 at 04:34:53PM -0600, Olaya, Margarita wrote:

> From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> 
> Use jack framework to enable detection for the headset microphone
> and stereo output.

This looks OK but...

> +	twl6040_hs_jack_detect(codec, &hs_jack, SND_JACK_HEADSET);
>  	return ret;

...this function doesn't appear to be in mainline yet?
