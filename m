From: Tobias Hoffmann <smilingthax@googlemail.com>
Subject: Re: [WIP PATCH] Scarlett mixer interface for 6i6, 18i6,
 18i8 and 18i20.
Date: Thu, 09 Oct 2014 12:13:33 +0200
Message-ID: <54365FCD.3070207@googlemail.com>
References: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>
 <54358AA6.7040205@zonque.org> <5435BF95.2040909@googlemail.com>
 <543647D3.9070004@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id AB60A260557
 for <alsa-devel@alsa-project.org>; Thu,  9 Oct 2014 12:13:44 +0200 (CEST)
Received: by mail-la0-f45.google.com with SMTP id q1so848803lam.4
 for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2014 03:13:42 -0700 (PDT)
In-Reply-To: <543647D3.9070004@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, robin@gareus.org, clemens@ladisch.de, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 09/10/14 10:31, Daniel Mack wrote:
>
>>>> +#if 0 /* rg debug XXX */
>>>> +	snd_printk(KERN_ERR "req ctl value: req = %#x, rtype = %#x, wValue = %#x, wIndex = %#x, size = %d\n",
>>>> +		   bRequest, (USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN), wValue, idx, size);
>>>> +#endif
>>> That can be moved to snd_printdd()
>> These are left overs from Robins code, even I didn't need them. It's
>> probably safe to just remove all the
>>     #if 0 /* rg debug XXX */  ... #endif
>> from the patch.
> Sure it's safe, as dead code doesn't do anything :) The question is
> whether the line produces any useful information for people having
> trouble with their device. If so, we can just convert it to snd_printdd().

Well, yes. I was looking for a short word for "no one will miss it", 
when I wrote "safe"...


> 	>  The "Save to HW" enum uses a special kcontrol .get/.put combo:
>> .get always returns 0, and .put issues a special command to the hardware.
>>
>> I not 100% sure what the "best" return value of the .put function would
>> be in that case.
>> AFAIUI, .put functions have to return whether the value has changed...
>> and here:
>>    - something happend (supporting return 1;)
>>    - but .get still returns 0 (supporting return 0;)
> Ah, I see. Yes, I'd consider that a misuse of the ALSA control API, as
> you're not dealing with an actual control here. I think that should
> become a hwdep interface then.

I think I've seen the same idea ("abuse") in another driver(?).


>
>> But I found this...:
>>> +static struct snd_kcontrol_new usb_scarlett_ctl_save = {
>>> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>>> +	.name = "",
>>> +	.info = scarlett_ctl_enum_info,
>>> +	.get =  scarlett_ctl_save_get,
>>> +	.get =  scarlett_ctl_save_put,
>>> +};
>> BUG! .get is set twice instead of .get and .put...
> Right, so the code in .put was never actually used, right? Did the
> compiler not warn about that?

No, it does not warn...
I do have some memories of testing that code (i.e. the printk was 
called), and of experimenting with .get / .put for that particular 
control, esp. concerning  alsactl store/restore.

I will do a full compile / test cycle, when David has incorporated all 
the comments into a new patch.

> ARRAY_SIZE(s18i8_text) == 35, so  .len = (ARRAY_SIZE()-8) ?
> I not sure that's helpful...
> The better way to think about it is:
>     .opt_matrix.len = .mix_start + 1,
>     .opt_master.len = .opt_matrix.len + .matrix_out    // == ARRAY_SIZE()
> Hmm, yes. I was just thinking about something that makes the values look
> a bit less magical.

Maybe a comment at the first such definition helps.

   Tobias
