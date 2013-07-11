From: Tormen <my.nl.abos@gmail.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Thu, 11 Jul 2013 13:55:04 +0200
Message-ID: <51DE9D18.6010304@gmail.com>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
 <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
 <51D9F543.2070605@gmail.com>
 <c2cbc2323ce3a8e0df5f52de3ecb276c@www.happyassassin.net>
 <s5hvc4luem4.wl%tiwai@suse.de>
 <46b0590bfa4ffc836dde180f8ffe3c97@www.happyassassin.net>
 <s5hwqoycu0y.wl%tiwai@suse.de> <51DDD53A.8040502@gmail.com>
 <s5hbo69vf4z.wl%tiwai@suse.de> <51DE7B63.7060708@gmail.com>
 <s5hfvvlcs4o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id D26C7265041
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 13:55:07 +0200 (CEST)
Received: by mail-wg0-f44.google.com with SMTP id m15so6915137wgh.23
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 04:55:07 -0700 (PDT)
In-Reply-To: <s5hfvvlcs4o.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Adam Williamson <awilliam@redhat.com>
List-Id: alsa-devel@alsa-project.org

On 11/07/13 12:23, Takashi Iwai wrote:
> At Thu, 11 Jul 2013 11:31:15 +0200,
> Tormen wrote:
>> /// Small question:
>> What is the use of Digital and Capture seeming to do the same thing ?
> The "Digital" mixer element is implemented in alsa-lib softvol plugin,
> i.e. it's a software input gain control.  OTOH, "Capture" volume is
> the hardware control.  The former is present in the case where no
> proper gain control is available on hardware (and without using
> PulseAudio).
Thanks !

>> /// Rename:
> The common case for "Headphone Mic" is a headphone jack that can be
> *switched* as a mic jack.  So, "Headphone Mic" isn't appropriate in
> this case.  The use case is rather similar as "Headset Mic", where
> both input and output are done through a single jack.
Yes, makes sense.

>
>> /// Patch:
> You must have broken the patch at saving from your mailer.
> Most likely invalid space/tab conversions.  Better to fix your
> setup...
>
> I put the patch as an attachment below.  Give it a try again.
Damn it, you're right. My sincere appologies.
As the Documentation got fixed nicely I assumed my patch is good.
But of course a c file is more sensitive to tab/spaces!

Now it applied like charme on the debian 3.9.6 kernel source :

/mnt/tmp/src/linux-3.9.6 % cat 
/tmp/0001-ALSA-hda-Add-no_multi_io-hda_gen_spec-flag.patch|patch -p1
patching file Documentation/sound/alsa/HD-Audio.txt
patching file sound/pci/hda/hda_generic.c
Hunk #1 succeeded at 138 (offset -4 lines).
Hunk #2 succeeded at 1501 (offset -43 lines).
Hunk #3 succeeded at 1515 with fuzz 2 (offset -43 lines).
Hunk #4 succeeded at 1543 (offset -43 lines).
Hunk #5 succeeded at 1562 (offset -43 lines).
patching file sound/pci/hda/hda_generic.h
Hunk #1 succeeded at 202 with fuzz 2 (offset -18 lines).
patching file sound/pci/hda/patch_realtek.c
Hunk #1 succeeded at 1816 (offset -27 lines).

I am compiling now and I'll let you know!

Tormen
