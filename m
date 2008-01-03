From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 03 Jan 2008 13:18:31 -0600
Message-ID: <477D3507.5090906@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>	
	<477BAB67.4080003@freescale.com>	
	<fa686aa40801020812o471e18e6u9fe20676d320e958@mail.gmail.com>	
	<477D24AA.4050804@freescale.com>	
	<fa686aa40801031017n42f6fbf1nb2da5097ef13cf3c@mail.gmail.com>	
	<477D2F52.7090306@freescale.com>
	<fa686aa40801031113od68e2a3m6cb60b8fa6f26c17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id ACFBC24503
	for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2008 20:18:46 +0100 (CET)
In-Reply-To: <fa686aa40801031113od68e2a3m6cb60b8fa6f26c17@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:
> On 1/3/08, Scott Wood <scottwood@freescale.com> wrote:
>> I'd just link in both directions, and let software follow it in
>> whichever direction it prefers.
> 
> Gah!  Don't do that!  Then you need to maintain both directions in the
> dts file.  Software is good at generating reverse mappings.

Software is, however, lousy at correctly wading through 
poorly-structured data (which device trees are full of) to figure out 
how to locate the link it wants to follow backwards.

-Scott
