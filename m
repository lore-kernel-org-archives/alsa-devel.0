From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 03 Jan 2008 12:08:42 -0600
Message-ID: <477D24AA.4050804@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>	
	<477BAB67.4080003@freescale.com>
	<fa686aa40801020812o471e18e6u9fe20676d320e958@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id C373A10383B
	for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2008 19:07:41 +0100 (CET)
In-Reply-To: <fa686aa40801020812o471e18e6u9fe20676d320e958@mail.gmail.com>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:

> Why not be a child of the i2c bus with a phandle to the ssi bus? 

Because when I probe the SSI node, I want to know what the attached codec is. 
  So if anything, I would need a pointer from the SSI bus *to* the respective 
child on the I2C bus.

I know little about platform devices/drivers, so I don't know how to use them.

Currently, I have a design flaw in my driver in that if I have two SSIs, and 
each one is attached to a CS4270, I don't have any way of making sure that the 
right CS4270 is using the right I2C address.  I'm guessing that if I switch to 
a platform-based model, I can resolve this issue.  But for now, the CS4270 
doesn't support that, so that patchset I have submitted works with what I 
have.  After my patchset has been applied, I'll be more than happy to look 
into updating the CS4270 (and everything else) to use the platform model for I2C.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
