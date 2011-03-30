From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Question about your DSP topic
Date: Wed, 30 Mar 2011 13:39:53 -0700
Message-ID: <4D939519.6040506@codeaurora.org>
References: <4D2652C8.7030701@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 798651039E1
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 22:39:47 +0200 (CEST)
In-Reply-To: <4D2652C8.7030701@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Liam/Mark,

I ran some tests on top of soc-dsp framework pulled from Liam's
topic/dsp-upstream(http://git.kernel.org/?p=linux/kernel/git/lrg/asoc-
2.6.git;a=summary). I found there is a scenario that soc-dsp framework
erroneously start pcm playabck/capture. Here is the scenario:

In the platform driver, I have this route table defined

FE1 Playback -> Mixer 1 -> BE1
BE2 -> FE1 Capture
FE = Front-end, BE = Back-end

While PCM playback is going from FE1 playback to BE1, I switch off FE1
playback to Mixer 1. This caused soc_dsp_runtime_update called.
Framework correctly close BE1 as it is no longer needed. Eventually,
framework finds BE2 is connected to FE1 capture. Framework, without
checking if FE1 capture is activated by user-space application, simply
goes ahead activate BE2. Since FE1 capture is never activated,
runtime structure is not allocated. This inherently results NULL
pointer dereference exception.

For now, in soc-dsp.c be_connect function(), I have a check to make sure
fe->dsp[stream].runtime is not NULL. I don't know if it's appropriate
fix. Can you please take a look?

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
