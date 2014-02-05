From: Mario Kicherer <dev@kicherer.org>
Subject: Re: [PATCH] MIDI driver for Behringer BCD2000 USB
	device
Date: Wed, 05 Feb 2014 16:33:36 +0100
Message-ID: <52F259D0.9070705@kicherer.org>
References: <1391284482-7577-1-git-send-email-dev@kicherer.org>
 <52F2184D.9060209@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BBC9264FE3
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 16:33:38 +0100 (CET)
In-Reply-To: <52F2184D.9060209@zonque.org>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Daniel,

thank you very much for your comments! I hope I fixed most of the
points but I also have a few questions/comments:

On 05.02.2014 11:54, Daniel Mack wrote:
>> +#ifdef CONFIG_USB_DEBUG
>> +#define DEBUG	1
>> +#else
>> +#define DEBUG	0
>> +#endif
>
> Please use the define directly instead of introducing a new one.

I replaced it with:

#ifndef CONFIG_USB_DEBUG
#define CONFIG_USB_DEBUG 0
#endif

As it can be undefined. I hope that's okay.

> Your patch has a huge number of style issues, which
> scripts/checkpatch.pl will point you to. I got:

Interesting, I copied many issues from other modules. :)
If fixed most of them except these:

WARNING: quoted string split across lines
#310: FILE: sound/usb/bcd2000/bcd2000.c:254:
+                       "bcd2000_midi_send(%p): usb_submit_urb() failed"
+                       "ret=%d, len=%d\n", substream, ret, len);

WARNING: quoted string split across lines
#392: FILE: sound/usb/bcd2000/bcd2000.c:336:
+                               "bcd2000_init_device: usb_submit_urb() 
failed,"
+                               "ret=%d: ", ret);

I don't know how to avoid them, as all strings in one line would be
longer than 80 characters.

>> +		/* determine the number of bytes we want to copy this time */
>> +		tocopy = min( 3 - bcd2k->midi_cmd_offset, length - (buf_offset - 1));
>> +		
>> +		if (tocopy > 0) {
>
> tocopy is unsigned char, so this check is always true, and the copy
> routine can overflow in case bcd2k->midi_cmd_offset < 3.

I don't understand your point here. It could be zero. But I changed it
to a condition that checks if both offsets are within the length of the
two involved buffers.

> Please, no dead code. Remove those lines entirely if you don't need them.

Ah okay, I planned to reactive them with the audio part. But I removed
them for now.

As far as I understood, I should repost the new patch as [PATCH v2]. I
will check this evening if the device still works and send it to the
list afterwards.

Thank you!
Mario
