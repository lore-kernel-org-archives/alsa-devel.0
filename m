From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Question about your DSP topic branch
Date: Thu, 31 Mar 2011 15:07:01 -0700
Message-ID: <4D94FB05.8030207@codeaurora.org>
References: <4D2652C8.7030701@codeaurora.org> <4D939519.6040506@codeaurora.org>
	<4D9421DB.4010204@codeaurora.org> <1301607322.3549.211.camel@odin>
	<20110331214239.GB21726@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id E505110381E
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Apr 2011 00:07:04 +0200 (CEST)
In-Reply-To: <20110331214239.GB21726@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 3/31/2011 2:42 PM, Mark Brown wrote:
> On Thu, Mar 31, 2011 at 10:35:22PM +0100, Liam Girdwood wrote:
>
>> It should be possible to add support for the _E() macros in soc-dsp.c,
>> but I'm not sure why it's required atm since we dont need this for OMAP4
>> ABE.
>
> Not sure why Patrick might need it but some of the DSPs I've seen
> require a multiple write sequence to kick them into doing things - for
> example, set the state up then do another write to tell it to apply the
> new configuration.

The reason is that PCM stream, which is presented as front-end, is
run-time instantiated in DSP. Routing command to DSP cannot
happen until PCM stream is available. So for multiple streams to same
back-end case, activation of back-end can trigger routing of first PCM
stream. However, for 2nd stream, backend is already active. So, routing
of 2nd PCM stream would have to be triggered by activation of front-end.

As I stated before, I can have front-end CPU DAI driver trigger as 
workaround. However, it seems like DAPM framework would be the best 
place to provide the hook. It's better to keep the routing logic
localized in platform driver in my opinion

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
