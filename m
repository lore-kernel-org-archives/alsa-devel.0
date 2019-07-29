From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [BUG] bdw-rt5650 DSP boot timeout
Date: Mon, 29 Jul 2019 18:02:45 -0500
Message-ID: <39533fe5-c060-7a07-c910-74b83eee53c4@linux.intel.com>
References: <CACJJ=pxPm7dRUE534hDWy2tN3dGYDyrgU8JKqett=wOQx+nWCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DDBB4F803D5
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 01:02:49 +0200 (CEST)
In-Reply-To: <CACJJ=pxPm7dRUE534hDWy2tN3dGYDyrgU8JKqett=wOQx+nWCQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jon Flatley <jflat@chromium.org>, alsa-devel@alsa-project.org
Cc: benzh@chromium.org
List-Id: alsa-devel@alsa-project.org



On 7/29/19 4:53 PM, Jon Flatley wrote:
> I've been working on upstreaming the bdw-rt5650 machine driver for the
> Acer Chromebase 24 (buddy). There seems to be an issue when first
> setting the hardware controls that appears to be crashing the DSP:
> 
> [   51.424554] haswell-pcm-audio haswell-pcm-audio: FW loaded, mailbox
> readback FW info: type 01, - version: 00.00, build 77, source commit
> id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
> ...
> [   84.924666] haswell-pcm-audio haswell-pcm-audio: error: audio DSP
> boot timeout IPCD 0x0 IPCX 0x0
> [   85.260655] haswell-pcm-audio haswell-pcm-audio: ipc: --message
> timeout-- ipcx 0x83000000 isr 0x00000000 ipcd 0x00000000 imrx
> 0x7fff0000
> [   85.273609] haswell-pcm-audio haswell-pcm-audio: error: stream commit failed
> [   85.279746]  System PCM: error: failed to commit stream -110
> [   85.285388] haswell-pcm-audio haswell-pcm-audio: ASoC:
> haswell-pcm-audio hw params failed: -110
> [   85.293963]  System PCM: ASoC: hw_params FE failed -110
> 
> This happens roughly 50% of the time when first setting hardware
> controls after a reboot. The other 50% of the time the DSP comes up
> just fine and audio works fine thereafter. Adding "#define DEBUG 1" to
> sound/soc/intel/haswell/sst-haswell-ipc.c makes the issue occur much
> less frequently in my testing. Seems like a subtle timing issue.
> 
> There were timing issues encountered during the bringup of the 2015
> chromebook pixel (samus) which uses the bdw-rt5677 machine driver.
> Those were slightly different, and manifested during repeated
> arecords. Both devices use the same revision of the sst2 firmware.
> 
> Any ideas for how to debug this?

this could be trying to send an IPC while you are already waiting for 
one to complete. we've seen this before with SOF, if the IPCs are not 
strictly serialized then things go in the weeds and timeout.
