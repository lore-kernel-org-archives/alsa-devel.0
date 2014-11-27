From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: ALSA/ASOC new device and routing
Date: Thu, 27 Nov 2014 13:11:54 +0000
Message-ID: <1417093914.15317.47.camel@loki>
References: <E0C3DF2A36210C42B1AB4626A0E10F1FD948C13C@aclmbx01.corp.audiocodes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A162265DF6
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 14:12:03 +0100 (CET)
In-Reply-To: <E0C3DF2A36210C42B1AB4626A0E10F1FD948C13C@aclmbx01.corp.audiocodes.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eli Britstein <Eli.Britstein@audiocodes.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Reflowed the message.

On Thu, 2014-11-27 at 09:21 +0000, Eli Britstein wrote:
> Hi
> 
> I'm a newbie to ALSA.
> I'm targeting to use ALSA or ASoC solution in order to route
> capture/playback streams of a USB headset (that uses ALSA) to/from my
> own DSP device.
> I saw DPCM which is a part of ASoC manages dynamically connections
> between FE and BE streams.
> In my product, I just need them to be connected. No need for the
> "dynamically" part.
> 
Ok, so you have standard static routing from source to sink. ? or does
your DSP allow routing from PCM 0 to HW port 0 .. N ?

Best to also describe your HW in more detail so that people on the list
can provide better answers. 

> My questions:
> 1. Can someone please recommend a step by step guide, or an example
> how to make my DSP "look like" a BE? Do I need to write an ALSA driver
> for it or a ASOC driver?

If the routing is static then there is no need to create FE and BE DAI
links for your DSP. Just create standard PCM and DAI link. Otherwise
have a look at existing DPCM based drivers like Intel Haswell/Broadwell
and OMAP4.

> 2. After I have it as a BE, how can I connect the streams? I want the
> transfers to be done in kernel level, without need for application
> interventions for each buffer.

The connection depends on your DSP routing topology. Again look at the
existing examples. I think you are also asking about DMA here ? if so,
the kernel takes care of DMA configuration, however your application
will probably still have to perform IO on your audio buffers.

> 3. I'm using kernel 2.6.10 (quite old, I know). I don't want to port
> my entire kernel to a new one. As my requirement is not very complex,
> I don't think I'd encounter too many issues. However, if someone can
> point the important parts I need to back port, I'd appreciate it.
> Alternatively, if someone sees a showstopper in this approach, I'd be
> grateful to be aware of it.
> 
2.6.10 is really ancient and there have been many improvements since. I
would strongly recommend upgrading to the latest release. 

Liam
> 
> Thanks,
> Best regards,
> 
> Eli
> 
