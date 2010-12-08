From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/3] ASoC: twl6040: Add jack support for
 headset and handset
Date: Wed, 8 Dec 2010 17:09:32 +0000
Message-ID: <20101208170932.GQ16418@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCEA4CFC927@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AFCEC24517
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 18:09:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4CFC927@dlee06.ent.ti.com>
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

On Wed, Dec 08, 2010 at 10:55:08AM -0600, Olaya, Margarita wrote:

>  	case TWL6040_PLUGINT:
> +		/* Debounce */
> +		msleep(200);

Hrm.  We're blocking the interrupt thread for an extended period, and
since we don't re-read the status after the debounce period the debounce
effectiveness will be substantially reduced, and may go very wrong if we
also get a removal interrupt queued up in the meantime as the removal
IRQ would then get processed even if the jack was actually inserted.

Scheduling a work item which checks the jack status (like hs_jack_detect
below does) for both plug and unplug IRQs would deal with this - the
work will get deferred each time we bounce, and the final status will
be whatever it stabalises at.

> +		report = jack->report;
> +		/*
> +		 * Early interrupt, CODEC driver cannot report jack status
> +		 * since jack is not registered yet. MACHINE driver will
> +		 * register jack and report status thru twl6040_hs_jack_detect
> +		 */
> +		if (jack->jack)
> +			snd_soc_jack_report(jack->jack, report, jack->report);

The jack API should handle null jacks happily.

> +struct twl6040_setup_data {
> +	void (*codec_enable)(int enable);
> +	void *jack;
> +};

The jack doesn't look to be used in this, and I guess the codec enable
belongs with something else?
