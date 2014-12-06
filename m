From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: usb-audio: Don't resubmit
	pending	URBs at MIDI error recovery
Date: Sat, 06 Dec 2014 20:54:48 +0100
Message-ID: <54835F08.9020500@ladisch.de>
References: <1417885834-10030-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 281DC2605A8
 for <alsa-devel@alsa-project.org>; Sat,  6 Dec 2014 20:55:20 +0100 (CET)
In-Reply-To: <1417885834-10030-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> In snd_usbmidi_error_timer(), the driver tries to resubmit MIDI input
> URBs to reactivate the MIDI stream, but this causes the error when
> some of URBs are still pending

I wonder what kept the other URBs alive.

> For avoiding these errors, check the pending URBs and skip
> resubmitting such ones.
>
> Reported-and-tested-by: Stefan Seyfried <stefan.seyfried@googlemail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Anyway,
Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  sound/usb/midi.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> index d3d49525a16b..5bfb695547f8 100644
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -365,6 +365,8 @@ static void snd_usbmidi_error_timer(unsigned long data)
>  		if (in && in->error_resubmit) {
>  			in->error_resubmit = 0;
>  			for (j = 0; j < INPUT_URBS; ++j) {
> +				if (atomic_read(&in->urbs[j]->use_count))
> +					continue;
>  				in->urbs[j]->dev = umidi->dev;
>  				snd_usbmidi_submit_urb(in->urbs[j], GFP_ATOMIC);
>  			}
