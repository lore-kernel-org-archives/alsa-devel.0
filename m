From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Enhance support for SigmaDSP chips
Date: Thu, 11 Apr 2013 14:53:27 +0200
Message-ID: <5166B247.807@metafoo.de>
References: <516688D4.9040700@zonque.org> <5166959E.7010008@metafoo.de>
 <5166A649.2030509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-211.synserver.de
 [212.40.185.211])
 by alsa0.perex.cz (Postfix) with ESMTP id 05B9C261091
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 14:54:19 +0200 (CEST)
In-Reply-To: <5166A649.2030509@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/11/2013 02:02 PM, Daniel Mack wrote:
> Hi Lars,
> 
> (taking off Cliff's email address, as it's apparently not valid any more).
> 
> 
> On 11.04.2013 12:51, Lars-Peter Clausen wrote:
>> On 04/11/2013 11:56 AM, Daniel Mack wrote:
>>> Hi Lars,
>>> Hi Cliff,
>>>
>>> I'm looking into the SigmaDSP AD1701 support, as a new prospective
>>> project will use it. What's going to be used on this chip is not the
>>> DAC/ADC features though, but the internal, programmable DSP things, and
>>> designers will use the SigmaStudio IDE to generate the firmware.
>>>
>>> So I'm wondering how to support this kind of chip properly in ALSA,
>>> which is not straight-forward, as the controls exported by it are
>>> specific to the loaded firmware of course. Also, the IDE is free to
>>> re-allocate every sub-addresses of its controls when something changes
>>> in the layout of the building blocks.
>>>
>>> One idea I have in mind is to have a little parser script that reads the
>>> generated sources of the IDE and dump a device-tree node snippet which
>>> can then be put into the final DT. The driver would need to learn about
>>> how to interpret that DT nodes, which will most likely just contain a
>>> name, a sub-address, along with some mask and shift values.
>>>
>>> I wanted to ask for your opinion on that before I start. Have you ever
>>> used any of the DSP features from ALSA/ASoC? Are there any pitfalls I
>>> should be aware of? Is anyone actively working on improvements on the
>>> driver?
>>>
>>> An alternative approach is to write a userspace library of course, but
>>> that's going to be problematic once anybody wants to use the DSP
>>> features in parallel to the DAC/ADC.
>>
>> Hi,
>>
>> I just yesterday wrote a small post how you can program the DSP registers.
>> http://ez.analog.com/message/83094#83094
> 
> Good timing :) Yes, I would add something like this, but in a generic
> manner of course.
> 
>> I'd like to be able to put the information about the different algorithms
>> into the DSP firmware file itself, so we can auto instantiate the controls
>> from the driver. The problem is that it is not so easy to generalize the
>> export of the algorithms from SigmaStudio.
> 
> But just to understand this right: the firmware exported by SigmaStudio
> is already what the driver loads via the kernel firmware interface, right?

Kind of, there is no support for generating the firmware from within
SigmaStudio. But there is an external tool which takes data which has been
exported form SigmaStudio and generates the firmware:

http://wiki.analog.com/resources/tools-software/linux-software/sigmadsp_genfirmware

> 
>> Another problem is that you don't know how to calculate the algorithm
>> parameters at runtime for some of the more complex algorithms.
> 
> I would just want to set the controls as specified by the exported
> header file, whatever kind of control that is. I haven't done real-world
> tests yet, but the output of a example project doesn't seem very
> complicated. Which 'more complex algorithms' are you referring to?

Basically anything that is not a push button or a gain selector. E.g. the
coefficients for a compressor. You could expose these as SOC_BYTES control,
but you'd still need a userspace application that is able to recalculate
them at runtime.

> 
>> I don't think it's a good idea to put the control info into the devicetree
>> and would rather prefer to see them go into the firmware.
> 
> I thought about this too, but after all, the DT describes the hardware,
> and the hardware in this case is something that can be programmed. The
> idea would be to have that script that generates the DT fragment, and
> leave it up to the user to decide which controls to make accessible by
> the driver.
> 
> From the driver's perspective, I don't know if defining a binary
> interface format inside the firmware blob and parsing it at run-time is
> really easier to achieve than using the DT, especially as we have all
> convenient functions to read properties and iterate over nodes already
> prepared. But as I don't have the full picture of the DSPs yet, I might
> overlook the subtle details.

Well the description in the device tree needs to match the firmware and the
firmware is usually stored in userspace and can easily be replaced. It is in
my opinion better to have both the DSP firmware and the control description
in the same place.

- Lars
