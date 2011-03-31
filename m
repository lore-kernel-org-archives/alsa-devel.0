From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Question about your DSP topic branch
Date: Thu, 31 Mar 2011 22:35:22 +0100
Message-ID: <1301607322.3549.211.camel@odin>
References: <4D2652C8.7030701@codeaurora.org>
	<4D939519.6040506@codeaurora.org>  <4D9421DB.4010204@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DEF121037FB
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 23:35:28 +0200 (CEST)
Received: by wwf26 with SMTP id 26so2608847wwf.20
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2011 14:35:26 -0700 (PDT)
In-Reply-To: <4D9421DB.4010204@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-30 at 23:40 -0700, Patrick Lai wrote:
> Hi Liam/Mark,
> 
> In the back-end platform driver, routing table and array of widgets are 
> defined to describe interconnection of front-end and back-end. Instead 
> of defining FE and BE as AIF pin using SND_SOC_DAPM_AIF_IN/OUT macros,
> I would like to use SND_SOC_DAPM_AIF_IN_E/OUT_E macros. Essentially, I 
> want to register event handler to jump start routing in the DSP for a 
> newly activated FE under multiple streams to single HW path scenario. At 
> this time, BE is already activated so I need other mechanism to jump 
> start routing. I could put the logic in my front-end CPU DAI driver. 
> However, I feel that path setup should be handled by DAPM/DSP framework. 
> Hence, I am looking for a good place to trigger calling of event handler 
> in soc-dapm.c/soc-dsp.c. Any suggestion?


So iiuc, your BE is active (with another FE) and you then enable a
another FE that is connected to the already active BE ?

It should be possible to add support for the _E() macros in soc-dsp.c,
but I'm not sure why it's required atm since we dont need this for OMAP4
ABE.

Liam   

> 
> Thanks
> Patrick
> 
