From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC PATCH 1/2] ALSA: hda - Fix "PCM" name being
 used on one DAC when there are two DACs
Date: Mon, 20 Oct 2014 17:55:23 +0800
Message-ID: <CAN8cciYCSd8QqHNZ=7ip_-YnG1ru9jJ3rjW8S_YjyrhRLGBFzA@mail.gmail.com>
References: <1413466426-2672-1-git-send-email-david.henningsson@canonical.com>
 <CAN8cciZAteQAaG9GAxwLWyF6u5xH_fGtRDOTq5j+4LNoj_d_jA@mail.gmail.com>
 <543FDFDE.7040800@canonical.com>
 <CAN8cciaUo7BOxSMBtiysYi9MsW=ZAWn0s3tHTc5-YmpWWvEJNg@mail.gmail.com>
 <s5hlhodteq7.wl-tiwai@suse.de>
 <CAN8ccib4fhvvtYW7sjDZXA9QETgOTL+wA=u6iSv0yRHtwWPfwQ@mail.gmail.com>
 <5444ABDA.7070207@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
 [209.85.216.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 3086B2605F2
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 11:55:25 +0200 (CEST)
Received: by mail-qc0-f182.google.com with SMTP id i17so3364004qcy.13
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 02:55:24 -0700 (PDT)
In-Reply-To: <5444ABDA.7070207@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, ruedi@battle-eggs.de
List-Id: alsa-devel@alsa-project.org

>>
>>
>>  > >
>>  > > >> >
>>  > > >> > In the scenario where there is one "Line Out", one "Speaker"
>> and one
>>  > > >> > "Headphone", and there are only two DACs, two outputs will
>> share a DAC.
>>  > > >> > Currently any mixer on such a DAC will get the "PCM" name,
>> which is
>>  > > >> > misleading. Instead use "Headphone+LO" or "Speaker+LO" to
better
>>  > > >> > specify what the volume actually controls.
>>  > > >>
>>  > > >> Are there any examples ?
>>  > > >>
>>  > > >
>>  > > > I used "hda-emu
>>  > > codecs/canonical/alc3226-dell-precision-m2800-ccert-201404-14986 -i
>> 1" when
>>  > > developing the patches.
>>  > > >
>>  > > > I don't have any hardware available myself that exposes this
>> behavior,
>>  > > but I can maybe fake one with hdajackretask, if that counts...
>>  > > >
>>  > >
>>  > > How about adding these names to slaves of virtual master
>> volume/switch ?
>>  > >
>>  > > hdajackretask won't help if the topology of the codecs are
different
>>  > >
>>  > > Seem the badness still prevent the driver to support surround 5.1
with
>>  > > three rear panel jacks, internal speaker and front panel headphone
for
>>  > > Thinkcenter A58 using alc662
>>  > >
>>  > >
>>
https://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg29203.html
>>  > >
>>  > > Why 3stack desktops with 6 channels codecs not using
>> "Headphone+LO"  or
>>  > > "Speaker+LO" ?
>>  >
>>  > The problem is just the lack of DACs, so it cannot cover all three
>>  > outputs, no matter how the pins are chosen.  That is, it's no 6
>>  > channels at all but 4 channels at most.
>>  >
>>  >
>>
>> http://shop.lenovo.com/us/en/desktops/thinkcentre/a-series/a58/
>>
>> The technical specification of a58
>>
>> 2 pin internal speaker connector
>> Alc662 5.1
>>
>> https://bbs.archlinux.org/viewtopic.php?id=156433
>>
>> Seem windows support surround 5.1
>
>
> Raymond, there can certainly be cases which this patch does not cover -
after all, it's mostly a band aid given the lack of topology information -
but do you see cases where this patch actually causes a *regression*? If
so, could you point me to alsa-info for the machine where this patch causes
a regression?
>

www.realtek.com.tw/products/productsView.aspx?Langid=1&PNid=24&PFid=27&Level=5&Conn=4

I expect those desktop with 2+2 HD Audio codec support independent headphone

This mean the driver should not create "Lineout+HP" Playback volume

Line out and headphone cannot share same DAC
