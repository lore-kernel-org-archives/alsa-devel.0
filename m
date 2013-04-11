From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Enhance support for SigmaDSP chips
Date: Thu, 11 Apr 2013 12:51:10 +0200
Message-ID: <5166959E.7010008@metafoo.de>
References: <516688D4.9040700@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-204.synserver.de (smtp-out-204.synserver.de
 [212.40.185.204])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C453265077
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 12:52:04 +0200 (CEST)
In-Reply-To: <516688D4.9040700@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: Cliff Cai <cliff.cai@analog.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/11/2013 11:56 AM, Daniel Mack wrote:
> Hi Lars,
> Hi Cliff,
> 
> I'm looking into the SigmaDSP AD1701 support, as a new prospective
> project will use it. What's going to be used on this chip is not the
> DAC/ADC features though, but the internal, programmable DSP things, and
> designers will use the SigmaStudio IDE to generate the firmware.
> 
> So I'm wondering how to support this kind of chip properly in ALSA,
> which is not straight-forward, as the controls exported by it are
> specific to the loaded firmware of course. Also, the IDE is free to
> re-allocate every sub-addresses of its controls when something changes
> in the layout of the building blocks.
> 
> One idea I have in mind is to have a little parser script that reads the
> generated sources of the IDE and dump a device-tree node snippet which
> can then be put into the final DT. The driver would need to learn about
> how to interpret that DT nodes, which will most likely just contain a
> name, a sub-address, along with some mask and shift values.
> 
> I wanted to ask for your opinion on that before I start. Have you ever
> used any of the DSP features from ALSA/ASoC? Are there any pitfalls I
> should be aware of? Is anyone actively working on improvements on the
> driver?
> 
> An alternative approach is to write a userspace library of course, but
> that's going to be problematic once anybody wants to use the DSP
> features in parallel to the DAC/ADC.

Hi,

I just yesterday wrote a small post how you can program the DSP registers.
http://ez.analog.com/message/83094#83094

I'd like to be able to put the information about the different algorithms
into the DSP firmware file itself, so we can auto instantiate the controls
from the driver. The problem is that it is not so easy to generalize the
export of the algorithms from SigmaStudio.

Another problem is that you don't know how to calculate the algorithm
parameters at runtime for some of the more complex algorithms.

I don't think it's a good idea to put the control info into the devicetree
and would rather prefer to see them go into the firmware. But as I said
auto-generating this from exported SigmaStudio files is not so easy. So
maybe manually creating the control info table might be an option.

Btw. in case you haven't seen it the SigmaTcp tools is quite useful during
the development of the firmware since it allows you to connect SigmaStudio
directly to the DSP on the board.
http://wiki.analog.com/resources/tools-software/linux-software/sigmatcp

- Lars
