From: Patrick Lai <plai@codeaurora.org>
Subject: Re: ASoC: Dynamic CODEC DAI
Date: Mon, 28 Nov 2011 22:14:31 -0800
Message-ID: <4ED47847.7020206@codeaurora.org>
References: <4ED42C0E.2080300@codeaurora.org>
	<000001ccae35$0122cf60$03686e20$@bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 12FD624425
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 07:14:33 +0100 (CET)
In-Reply-To: <000001ccae35$0122cf60$03686e20$@bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: 'alsa-devel' <alsa-devel@alsa-project.org>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 11/28/2011 5:19 PM, Pierre-Louis Bossart wrote:
>> The CODEC which I am working on transports digital audio through
>> SLIMBUS instead of I2S. The concept of CODEC DAI does not apply too
>> well with SLIMBUS architecture as CODEC DAIs are typically defined base
>> on a set of I2S digital audio interface(bit clock, world select, sd
>> lines). On the CODEC, there are 10 digital capture ports. They can be
>> independently configured as mono channels or can be run-time grouped
>> together to function like multi-channel CODEC DAIs. On top of that,
>> only some ports out of 10 ports can accept all analog mic inputs or
>> digital mic inputs. Hence, even though the CODEC satisfies the
>> concurrent use cases it was designed for, software would have to be
>> articulate on grouping the ports in order to utilize all ports. So, I
>> cannot simply code up CODEC DAI definitions in the CODEC driver for a
>> particular machine. For now, I am looking for compile time grouping of
>> these ports as use cases are known at the time machine is designed.
>
> I may be reaching summits of cluelessness here, but isn't the logical
> grouping/shuffling of channels needed on the cpu/host side only, possibly at
> the machine-driver level?
This is exactly what I am planning to do. Have the machine driver 
handles the grouping. However, DAI link is consisted of one CODEC dai, 
one CPU DAI, and platform driver. Unlike I2s which number of channels 
per DAI is fixed, I can divide 10 available ports to several groups. 
Each group belongs to different DAI links so ports within same group 
form x number of channels stream and feed into CPU. However, how many 
ports per group and which ports to use is unknown to CODEC driver and 
would have to be decided by machine driver. . That's why I need to 
propose the design on ASoc framework.

At the codec level you should only need to worry
> about which channel/port goes to what output, and that would be similar to
> TDM/AC97. I don't understand why all this should be part of a codec driver.
Please excuse my lack of understanding about AC97. There is a codec
driver /sound/soc/codec/ac97.c. However, only one DAI is defined and
supports both playback/capture with 2 as max channels. I don't see how
static CODEC DAI definition is going to satisfy my requirements. I am
still bounded to DAI link structure definition which takes only one
CODEC DAI. In this case with ac97.c, I am still limited to work with
pre-defined CODEC DAI in ac97.c  Is there an example for grouping ac97
channels?

> -Pierre
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
