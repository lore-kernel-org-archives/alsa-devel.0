From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/5] ALSA: snd-usb: switch over to new
 endpoint streaming logic
Date: Fri, 18 Nov 2011 15:41:56 +0100
Message-ID: <4EC66EB4.8020906@gmail.com>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<1320063030-3502-3-git-send-email-zonque@gmail.com>
	<4EB05D3A.60405@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 597C2103A4D
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 15:42:04 +0100 (CET)
Received: by bkat8 with SMTP id t8so3463893bka.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 06:42:04 -0800 (PST)
In-Reply-To: <4EB05D3A.60405@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

Hi Clemens and Takashi,

I'm back on working on (and hopefully finishing) this series now. One
question that remains is ...

On 11/01/2011 09:57 PM, Clemens Ladisch wrote:
> On 10/31/2011 01:10 PM, Daniel Mack wrote:
>> @@ -276,6 +312,15 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
>>  	if (((is_playback && attr == USB_ENDPOINT_SYNC_ASYNC) ||
>>  	     (! is_playback && attr == USB_ENDPOINT_SYNC_ADAPTIVE)) &&
>>  	    altsd->bNumEndpoints >= 2) {
>> +		switch (subs->stream->chip->usb_id) {
>> +		case USB_ID(0x0763, 0x2080): /* M-Audio FastTrack Ultra */
>> +		case USB_ID(0x0763, 0x2081):
>> +			ep = 0x81;
>> +			iface = usb_ifnum_to_if(dev, 2);
>> +			alts = &iface->altsetting[1];
> 
> Better check that the device actually has these descriptors.
> 
>> +int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream, int cmd)
>> +{
>> +	case SNDRV_PCM_TRIGGER_START:
>> +		err = start_endpoints(subs);
> 
> The trigger callback should execute very quickly; the initial URB
> submission should be handled in the prepare callback.

This is actually the way the current implementation does it as well. And
there seems to be a reason why the inital submission of urbs is done
differently for the two directions. In the prepare callback, there's
also a comment that says

        /* for playback, submit the URBs now; otherwise, the first
hwptr_done
         * updates for all URBs would happen at the same time when
starting */
        if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK) {
                subs->ops.prepare = prepare_nodata_playback_urb;
                return start_urbs(subs, runtime);
        }

I'm not sure whether my patch set should touch this implementation
detail for now.


Daniel
