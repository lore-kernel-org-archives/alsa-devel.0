From: Liam Girdwood <lrg@ti.com>
Subject: Re: ALSA concurrent use case for 5.1 LPCM on HDMI.
Date: Thu, 26 Jul 2012 00:07:01 +0100
Message-ID: <1343257621.16982.9.camel@odin>
References: <16e078f384eda9134af4b78dec4ec090.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog112.obsmtp.com (na3sys009aog112.obsmtp.com
 [74.125.149.207])
 by alsa0.perex.cz (Postfix) with ESMTP id A489D265B47
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 01:07:03 +0200 (CEST)
Received: by weyr1 with SMTP id r1so1030369wey.29
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 16:07:03 -0700 (PDT)
In-Reply-To: <16e078f384eda9134af4b78dec4ec090.squirrel@www.codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gsantosh@codeaurora.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-07-25 at 01:37 -0700, gsantosh@codeaurora.org wrote:
> Hi All,
> 
> I have following use case I am facing an issue with the ALSA framework,
> 
> Consider a use case
> 
> 1)	System tone or any stream running on Front End 0 with stereo channel
> configuration On Back End 0(HDMI)
> 2)	Start a local file playback for 5.1 LPCM on Front End 1 with 5.1
> channel configuration On Back End 0(HDMI)
> 
> Here FE0 and FE1 is routed to same BE0.
> 
> When step 2 is done I see following behavior of ALSA which is not correct.
> Framework will check that the BE0 is running with FE0 routed and running,
> Framework will not trigger the fixup and hw_params callback to re
> configure the session for FE1 with 5.1 channel.
> 
> With this effect we are playing the FE1 session with stereo instead of 5.1
> channel configuration, how to rectify this issue?
> 

Hmm, the fixup code will currently only run when the BE0 is initially
configured via hw_params(). The problem here is that if we fixup and
reconfigure BE0 (via hw_params()) after it is running then this will
likely cause undesired audio artifacts on BE0 (since in this case it's
already playing stereo and we want to change to 6 channel).

We have a similar situation with OMAP where we support many channels (2
- 6) on one McBSP BE DAI. We always configure the BE McBSP in 6 channel
mode and that allows us to open any FE with 2...6 channels (without a
fixup and restart of the McBSP port). 

Regards

Liam

> Regards,
> Santosh M G.
> 
> 
> 
> 
