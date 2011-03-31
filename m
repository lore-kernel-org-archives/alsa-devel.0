From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Question about your DSP topic branch
Date: Wed, 30 Mar 2011 23:40:27 -0700
Message-ID: <4D9421DB.4010204@codeaurora.org>
References: <4D2652C8.7030701@codeaurora.org> <4D939519.6040506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 689BA246B5
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 08:40:21 +0200 (CEST)
In-Reply-To: <4D939519.6040506@codeaurora.org>
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

In the back-end platform driver, routing table and array of widgets are 
defined to describe interconnection of front-end and back-end. Instead 
of defining FE and BE as AIF pin using SND_SOC_DAPM_AIF_IN/OUT macros,
I would like to use SND_SOC_DAPM_AIF_IN_E/OUT_E macros. Essentially, I 
want to register event handler to jump start routing in the DSP for a 
newly activated FE under multiple streams to single HW path scenario. At 
this time, BE is already activated so I need other mechanism to jump 
start routing. I could put the logic in my front-end CPU DAI driver. 
However, I feel that path setup should be handled by DAPM/DSP framework. 
Hence, I am looking for a good place to trigger calling of event handler 
in soc-dapm.c/soc-dsp.c. Any suggestion?

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
