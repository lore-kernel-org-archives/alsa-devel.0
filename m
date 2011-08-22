From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [RME MADI/RayDAT/AIO/AES] Changing hdspm_config
	and hdspm_status
Date: Mon, 22 Aug 2011 18:42:38 +0200
Message-ID: <4E5286FE.60603@drcomp.erfurt.thur.de>
References: <4E5283CB.7070902@drcomp.erfurt.thur.de>
	<4E528448.4020902@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id D6A2224158
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 18:42:52 +0200 (CEST)
In-Reply-To: <4E528448.4020902@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Robert Steffens <robert.steffens@iosono-sound.com>, Fredrik Lingvall <fredrik.lingvall@gmail.com>, Andre Schramm <andre.schramm@iosono-sound.com>, =?UTF-8?B?SsO2cm4gTmV0dGluZ3NtZWllcg==?= <nettings@stackingdwarves.net>
List-Id: alsa-devel@alsa-project.org

On 08/22/11 18:31, Adrian Knoth wrote:

> +		switch (hdspm->io_type) {
> +		case MADI:
> +		  config.card_specific.madi.line_out = hdspm_line_out(hdspm);
> +		  config.card_specific.madi.tms = hdspm_c_tms(hdspm);
> +		  config.card_specific.madi.input_select = hdspm_input_select(hdspm);
> +		  config.card_specific.madi.output_mode = hdspm_tx_64(hdspm);
> +		  config.card_specific.madi.sync_ref = hdspm_pref_sync_ref(hdspm);
> +		  break;
> +
> +		default:
> +		  break;
> +		}

Obviously, the other cards are missing. I can contribute RayDAT, if need
be (since I don't use the config ioctl at all, at least I don't need
it).

Fredrik: Do you still work on your hdspconf patch for hdspm? If so,
you'd probably be affected. Add "case MADIface:" below "case MADI:" to
see if it works.


>  			statusregister =
>  				hdspm_read(hdspm, HDSPM_statusRegister);
> -			status.card_specific.madi.madi_input =
> -				(statusregister & HDSPM_AB_int) ? 1 : 0;

MADI input (BNC/Optical) is a config option.

>  			status.card_specific.madi.channel_format =
> -				(statusregister & HDSPM_TX_64ch) ? 1 : 0;
> +				(statusregister & HDSPM_RX_64ch) ? 1 : 0;

This was simply wrong in the current driver: the status struct should
not tell if we're sending 64ch format, it should inform the user if
we're receiving 64ch on the wire.


Cheers
