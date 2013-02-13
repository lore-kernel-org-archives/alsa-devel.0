From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HD-audio generic parser merged to linux-next
Date: Wed, 13 Feb 2013 20:16:10 +0800
Message-ID: <CAN8ccibp=JZLQs4vT0gr3iq-Qx_kFLGx_QfHFGpF+aXzV5uZ6Q@mail.gmail.com>
References: <s5hbocg1etr.wl%tiwai@suse.de>
 <CAN8ccia4vHek6n5xZi26nNZV0wmzv3H6cBjP4q+UTi3ubyTHSw@mail.gmail.com>
 <s5hpq07orhe.wl%tiwai@suse.de>
 <CAN8cciZEWHHKLAq-tqpA7G5GiH-tCX9bgbGdEdzsUAu=jkhrpg@mail.gmail.com>
 <s5hhaliq3rm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f176.google.com (mail-ia0-f176.google.com
 [209.85.210.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CE9E2651AF
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2013 13:16:11 +0100 (CET)
Received: by mail-ia0-f176.google.com with SMTP id i18so1117347iac.35
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2013 04:16:10 -0800 (PST)
In-Reply-To: <s5hhaliq3rm.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>
>> 6 DAC channels for 5.1 surround
>
> It's an issue with the output path selection, and basically irrelevant
> with the HP independent output.
>
>> Can independent headphone enabled by default since this mean that lost of
>> surround 5.1 for those desktop with three audio jacks at rear panel ?
>
> Not really.  The independent HP feature is just an additional stuff
> that is enabled only when the configuration is available in the
> selected paths.  It doesn't influence on the path selection by
> itself.
>

The driver create "alt analog" device but does not create "Channel
mode" or Surround, Center Lfe playback volume controls for intel
motherboard with 3 audio jacks for those 6 channels hda codecs (e.g.
alc662, ad1882, ...)

hda-emu codecs/alc662-intel-d945gclf2
