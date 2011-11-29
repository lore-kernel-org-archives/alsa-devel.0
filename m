From: Patrick Lai <plai@codeaurora.org>
Subject: ASoC: Dynamic CODEC DAI
Date: Mon, 28 Nov 2011 16:49:18 -0800
Message-ID: <4ED42C0E.2080300@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id DF7D41039EA
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 01:49:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


Problem overview:

The CODEC which I am working on transports digital audio through
SLIMBUS instead of I2S. The concept of CODEC DAI does not apply too
well with SLIMBUS architecture as CODEC DAIs are typically defined base
on a set of I2S digital audio interface(bit clock, world select, sd
lines). On the CODEC, there are 10 digital capture ports. They can be
independently configured as mono channels or can be run-time grouped
together to function like multi-channel CODEC DAIs. On top of that,
only some ports out of 10 ports can accept all analog mic inputs or
digital mic inputs. Hence, even though the CODEC satisfies the
concurrent use cases it was designed for, software would have to be
articulate on grouping the ports in order to utilize all ports. So, I
cannot simply code up CODEC DAI definitions in the CODEC driver for a
particular machine. For now, I am looking for compile time grouping of
these ports as use cases are known at the time machine is designed.

Proposal:
I want to minimize amount of change to soc framework at the same time
meeting my requirement.

Here is my proposed design

In CODEC driver, I will declare codec dai for each port.
Then, I will enhance ASoC framework to take a list of CODEC DAIs and
pass list of CODEC DAIs back to callback function such as startup,
hw_param, prepare, trigger. I believe this approach will not require
massive amount of change to framework.

Your feedback is appreciated.

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
