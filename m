From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: USB Audio initialization race
Date: Tue, 17 Sep 2013 00:21:27 +0200
Message-ID: <52378467.1040402@canonical.com>
References: <Pine.LNX.4.44L0.1309142127140.6622-100000@netrider.rowland.org>
 <523574A4.4010203@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C0CA9265043
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 00:21:29 +0200 (CEST)
In-Reply-To: <523574A4.4010203@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, Alan Stern <stern@rowland.harvard.edu>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On 09/15/2013 10:49 AM, Clemens Ladisch wrote:
> Alan Stern wrote:
>> On Sat, 14 Sep 2013, Clemens Ladisch wrote:
>>> Alan Stern wrote:
>>>> So here's my question: If the sound driver recognizes that interface B
>>>> is connected with interface A when B is probed, why can't it recognize
>>>> this fact when A is probed?  It could claim B while A's probe is
>>>> running.  Then the sound card would be registered with the PCM
>>>> component already in place.
>>>
>>> The sound driver already does this.
>>
>> It does?  Why does the comment preceding snd_usb_audio_probe() say:
>>
>>  * thus we check the usb device pointer and creates the card instance
>>  * only at the first time.  the successive calls of this function will
>>  * append the pcm interface to the corresponding card.
> 
> For UAC devices with correct descriptors, and for devices with multi-
> interface quirks, the driver claims all interfaces at once.  But it is
> still possible to have devices with zero or two audio control interfaces.

So, indeed there is some claiming being done in the usb audio driver, so
maybe this is not as much of a problem as I thought, but I think this
comment is wrong:

	/* we are allowed to call snd_card_register() many times */

...because it implies that it is okay to change the card and then call
snd_card_register again, and it is not, because userspace cannot handle
that correctly. It would be more appropriate to print a warning if this
happens.

Also, I wonder if it makes sense to also claim control interfaces
(USB_SUBCLASS_AUDIOCONTROL) in snd_usb_create_stream, in case the audio
streaming interface is probed before the control interface?

Anyway, I'm waiting for the (latest) bug reporter to return back to me
with "lsusb -v" and some more info, so I can verify if this could
actually be the problem or not.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
