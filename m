From: Daniel Mack <zonque@gmail.com>
Subject: Re: [Alsa-user] Status of CM6631 USB
Date: Sat, 02 Mar 2013 13:21:46 +0100
Message-ID: <5131EEDA.2080408@gmail.com>
References: <50C84912.2060101@gmail.com>
 <zarafa.50c8f526.38ee.0f2e389740303d7c@sd-30434.simplynux.net>
 <50C8F75B.5050209@gmail.com> <loom.20130302T120058-624@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
 [74.125.82.170])
 by alsa0.perex.cz (Postfix) with ESMTP id BD493261600
 for <alsa-devel@alsa-project.org>; Sat,  2 Mar 2013 13:21:48 +0100 (CET)
Received: by mail-we0-f170.google.com with SMTP id z53so3400597wey.1
 for <alsa-devel@alsa-project.org>; Sat, 02 Mar 2013 04:21:48 -0800 (PST)
In-Reply-To: <loom.20130302T120058-624@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Torstein Hegge <hegge@resisty.net>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Torstein,

(+ alsa-devel)

On 02.03.2013 12:09, Torstein Hegge wrote:
> Daniel Mack <zonque <at> gmail.com> writes:
>>>> This is a known bug, also most probably flaw in the CMEDIA chip, 
>>>> and not yet properly worked around in the snd-usb driver. If you 
>>>> want to investigate, have a look at the feedback format 
>>>> autodetection code in sound/usb/endpoint.c.
>>>
>>> Thanks, I'll have a look.
>>
>> I believe what's going on here is that the device is confused after
>> sample rate changes and keeps sending back feedback data for the old
>> rate on its feedback endpoint. That causes the autodetection algorithm,
>> which kicks in on every first packet of a stream, to go nuts, which
>> causes the part of the driver that sends the data assume a very wrong
>> rate. Some printk() there should give you a hint.
> 
> I had a look at this using another C-Media CM6631 based device, the Corda
> Daccord (usbid 0x0d8c, 0x0309). As far as I can see, what happens in the
> feedback format auto-detection is: 
> 
> When starting playback of a file with a different sampling frequency than the 
> previous file, the reported feedback frequency is in the same range as the 
> previously played file, varying within +-1%.
> 
> The feedback format detection gives a shift of -1 and reports the feedback
> frequency as ~48kHz when playing a 44.1kHz file after a 96kHz file. Same thing
> happens when playing a 96kHz file after a 44.1kHz file, the device reports
> feedback frequency in the 44.1kHz range, the feedback format detection gives a
> shift of +1 and reports the feedback frequency as ~88kHz.

That's what I suspected.

> Bypassing the feedback format detection by hard-coding the frequency shift to
> zero and setting the feedback frequency ep->freqm equal to the nominal
> frequency ep->freqn if the feedback frequency is far off from the expected
> value (like 48kHz when expecting 44.1kHz) does not change the distortion.
> 
> Similarly, forcing the feedback detection to run multiple times until it
> reaches an acceptable value just keeps the feedback detection to repeatedly
> until playback is stopped. This probably means any amount of skipping packages
> early in the stream won't work.

Ok.

> It seems like the device stays in the previous frequency until the interface
> is reset. One possible workaround is to call usb_set_interface() again after
> snd_usb_init_sample_rate(), like this:

I see - that also explains why explicitly stopping and restarting the
stream fixes the problem in most cases, right?

> 
> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> index d82e378..01978a6 100644
> --- a/sound/usb/pcm.c
> +++ b/sound/usb/pcm.c
> @@ -710,6 +710,16 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream
> *substream)
>                 subs->need_setup_ep = false;
>         }
>  
> +       /* Some devices doesn't respond to sample rate changes while the 
> +        * interface is active. */
> +       switch (subs->stream->chip->usb_id) {
> +       case USB_ID(0x0d8c, 0x0304): /* C-Media - Schiit USB Interface */
> +       case USB_ID(0x0d8c, 0x0309): /* C-Media CM6631 */
> +               usb_set_interface(subs->dev, subs->cur_audiofmt->iface,
> +                                       subs->cur_audiofmt->altset_idx);
> +               break;
> +       }   
> +
>         /* some unit conversions in runtime */
>         subs->data_endpoint->maxframesize =
>                 bytes_to_frames(runtime, subs->data_endpoint->maxpacksize);
> 
> This fixes all problems related to sample rate changes for me. I have only
> tested with the Daccord, but it should work for the Schiit and other CM6631
> based devices as well.

Many thanks for looking into this! Much appreciated.

Could you cook a real patch please and send it to alsa-devel? Have a
look at Documentation/SubmittingPatches if that's your first submission.


Best,
Daniel
