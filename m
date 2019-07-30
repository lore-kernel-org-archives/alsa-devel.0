From: Jon Flatley <jflat@chromium.org>
Subject: Re: [BUG] bdw-rt5650 DSP boot timeout
Date: Tue, 30 Jul 2019 10:45:21 -0700
Message-ID: <CACJJ=pyb==xWqKMB-gAzW7-FCFgEU7Rm+b-CL-ANO-eorDKy=A@mail.gmail.com>
References: <CACJJ=pxPm7dRUE534hDWy2tN3dGYDyrgU8JKqett=wOQx+nWCQ@mail.gmail.com>
 <39533fe5-c060-7a07-c910-74b83eee53c4@linux.intel.com>
 <ac7bcb42e40ac12d9924fd65c3e2c68b9b11b093.camel@linux.intel.com>
 <37ede7ea-e760-eac9-a1d5-0eb8e3bff3cb@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FB3BF80214
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 19:45:35 +0200 (CEST)
Received: by mail-lj1-x242.google.com with SMTP id t28so62898012lje.9
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 10:45:35 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com.
 [209.85.208.178])
 by smtp.gmail.com with ESMTPSA id m17sm11219546lfj.22.2019.07.30.10.45.33
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 10:45:33 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id t28so62897903lje.9
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 10:45:33 -0700 (PDT)
In-Reply-To: <37ede7ea-e760-eac9-a1d5-0eb8e3bff3cb@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: benzh@chromium.org, alsa-devel@alsa-project.org, Jon Flatley <jflat@chromium.org>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 29, 2019 at 7:23 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 7/29/19 7:53 PM, Ranjani Sridharan wrote:
> > On Mon, 2019-07-29 at 18:02 -0500, Pierre-Louis Bossart wrote:
> >>
> >> On 7/29/19 4:53 PM, Jon Flatley wrote:
> >>> I've been working on upstreaming the bdw-rt5650 machine driver for
> >>> the
> >>> Acer Chromebase 24 (buddy). There seems to be an issue when first
> >>> setting the hardware controls that appears to be crashing the DSP:
> >>>
> >>> [   51.424554] haswell-pcm-audio haswell-pcm-audio: FW loaded,
> >>> mailbox
> >>> readback FW info: type 01, - version: 00.00, build 77, source
> >>> commit
> >>> id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
> >>> ...
> >>> [   84.924666] haswell-pcm-audio haswell-pcm-audio: error: audio
> >>> DSP
> >>> boot timeout IPCD 0x0 IPCX 0x0
> >>> [   85.260655] haswell-pcm-audio haswell-pcm-audio: ipc: --message
> >>> timeout-- ipcx 0x83000000 isr 0x00000000 ipcd 0x00000000 imrx
> >>> 0x7fff0000
> >>> [   85.273609] haswell-pcm-audio haswell-pcm-audio: error: stream
> >>> commit failed
> >>> [   85.279746]  System PCM: error: failed to commit stream -110
> >>> [   85.285388] haswell-pcm-audio haswell-pcm-audio: ASoC:
> >>> haswell-pcm-audio hw params failed: -110
> >>> [   85.293963]  System PCM: ASoC: hw_params FE failed -110
> >>>
> >>> This happens roughly 50% of the time when first setting hardware
> >>> controls after a reboot. The other 50% of the time the DSP comes up
> >>> just fine and audio works fine thereafter. Adding "#define DEBUG 1"
> >>> to
> >>> sound/soc/intel/haswell/sst-haswell-ipc.c makes the issue occur
> >>> much
> >>> less frequently in my testing. Seems like a subtle timing issue.
> >>>
> >>> There were timing issues encountered during the bringup of the 2015
> >>> chromebook pixel (samus) which uses the bdw-rt5677 machine driver.
> >>> Those were slightly different, and manifested during repeated
> >>> arecords. Both devices use the same revision of the sst2 firmware.
> >>>
> >>> Any ideas for how to debug this?
> >>
> >> this could be trying to send an IPC while you are already waiting
> >> for
> >> one to complete. we've seen this before with SOF, if the IPCs are
> >> not
> >> strictly serialized then things go in the weeds and timeout.
> > Pierre/Jon
> >
> > In this case it looks like the DSP boot failed leading to the IPC
> > timeout? WOndering if increasing the boot timeout would help?

I did actually try this without success.

>
> Yes, that too. The boot timeout is typically experimentally defined, and
> never decreasing due to platform variations...
> I am still leaning more on the side of an side effect between two IPCs,
> the added DEBUG points to the printk which solves timing issues. The
> boot timeout would typically not be impacted by such changes.

I think the real struggle I'm having is finding a good debugging
method that doesn't impact the timing of the IPCs significantly (as
adding DEBUG seems to). This could maybe be overcome with using a
stress test to reproduce. The crash only seems to occur when first
booting the DSP, and so far I've been testing this by completely power
cycling the machine on every test, which is very slow and tedious. So
maybe the issue with DEBUG defined occurs 1 in 20 reboots rather than
1 in 2, I wouldn't know. If there's a way to reboot the DSP and
reproduce this crash without rebooting the entire device that would be
very helpful to me.

Thanks,
Jon
