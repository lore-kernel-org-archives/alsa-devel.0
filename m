From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Fw: Isochronous transfer error on USB3
Date: Thu, 09 Jan 2014 13:10:08 +0100
Message-ID: <52CE91A0.1010901@ladisch.de>
References: <20140108164800.70ea4169@samsung.com>
 <52CE5B09.6070203@ladisch.de> <20140109092957.58092c3f@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 9D684265281
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 13:10:12 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0181021411
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 07:10:11 -0500 (EST)
In-Reply-To: <20140109092957.58092c3f@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, LMML <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Mauro Carvalho Chehab wrote:
> Clemens Ladisch <clemens@ladisch.de> escreveu:
>> Mauro Carvalho Chehab wrote:
>>> 	.period_bytes_min = 64,		/* 12544/2, */
>>
>> This is wrong (if the driver doesn't install other constraints on the
>> period length, like the USB audio class driver does).
>
> Ok, how should it be estimated?

This value specifies how fast the driver can report period interrupts,
i.e., how often it can call snd_pcm_period_elapsed().  In other words,
if the application configures the device for this minimum period size,
but if it is possible for this amount of bytes to be transferred
_without_ triggering an interrupt (by reaching the end of the URB), then
this value was too low.

The em28xx driver uses a fixed URB size, so actual interrupts happen
every 64 frames, so this value should be at least the number of bytes
that can be transferred in 64 ms (assuming a full-speed device).

Because you do not know the exact number of samples that will be sent
per frame, it is possible that the USB interrupt happens up to 63 ms
after the point where the period interrupt should actually have
happened.  This jitter could be reduced by using shorter URBs.

In any case, this driver does not need the integer constraint on the
period count.


Regards,
Clemens
