From: mick <mick37@gmx.de>
Subject: Re: Tenor TE8802,
 USB : clics and crackles during music play
Date: Tue, 08 Apr 2014 10:13:16 +0200
Message-ID: <op.xdznse1cwx6sbz@ws00534.pq>
References: <CA+T9nP_hcPQBoQwike7oB5TfECax2MvARv0dTG9qB-RdFMuy=w@mail.gmail.com>
 <CA+T9nP-=ffsy9ftnxynUhdJK_Eev+S-MRznLz7CED-Yp3DiOjg@mail.gmail.com>
 <20140114143417.GB23764@tamtam.fritz.box>
 <loom.20140404T165417-983@post.gmane.org> <533ECF3C.3020404@ladisch.de>
 <op.xdya5wmiwx6sbz@ws00534.pq> <534305F1.8040805@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 40A2D267387
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 10:13:22 +0200 (CEST)
In-Reply-To: <534305F1.8040805@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

please help me out: are you asking me personally to test or is this a  
general call for the group?
If you need me to test, what version of kernel sources do I patch? I am  
probably not running the latest. Forgive the questions, I do not routinely  
do these things.
Also: Your patch looks quite different from the solution I pointed out.  
Why? Did you test it yourself? In particular the assertion:
> +		 * The TEAC UD-H01 firmware sometimes changes the feedback value
> +		 * by +/- 0x1.0000.
is quite different from the assertion
"the 3rd byte of the feadback value is getting corrupted and probably  
changing when it should not "
 from  
http://forums.slimdevices.com/showthread.php?93310-Async-USB-Dac-Experiments-testers-wanted/page30.
Also, you made it quite explicit for the TEAC UD-H01 but I think it should  
be more general. I have the Teac A-H01 and it also has the problem. As far  
as I gather from the various discussions on the Web it probably is a  
general Tenor 8802 issue. For instance with Nuforce DAC-9 here:
http://www.spinics.net/linux/fedora/alsa-user/msg11387.html

Mick



On Mon, 07 Apr 2014 22:09:21 +0200, Clemens Ladisch <clemens@ladisch.de>  
wrote:

> Please test this patch:
>
> --8<----------------------------------------------------------------->8--
> ALSA: usb-audio: work around corrupted TEAC UD-H01 feedback data
>
> The TEAC UD-H01 firmware sends wrong feedback frequency values, thus
> causing the PC to send the samples at a wrong rate, which results in
> clicks and crackles in the output.
>
> Add a workaround to detect and fix the corruption.
>
> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
> Tested-by: Mick <mick37@gmx.de>
> Cc: <stable@vger.kernel.org>
> ---
>  sound/usb/card.h     |    1 +
>  sound/usb/endpoint.c |   15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/sound/usb/card.h b/sound/usb/card.h
> index 9867ab8..97acb90 100644
> --- a/sound/usb/card.h
> +++ b/sound/usb/card.h
> @@ -92,6 +92,7 @@ struct snd_usb_endpoint {
>  	unsigned int curframesize;      /* current packet size in frames (for  
> capture) */
>  	unsigned int syncmaxsize;	/* sync endpoint packet size */
>  	unsigned int fill_max:1;	/* fill max packet size always */
> +	unsigned int udh01_fb_quirk:1;	/* corrupted feedback data */
>  	unsigned int datainterval;      /* log_2 of data packet interval */
>  	unsigned int syncinterval;	/* P for adaptive mode, 0 otherwise */
>  	unsigned char silence_value;
> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> index e70a87e..7b400eb 100644
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -471,6 +471,10 @@ struct snd_usb_endpoint  
> *snd_usb_add_endpoint(struct snd_usb_audio *chip,
>  			ep->syncinterval = 3;
>
>  		ep->syncmaxsize = le16_to_cpu(get_endpoint(alts, 1)->wMaxPacketSize);
> +
> +		if (chip->usb_id == USB_ID(0x0644, 0x8038) /* TEAC UD-H01 */ &&
> +		    ep->syncmaxsize == 4)
> +			ep->udh01_fb_quirk = 1;
>  	}
>
>  	list_add_tail(&ep->list, &chip->ep_list);
> @@ -1105,7 +1109,16 @@ void snd_usb_handle_sync_urb(struct  
> snd_usb_endpoint *ep,
>  	if (f == 0)
>  		return;
>
> -	if (unlikely(ep->freqshift == INT_MIN)) {
> +	if (unlikely(ep->udh01_fb_quirk)) {
> +		/*
> +		 * The TEAC UD-H01 firmware sometimes changes the feedback value
> +		 * by +/- 0x1.0000.
> +		 */
> +		if (f < ep->freqn - 0x8000)
> +			f += 0x10000;
> +		else if (f > ep->freqn + 0x8000)
> +			f -= 0x10000;
> +	} else if (unlikely(ep->freqshift == INT_MIN)) {
>  		/*
>  		 * The first time we see a feedback value, determine its format
>  		 * by shifting it left or right until it matches the nominal


-- 
Erstellt mit Operas E-Mail-Modul: http://www.opera.com/mail/
