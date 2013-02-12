From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Add M2Tech hiFace USB-SPDIF driver
Date: Tue, 12 Feb 2013 15:29:19 +0100
Message-ID: <511A51BF.6000602@ladisch.de>
References: <1360537887-9427-1-git-send-email-ao2@amarulasolutions.com>
 <5118B186.1020801@ladisch.de>
 <20130212133521.39628e4aef556560b8b14dd8@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id D1788265111
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2013 15:29:26 +0100 (CET)
In-Reply-To: <20130212133521.39628e4aef556560b8b14dd8@studenti.unina.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Antonio Ospite <ao2@amarulasolutions.com>, fchecconi@gmail.com, Pietro Cipriano <p.cipriano@m2tech.biz>, alberto@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

Antonio Ospite wrote:
> Clemens Ladisch <clemens@ladisch.de> wrote:
>> Antonio Ospite wrote:
>>> I also noticed that many drivers under sound/usb/ have text in the Kconfig
>>> entry stating "Say Y here to include support for ..." but I only see "[N/m/?]"
>>> as options when I run "make oldconfig" maybe because of some dependency, I am
>>> not sure, should such text be removed in order to avoid confusion?
>>
>> It allows only "m" for "module" because some dependencies already
>> are modules.
>
> Right, but should the sentence about "Say Y..." be removed here and in
> the other drivers?

If you want to, replace it with "Select this ...".

>>> +MODULE_SUPPORTED_DEVICE("{{HiFace, Evo}}");
>>
>> MODULE_SUPPORTED_DEVICE isn't actually used at the moment, but if you
>> use it, you should include all supported devices.  Or is this a name
>> for the entire family?
>>
>> (But I guess the name is "Evo", not " Evo".)
>
> OK, I'll list all supported devices following the format used in
> sound/usb/caiaq/device.c, which AFAICS is "{Manufacturer, Device Name}"
> for each entry, that is still with a leading space before the device
> name, or is that wrong in your opinion?

Most driver take care to have no spaces.

>>> +	if (quirk && quirk->device_name)
>>> +		strcpy(card->shortname, quirk->device_name);
>>> +	else
>>> +		strcpy(card->shortname, "M2Tech generic audio");
>>
>> Don't the devices have their name in the device descriptor?
>
> It looks like the iProduct field is not reliable enough, different
> devices could have the same value there.

The iProduct field is the number of the string descriptor.
That string might be useful at least in the non-quirk case
(which shouldn't happen in the first case AFAICS).

>>> +	ret = usb_control_msg(device, usb_sndctrlpipe(device, 0),
>>> +				0xb0,
>>> +				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
>>> +				rate_value[rt->rate], 0, NULL, 0, 100);
>>
>> You must not do DMA from either the stack or from static module data, so
>> you have to copy this byte into kmalloc'ed memory (like snd_usb_ctl_msg()
>> does).
>
> Well, your remark is valid for when the "void *data" argument of
> usb_control_msg() is used, but I am just using the "value" argument here
> which is a single u16 value, not a buffer address. So I think I can
> leave this part as is, can't I?

Yes; sorry.

>>> +static int hiface_pcm_playback(struct pcm_substream *sub,
>>> +		struct pcm_urb *urb)
>>> +{
>>> +	/* XXX Can an invalid format make it to here?
>>
>> No.
>
> So I can remove the check, thanks, or would it be OK to make it a
> WARN_ON or a BUG_ON?

BUG_ON would blow up the kernel, and is appropriate when you
cannot continue at all.  Use at most a WARN_ON, but it would be
perfectly reasonable to not check at all.

>>> +static void hiface_pcm_out_urb_handler(struct urb *usb_urb)
>>> +{
>>> +	if (usb_urb->status || rt->panic || rt->stream_state == STREAM_STOPPING)
>>> +		return;
>>
>> In some error cases, you might consider stopping the stream.
>
> You mean I should check explicitly for some values of usb_urb->status
> and stop the stream if they happen? Like you do in
> sound/usb/misc/ua101.c::capture_urb_complete()?

If only one URB doesn't get delivered for whatever reason, how should
the driver react?  If you just exit from the completion handler, the
driver will continue to fill and queue all the other URBs.
And what happens when the device is unplugged?

>>> +		ret = hiface_pcm_playback(sub, out_urb);
>>> +		if (ret < 0) {
>>> +			spin_unlock_irqrestore(&sub->lock, flags);
>>> +			goto out_fail;
>>> +		}
>>> +...
>>> +out_fail:
>>> +	usb_submit_urb(&out_urb->instance, GFP_ATOMIC);
>>
>> Same here.
>
> If I remove the check for format in hiface_pcm_playback() then this
> label would go away too and this won't be an error path anymore, but
> maybe you meant that I need to check the return value of usb_submit_urb
> () and stop the stream when the latter fails?

At the moment, you are trying to queue a URB with invalid samples.

>>> +			snd_pcm_stop(rt->playback.instance,
>>> +					SNDRV_PCM_STATE_XRUN);
>>
>> This requres locking the stream with something like
>> snd_pcm_stream_lock_irq().
>
> OK, but would you mind elaborating a little more why this is needed?
>
> I do not see other drivers doing that,

sound/firewire/{amdtp,isight}.c do.  I've never said that all those
other drivers would be correct.  (And you have to be careful to avoid
deadlocks.)

> and BTW I see also that some other drivers not calling snd_pcm_stop()
> at all, e.g. it is commented in sound/usb/endpoint.c::snd_complete_urb().

It's commented because it would crash.  That driver isn't in a very
good state regarding state changes.


Regards,
Clemens
