From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v5] ALSA: usb: Work around CM6631 sample
 rate	change bug
Date: Wed, 03 Apr 2013 12:15:49 +0200
Message-ID: <515C0155.4090009@ladisch.de>
References: <20130326211004.GD18838@pvv.ntnu.no> <s5hr4is54jp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A7120265367
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 12:15:53 +0200 (CEST)
In-Reply-To: <s5hr4is54jp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Torstein Hegge <hegge@resisty.net>, alsa-devel@alsa-project.org, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Torstein Hegge wrote:
>> The C-Media CM6631 USB receiver doesn't respond to changes in sample rate
>> while the interface is active. The same behavior is observed in other UAC2
>> hardware like the VIA VT1731.
>>
>> Reset the interface after setting the sampling frequency on sample rate
>> changes, to ensure that the sample rate set by snd_usb_init_sample_rate() is
>> used. Otherwise, the device will try to use the sample rate of the previous
>> stream, causing distorted sound on sample rate changes.
>>
>> The reset is performed for all UAC2 devices, as it should not affect a
>> standards compliant device, but it is only necessary for C-Media CM6631,
>> VIA VT1731 and possibly others.
>>
>> Failure to read sample rate from the device is not handled as an error in
>> set_sample_rate_v2(), as (permanent or intermittent) failure to read sample
>> rate isn't essential for a successful sample rate set.
>>
>> Signed-off-by: Torstein Hegge <hegge@resisty.net>
>
> What about the latest status of the patch?
>
> If both Clemens and Daniel are happy with it, I can apply it for the
> next 3.9-rc.

Acked-by: Clemens Ladisch <clemens@ladisch.de>
with or without this change:

> Though, it would be nicer if two identical calls of snd_usb_ctl_msg
> can be put into a single function,


Regards,
Clemens
