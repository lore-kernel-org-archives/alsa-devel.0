From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC PATCH 1/2] ALSA: hda - Fix "PCM" name being
 used on one DAC when there are two DACs
Date: Sat, 18 Oct 2014 20:33:49 +0800
Message-ID: <CAN8cciaUo7BOxSMBtiysYi9MsW=ZAWn0s3tHTc5-YmpWWvEJNg@mail.gmail.com>
References: <1413466426-2672-1-git-send-email-david.henningsson@canonical.com>
 <CAN8cciZAteQAaG9GAxwLWyF6u5xH_fGtRDOTq5j+4LNoj_d_jA@mail.gmail.com>
 <543FDFDE.7040800@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com
 [209.85.216.170])
 by alsa0.perex.cz (Postfix) with ESMTP id E48862604D9
 for <alsa-devel@alsa-project.org>; Sat, 18 Oct 2014 14:33:49 +0200 (CEST)
Received: by mail-qc0-f170.google.com with SMTP id m20so1833072qcx.1
 for <alsa-devel@alsa-project.org>; Sat, 18 Oct 2014 05:33:49 -0700 (PDT)
In-Reply-To: <543FDFDE.7040800@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, ruedi@battle-eggs.de
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> >
>> > In the scenario where there is one "Line Out", one "Speaker" and one
>> > "Headphone", and there are only two DACs, two outputs will share a DAC.
>> > Currently any mixer on such a DAC will get the "PCM" name, which is
>> > misleading. Instead use "Headphone+LO" or "Speaker+LO" to better
>> > specify what the volume actually controls.
>>
>> Are there any examples ?
>>
>
> I used "hda-emu
codecs/canonical/alc3226-dell-precision-m2800-ccert-201404-14986 -i 1" when
developing the patches.
>
> I don't have any hardware available myself that exposes this behavior,
but I can maybe fake one with hdajackretask, if that counts...
>

How about adding these names to slaves of virtual master volume/switch ?

hdajackretask won't help if the topology of the codecs are  different

Seem the badness still prevent the driver to support surround 5.1 with
three rear panel jacks, internal speaker and front panel headphone for
Thinkcenter A58 using alc662

https://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg29203.html

Why 3stack desktops with 6 channels codecs not using  "Headphone+LO"  or
"Speaker+LO" ?
