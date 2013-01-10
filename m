From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 044/112] ALSA: hda - More generic auto-mic
 switching for Realtek codecs
Date: Thu, 10 Jan 2013 08:41:13 +0800
Message-ID: <CAN8ccibLinueHznUv47s3xkF2boDNxB0VRJ1vdEz6KGqvgFf4A@mail.gmail.com>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
 <1357645185-7645-45-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 4534D260325
 for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2013 01:41:15 +0100 (CET)
Received: by mail-vc0-f179.google.com with SMTP id p1so2158966vcq.24
 for <alsa-devel@alsa-project.org>; Wed, 09 Jan 2013 16:41:14 -0800 (PST)
In-Reply-To: <1357645185-7645-45-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, lgperson@126.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> This patch extends the capability of the auto-mic feature.
> Instead of limiting the automatic input-source selection only to the
> mics (internal, external and dock mics), allow it for generic inputs,
> e.g. switching between the rear line-in and the front mic.
>
> The logic is to check the attribute and location of input pins, and
> enable the automatic selection feature only if all such pins are in
> different locations (e.g. internal, front, rear, etc) and line-in or
> mic pins.  That is, if multiple input pins are assigned to a single
> location, the feature isn't enabled because we don't know the
> priority.
>
> (You may wonder why this restriction doesn't exist for the headphone
>  automute.  The reason is that the output case is different from the
>  input: the input source is an exclusive selection while the output
>  can be multiplexed.)
>
> Note that, for avoiding regressions, the line-in auto switching
> feature isn't activated as default.  It has to be set explicitly via
> spec->line_in_auto_switch flag in a fixup code.

Is this feature automatically disabled when rear Mic or line in Jack is
retasked as output ?

Does it mean that multi channel capture will not be implemented since it is
conflict with both dynamic adc  switching and auto Mic selection ?
