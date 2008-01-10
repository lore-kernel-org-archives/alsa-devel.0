From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 10 Jan 2008 10:03:47 -0600
Message-ID: <478641E3.5070404@freescale.com>
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	
	<20080103235156.GE12883@localhost.localdomain>	
	<477EEDFA.9010205@freescale.com>	
	<20080106004637.GJ4326@localhost.localdomain>	
	<47824AA3.5070808@freescale.com>	
	<20080107182853.GA17312@sirena.org.uk>	
	<20080110034919.GI17816@localhost.localdomain>	
	<9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>	
	<1199961015.19903.270.camel@localhost.localdomain>	
	<47863C31.50309@freescale.com>
	<fa686aa40801100801p3da98eecn44401b17fe652da8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 89815245F1
	for <alsa-devel@alsa-project.org>; Thu, 10 Jan 2008 17:04:17 +0100 (CET)
In-Reply-To: <fa686aa40801100801p3da98eecn44401b17fe652da8@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>, david@gibson.dropbear.id.au
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:

> The driver doesn't need to be 100% correct.  Drivers are easy to
> change if they aren't quite right.  There are no long term
> consequences.
 >
> However, the device tree issues must be addressed before it is merged
> and deployed.  Otherwise we end up having to support poorly designed
> trees over the long term.

I agree.  Correct me if I'm wrong, but I think the only device tree "issue" is 
the definition of the 'codec' node under the SSI node.  If so, I'm not sure what 
other changes need to be mode.

-- 
Timur Tabi
Linux kernel developer at Freescale
