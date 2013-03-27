From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v5] ALSA: usb: Work around CM6631 sample
 rate change bug
Date: Wed, 27 Mar 2013 12:52:14 +0100
Message-ID: <5152DD6E.6040707@gmail.com>
References: <20130326211004.GD18838@pvv.ntnu.no> <5152C53D.5060604@ladisch.de>
 <20130327114703.GE18838@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id C597F265162
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 12:52:10 +0100 (CET)
Received: by mail-we0-f173.google.com with SMTP id t57so2988046wey.32
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 04:52:10 -0700 (PDT)
In-Reply-To: <20130327114703.GE18838@pvv.ntnu.no>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 27.03.2013 12:47, Torstein Hegge wrote:
> On Wed, Mar 27, 2013 at 11:09:01 +0100, Clemens Ladisch wrote:
>> Torstein Hegge wrote:
>>> The C-Media CM6631 USB receiver doesn't respond to changes in sample rate
>>> while the interface is active. The same behavior is observed in other UAC2
>>> hardware like the VIA VT1731.
>>
>> Might it be possible that these devices have reset the interface (see
>> UAC2 section 3.16.3), and that the driver hasn't noticed this because it
>> doesn't handle Active Alternate Setting Control interrupts?
> 
> If that was the case, wouldn't the device be in altsetting zero after
> the sample rate set and not be able to output sound at all? And as long
> as the current altsetting supports the target sample rate as reported in
> /proc/asound/card1/stream0, Active Alternate Setting Control shouldn't
> have to be invoked.

You could just try and catch that currently unhandled interrupt. We
should support that anyway at some point ...


Daniel
