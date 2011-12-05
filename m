From: Patrick Lai <plai@codeaurora.org>
Subject: Re: ASoC: Dynamic CODEC DAI
Date: Sun, 04 Dec 2011 23:22:22 -0800
Message-ID: <4EDC712E.9040409@codeaurora.org>
References: <4ED42C0E.2080300@codeaurora.org>
	<20111129134913.GB26800@opensource.wolfsonmicro.com>
	<4ED83E52.6080004@codeaurora.org> <1322820685.7185.12.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 2566224398
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 08:22:26 +0100 (CET)
In-Reply-To: <1322820685.7185.12.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 12/2/2011 2:11 AM, Liam Girdwood wrote:
>
> Fwiw, I'm looking at a similar channel mapping problem here for dyanmic
> PCM and have the start of some working code. Basically I want to be able
> to specify which channels from each PCM device are routed through each
> DAI and DAPM widget.
>
Would you mind sharing the use case you have in mind? It is not clear
to me how your design proposal correlate to the problem I have in hand.
It looks to me that you are trying to address shuffling of pcm channels
correct me if I am wrong. For example, 5.1 content is composed with
certain speaker allocation in mind but the actual speaker allocation is
different. So, through the approach you are proposing, software can
rearrange the pcm channels according to actual speaker allocation.

My problem has more to do with ability to form PCM device at run-time
by grouping available slimbus ports at the CPU side and CODEC side
after knowing number of channels required. Furthermore, the CODEC I am
working on does not allow all mic inputs going to all audio interface
capture ports. Unless application can provide the mic input it is
interested before initiation of capture stream, it is hard to utilize
very slimbus port on the CODEC. Do you have work in progress code on
gitorious.org? Perhaps, I can take a look to understand more about your
proposed design and see what I can leverage.


>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
