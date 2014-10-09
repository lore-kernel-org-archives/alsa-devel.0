From: Daniel Mack <daniel@zonque.org>
Subject: Re: [WIP PATCH] Scarlett mixer interface for 6i6, 18i6,
 18i8 and 18i20.
Date: Thu, 09 Oct 2014 10:31:15 +0200
Message-ID: <543647D3.9070004@zonque.org>
References: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>
 <54358AA6.7040205@zonque.org> <5435BF95.2040909@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id C8197260539
 for <alsa-devel@alsa-project.org>; Thu,  9 Oct 2014 10:31:17 +0200 (CEST)
In-Reply-To: <5435BF95.2040909@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tobias Hoffmann <smilingthax@googlemail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, robin@gareus.org, clemens@ladisch.de, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Tobias,

On 10/09/2014 12:49 AM, Tobias Hoffmann wrote:
> And some more comments from me:
> 
> On 08/10/14 21:04, Daniel Mack wrote:
>> +
>> +/* #define WITH_METER */
>> +/* #define WITH_LOGSCALEMETER */
>> These should either be converted to module parameters, or removed
>> alltogether. Why are they configurable, anyway?
> 
> As I've said in my earlier mail, code is current not working: Metering 
> should be removed from this patch (or rewritten to use hwdep-API).
> 
>>> +#define LEVEL_BIAS 128  /* some gui mixers can't handle negative ctl values (alsamixergui, qasmixer, ...) */
>>> +
>>> +#ifndef LEVEL_BIAS
>>> +	#define LEVEL_BIAS 0
>>> +#endif
>> Same here.
> As LEVEL_BIAS = 0 definitely causes problems with some mixer GUIs, the 
> #ifndef ... #endif should be removed completely.

Alright. David, will you be working on new version of the patch?

>>> +#if 0 /* rg debug XXX */
>>> +	snd_printk(KERN_ERR "req ctl value: req = %#x, rtype = %#x, wValue = %#x, wIndex = %#x, size = %d\n",
>>> +		   bRequest, (USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN), wValue, idx, size);
>>> +#endif
>> That can be moved to snd_printdd()
> 
> These are left overs from Robins code, even I didn't need them. It's 
> probably safe to just remove all the
>    #if 0 /* rg debug XXX */  ... #endif
> from the patch.

Sure it's safe, as dead code doesn't do anything :) The question is
whether the line produces any useful information for people having
trouble with their device. If so, we can just convert it to snd_printdd().

>>> +static int scarlett_ctl_save_put(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
>>> +{
>>> +	struct scarlett_mixer_elem_info *elem = kctl->private_data;
>>> +	int err;
>>> +
>>> +	if (ucontrol->value.enumerated.item[0]>  0) {
>>> +		char buf[1] = { 0xa5 };
>>> +
>>> +		err = set_ctl_urb2(elem->mixer->chip, UAC2_CS_MEM, 0x005a, 0x3c, buf, 1);
>>> +		if (err<  0)
>>> +			return err;
>>> +
>>> +		snd_printk(KERN_INFO "Scarlett: Saved settings to hardware.\n");

Btw - this should become a debug print as well.

>>> +	}
>>> +
>>> +	return 0; /* (?) */
>> What's the confusion here? :)
> 
	> The "Save to HW" enum uses a special kcontrol .get/.put combo:
> .get always returns 0, and .put issues a special command to the hardware.
> 
> I not 100% sure what the "best" return value of the .put function would 
> be in that case.
> AFAIUI, .put functions have to return whether the value has changed... 
> and here:
>   - something happend (supporting return 1;)
>   - but .get still returns 0 (supporting return 0;)

Ah, I see. Yes, I'd consider that a misuse of the ALSA control API, as
you're not dealing with an actual control here. I think that should
become a hwdep interface then.

> But I found this...:
>> +static struct snd_kcontrol_new usb_scarlett_ctl_save = {
>> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>> +	.name = "",
>> +	.info = scarlett_ctl_enum_info,
>> +	.get =  scarlett_ctl_save_get,
>> +	.get =  scarlett_ctl_save_put,
>> +};
> 
> BUG! .get is set twice instead of .get and .put...

Right, so the code in .put was never actually used, right? Did the
compiler not warn about that?

> Testing is definitely needed for that change.
> 
>>> +/*  untested...  */
>>> +static const struct scarlett_device_info s6i6_info = {
>> Would be nice to get some testers here.
> 
> I did heard of one person who used it (successfully) on s6i6.
> That's not to say that we should not test the "final" patch on each device.

Yes, that would be good.

>> Here, and in some other occasions, ARRAY_SIZE() should be used.
>>
>>> +	.opt_matrix = {
>>> +		.start = -1,
>>> +		.len = 27,
>>> +		.texts = s18i8_texts
>>> +	},
>> Same here.
> 
> ARRAY_SIZE(s18i8_text) == 35, so  .len = (ARRAY_SIZE()-8) ?
> I not sure that's helpful...
> The better way to think about it is:
>    .opt_matrix.len = .mix_start + 1,
>    .opt_master.len = .opt_matrix.len + .matrix_out    // == ARRAY_SIZE()

Hmm, yes. I was just thinking about something that makes the values look
a bit less magical.


Daniel
