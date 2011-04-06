From: Tarek Soliman <tarek@bashasoliman.com>
Subject: Re: [PATCH] ALSA: usb-audio: define another USB ID for
 a buggy USB MIDI cable
Date: Tue, 5 Apr 2011 21:35:12 -0500
Message-ID: <20110406023512.GA29973@zeus.olympus>
References: <20110404142353.GA3821@zeus.olympus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by alsa0.perex.cz (Postfix) with ESMTP id 04321103819
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Apr 2011 04:35:14 +0200 (CEST)
Received: from tsoliman by zeus.olympus with local (Exim 4.72)
	(envelope-from <tsoliman@bashasoliman.com>) id 1Q7IaP-0007nh-0y
	for alsa-devel@alsa-project.org; Tue, 05 Apr 2011 21:35:13 -0500
Content-Disposition: inline
In-Reply-To: <20110404142353.GA3821@zeus.olympus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 04, 2011 at 09:23:53AM -0500, Tarek Soliman wrote:
> There are many USB MIDI cables out there that have buggy
> firmware that reports it can do more than 4 bytes in a
> packet when they can only properly handle 4
> 
> This patch adds the ID of yet another one of those cables
> 
> Signed-off-by: Tarek Soliman <tarek@bashasoliman.com>
> ---
>  sound/usb/midi.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> index b4b39c0..f928910 100644
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -1301,6 +1301,7 @@ static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi* umidi,
>  	case USB_ID(0x15ca, 0x0101): /* Textech USB Midi Cable */
>  	case USB_ID(0x15ca, 0x1806): /* Textech USB Midi Cable */
>  	case USB_ID(0x1a86, 0x752d): /* QinHeng CH345 "USB2.0-MIDI" */
> +	case USB_ID(0xfc08, 0x0101): /* Unknown vendor Cable */
>  		ep->max_transfer = 4;
>  		break;
>  		/*
> -- 
> 1.7.4.1
> 
> As instructed, I updated the insertion point of the new entry such
> that the entries are sorted.

Hi,

Is there anything else required for this to be merged?
I am very new to this.
-- 
Tarek
