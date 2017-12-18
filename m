From: Mauro Santos <registo.mailling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Mixer regression with usb soundcard
Date: Mon, 18 Dec 2017 15:30:13 +0000
Message-ID: <bd3f1487-d703-77b4-aca3-c6e15f0e18a8@gmail.com>
References: <0f95a1cc-c438-ca4e-cc5f-d311e33a496e@gmail.com>
 <20171218134444.GA18133@kroah.com> <s5hy3m0dtw0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hy3m0dtw0.wl-tiwai-l3A5Bk7waGM@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 18-12-2017 13:53, Takashi Iwai wrote:
> On Mon, 18 Dec 2017 14:44:44 +0100,
> Greg KH wrote:
>>
>> On Sun, Dec 17, 2017 at 06:56:05PM +0000, Mauro Santos wrote:
>>> I believe this is the right place to report this problem, but if it
>>> isn't please point me in the right direction.
>>
>> Adding the developer of that patch, and the sound maintainer and
>> developers to the thread.
>>
>>> I have noticed that after the update from kernel 4.14.5 to 4.14.6
>>> alsamixer does not show the usual volume controls for my usb soundcard.
>>>
>>> Reverting 3884d12e17ab770aa0f5d4bc65bfbfd006f417fa ALSA: usb-audio: Add
>>> check return value for usb_string() (from linux-stable) makes the
>>> controls come back again with kernel 4.14.6.
> (snip)
>>
>> This is odd, Takashi, I thought we fixed up the problem that if the
>> string was invalid, the code would continue to go on, it's not a "real"
>> error.  Did that not get marked for the stable trees?
> 
> Yes, it was marked as stable, and it's odd that the revert of the
> given commit changes the behavior in that way.
> 
> Mauro, could you double-check whether reverting the commit really does
> fix it as expected?  If yes, could you put some debug print at the
> part the patch touches, and check which unit id gives len=0 from
> snd_usb_copy_string_desc()?

I'm sure reverting that patch makes things work as expected. I noticed
the problem after an update and that is the only thing I revert on top
of the kernel provided by the distro (Arch Linux).

Alsamixer works fine for the built in soundcard in my laptop, but the
mixer for the usb soundcard was not working so it's specific to usb and
only 2 patches touch the mixer.c file between 4.14.5 and 4.14.6. I've
tried reversing both, one at a time, and only reverting this one
restored the expected behavior.

Regarding adding the debug print I'm going to need guidance. Without
reverting anything, would adding at line 2178 of sound/usb/mixer.c the
following be enough?

printk("usbmixdbg: nameid=%d len=%d id.name=%s\n",nameid,len,kctl->id.name);

It would then look like this (minus the line wrapping):
len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
printk("usbmixdbg: nameid=%d len=%d id.name=%s\n",nameid,len,kctl->id.name);
if (len)

-- 
Mauro Santos
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
