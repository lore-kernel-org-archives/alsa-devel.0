From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
Date: Fri, 30 Apr 2010 16:46:57 -0500
Message-ID: <t2ged82fe3e1004301446mfbe63ddele99ad22ae331dd57@mail.gmail.com>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<4BD6FA39.3030400@freescale.com> <1272381611.11000.39.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8733410391F
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 23:47:28 +0200 (CEST)
Received: by pxi13 with SMTP id 13so345957pxi.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Apr 2010 14:47:27 -0700 (PDT)
In-Reply-To: <1272381611.11000.39.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kumar.gala@freescale.com, broonie@opensource.wolfsonmicro.com, Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 27, 2010 at 10:20 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:

>> Another problem is that ASoC won't let me probe the DMA channels
>> independently. =A0That is, I cannot tell ASoC that I have a playback DMA
>> and a capture DMA. =A0ASoC does not recognize two DMA devices for a
>> single SSI. =A0If you can fix that, then I can turn the DMA driver into
>> an OF driver.
>>
>
> Iirc, the SSI and DMA controllers on your SoC mean that each DMA device
> can only do one direction (either Playback or Capture). So I'm thinking
> we create two DAI link entries for your sound card (one for playback and
> the other for capture) and they both use the same SSI device but each
> would have it's own DMA device.
>
> This would result in two separate pcm devices being exported to
> userspace i.e one for playback only and the other for capture only. I
> think this is also a more accurate representation of your hardware too
> (since we have different DMA devices for each pcm stream direction).

Ok, I'm trying to do this now, and I'm running into problems.

So here's the device list:

One machine
One SSI
Two DMA channels
One codec

So I create two dai_links in the machine driver.  Each dai_link has
two DAIs in it.  The DAIs are identical, except for the platform_drv
field.  The platform_drv in the first DAI points to the first DMA
channel, and the platform_drv of the second DAI points to the second
DMA channel.

When I boot Linux, I get this:

asoc: cs4270 <-> /soc@e0000000/ssi@16000 mapping ok
sysfs: cannot create duplicate filename '/devices/platform/soc-audio/cs4270'

so it looks like when asoc is processing the dai_link, it tries to
create a sysfs device for the codec twice.

How do I avoid this?

-- =

Timur Tabi
Linux kernel developer at Freescale
