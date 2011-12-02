From: Patrick Lai <plai@codeaurora.org>
Subject: Re: ASoC: Dynamic CODEC DAI
Date: Thu, 01 Dec 2011 18:56:18 -0800
Message-ID: <4ED83E52.6080004@codeaurora.org>
References: <4ED42C0E.2080300@codeaurora.org>
	<20111129134913.GB26800@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 47ED9245DD
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 03:56:23 +0100 (CET)
In-Reply-To: <20111129134913.GB26800@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 11/29/2011 5:49 AM, Mark Brown wrote:
> On Mon, Nov 28, 2011 at 04:49:18PM -0800, Patrick Lai wrote:
>
>> In CODEC driver, I will declare codec dai for each port.
>> Then, I will enhance ASoC framework to take a list of CODEC DAIs and
>> pass list of CODEC DAIs back to callback function such as startup,
>> hw_param, prepare, trigger. I believe this approach will not require
>> massive amount of change to framework.
>
> The above is really vauge so it's hard to comment in any detail.
The thing is that in order for DAPM to figure out which path to enable,
AIF_IN and AIF_OUT widgets must be associated with stream name(e.g HiFi
  Playback) as part of CODEC DAI definition. Now, with the grouping
requirement, CODEC DAI definition with fixed number of channels will
not work as interconnect table defined in the CODEC driver establishes
relationship of AIF pins and codec dai stream name which now would have
to be machine base. Another approach would be having machine driver
define AIF pins, interconnect table and CODEC DAIs for CODEC driver. I
would think this approach would bear too much burden on the machine
driver developer. Instead, each slimbus port on the CODEC, by
definition, is a mono CODEC DAI. Extending DAI link definition to take
a list of CODEC dais allows machine driver to group the ports. Passing
back the CODEC DAI list to CODEC driver allows CODEC driver know which 
slimbus ports are associated with given pcm stream. As on the CPU side,
instead of burdening CPU driver from knowing what ports and enumeration
address of CODEC, we have concept of shared data channel IDs. So, both
CODEC driver and CPU driver communicate to SLIMBUS driver to set up
data channels using the channel ID. CPU and CODEC independently can
setup their own SLIMBUS ports. Machine driver assigns channel ID to
both CPU and CODEC drivers.

  I'm
> not sure it's worth trying to be too non-invasive, anything controlling
> hardware is going to have to understand what's going on at the physical
> level anyway and the host side is going to have to interoperate with the's
> Slimbus framework.  The core is also going to need to know about the
> channel groups to allocate and destroy them as required.
I presume you are referring to soc-core, with the approach I propose
above, I think soc-core does not have to be aware of SLIMBUS framework.
On the other hand, my approach will not be able to utilize run-time
grouping ability offered by SLIMBUS as ports are pre-assigned at
compile time. So, However, we are talking about drastic change. with
SLIMBUS, we can run-time create new pcm device as long as there are
enough SLIMBUS ports ignoring the fact that ports on my CODEC cannot
connect to all mic inputs. Entire framework built on static number of
pcm devices please correct me if I am wrong.


  It seems like
> being more explicit might be easier.
>
> Also note that the work on submitting your Silmbus driver core to
> mainline appears totally stalled, there was just an initial posting but
> no followup.
I guess slimbus driver guy is completely swamped now as SLIMBUS is new
and it takes a lot of effort to stablize.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
