From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: ALSA/ASOC new device and routing
Date: Thu, 27 Nov 2014 19:06:08 +0000
Message-ID: <1417115168.15317.63.camel@loki>
References: <E0C3DF2A36210C42B1AB4626A0E10F1FD948C13C@aclmbx01.corp.audiocodes.com>
 <1417093914.15317.47.camel@loki>
 <E0C3DF2A36210C42B1AB4626A0E10F1FD948C7A9@aclmbx01.corp.audiocodes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 02C5C2614FD
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 20:06:42 +0100 (CET)
In-Reply-To: <E0C3DF2A36210C42B1AB4626A0E10F1FD948C7A9@aclmbx01.corp.audiocodes.com>
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

On Thu, 2014-11-27 at 13:56 +0000, Eli Britstein wrote:
> Hi
> 
> I'd like to clarify a bit. Also more details below.
> My system is IP phone, that has a DSP device (proprietary of
> Audiocodes).

Ok, but I meant what CPU and codec are you using ? You will see that a
lot of CPU platforms and codecs are already supported.

> Currently, I did things in user space.
> I read a buffer from ALSA (capture), and write it to the DSP.
> I read a buffer from the DSP, and write it to the ALSA.
> The problem is that when I establish a call, there are many things
> happening, so probably my user space threads don't run on time, so I
> get under runs and over runs, from which I couldn't recover.
> 
aplay and pulseaudio show good examples of how to use the alsa userspace
APIs. 

> I wanted to move to kernel to assure CPU for the ALSA I/O.
> I want a very simple thing. I don't mind even changing the my USB ALSA
> driver to call my DSP_TX whenever it has a capture buffer ready, and
> to be able to do something like snd_pcm_writei (or mmap_writei) from
> my DSP driver. I just don't know where to hack to it...
> 
I would suggest looking at the documentation available on writing an
alsa driver. This will explain what goes where in your driver.

http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/

> I still don't understand if I need ALSA driver (in which there is no
> DAI), or an ASOC driver. BTW, I don't need any "mixer" capabilities.
> 

If you are playing or capturing audio then you will need an ALSA/ASoC
driver. If your sound hardware is SoC based then use the ASoC APIs, you
will probably find that some of your HW is already supported under ASoC.
ASoC extends the ALSA APIs for SoC based devices with multiple audio
components (probably like your IP phone HW).

Liam  

> Thanks, Eli.
> 
> My system is IP phone.
> -----Original Message-----
> From: Liam Girdwood [mailto:liam.r.girdwood@linux.intel.com]
> Sent: Thursday, November 27, 2014 15:12
> To: Eli Britstein
> Cc: alsa-devel@alsa-project.org; Mark Brown
> Subject: Re: [alsa-devel] ALSA/ASOC new device and routing
> 
> Reflowed the message.
> 
> On Thu, 2014-11-27 at 09:21 +0000, Eli Britstein wrote:
> > Hi
> >
> > I'm a newbie to ALSA.
> > I'm targeting to use ALSA or ASoC solution in order to route
> > capture/playback streams of a USB headset (that uses ALSA) to/from my
> > own DSP device.
> > I saw DPCM which is a part of ASoC manages dynamically connections
> > between FE and BE streams.
> > In my product, I just need them to be connected. No need for the
> > "dynamically" part.
> >
> Ok, so you have standard static routing from source to sink. ? or does your DSP allow routing from PCM 0 to HW port 0 .. N ?
> [EliB] my DSP doesn't have any relationship with ALSA, so I guess the answer for that is no.
> 
> Best to also describe your HW in more detail so that people on the list can provide better answers.
> [EliB] see above.
> 
> > My questions:
> > 1. Can someone please recommend a step by step guide, or an example
> > how to make my DSP "look like" a BE? Do I need to write an ALSA driver
> > for it or a ASOC driver?
> 
> If the routing is static then there is no need to create FE and BE DAI links for your DSP. Just create standard PCM and DAI link. Otherwise have a look at existing DPCM based drivers like Intel Haswell/Broadwell and OMAP4.
> [EliB] the routing I want is static.
> 
> > 2. After I have it as a BE, how can I connect the streams? I want the
> > transfers to be done in kernel level, without need for application
> > interventions for each buffer.
> 
> The connection depends on your DSP routing topology. Again look at the existing examples. I think you are also asking about DMA here ? if so, the kernel takes care of DMA configuration, however your application will probably still have to perform IO on your audio buffers.
> 
> > 3. I'm using kernel 2.6.10 (quite old, I know). I don't want to port
> > my entire kernel to a new one. As my requirement is not very complex,
> > I don't think I'd encounter too many issues. However, if someone can
> > point the important parts I need to back port, I'd appreciate it.
> > Alternatively, if someone sees a showstopper in this approach, I'd be
> > grateful to be aware of it.
> >
> 2.6.10 is really ancient and there have been many improvements since. I would strongly recommend upgrading to the latest release.
> 
> [EliB] I understand, but I cannot. Such upgrade is quite massive. As I think my requirements are quite simple, I think I can live without it.
> 
> Liam
> >
> > Thanks,
> > Best regards,
> >
> > Eli
> >
> 
> 
> 
> ________________________________
> 
> This email and any files transmitted with it are confidential material. They are intended solely for the use of the designated individual or entity to whom they are addressed. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, use, distribution or copying of this communication is strictly prohibited and may be unlawful.
> 
> If you have received this email in error please immediately notify the sender and delete or destroy any copy of this message
