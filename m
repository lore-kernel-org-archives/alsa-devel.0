From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Fri, 04 Jan 2008 20:35:44 -0600
Message-ID: <477EED00.8070207@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>	<477BAB67.4080003@freescale.com>	<fa686aa40801020812o471e18e6u9fe20676d320e958@mail.gmail.com>	<477D24AA.4050804@freescale.com>	<fa686aa40801031017n42f6fbf1nb2da5097ef13cf3c@mail.gmail.com>	<477D2F52.7090306@freescale.com>
	<fa686aa40801031113od68e2a3m6cb60b8fa6f26c17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EE0A244A2
	for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2008 03:35:10 +0100 (CET)
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
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Grant Likely wrote:
> On 1/3/08, Scott Wood <scottwood@freescale.com> wrote:
>> Grant Likely wrote:
>>> On 1/3/08, Timur Tabi <timur@freescale.com> wrote:
>>>> Grant Likely wrote:
>>>>
>>>>> Why not be a child of the i2c bus with a phandle to the ssi bus?
>>>> Because when I probe the SSI node, I want to know what the attached codec is.
>>>>   So if anything, I would need a pointer from the SSI bus *to* the respective
>>>> child on the I2C bus.
>>> That's fine too (it's what is done with Ethernet PHYs).  My preference
>>> is the other way around, but it's not a big issue in this case.
>> I'd just link in both directions, and let software follow it in
>> whichever direction it prefers.
> 
> Gah!  Don't do that!  Then you need to maintain both directions in the
> dts file. 

So?  What's wrong with that?

> Software is good at generating reverse mappings. 

What software would that be?  Currently, there is no software that will do 
that?  Or are you saying that you want my driver to search the entire device 
tree until it finds the reverse mapping?  I don't think *that* is a good idea.

> Don't put
> that burden on the dts author. 

As the DTS author in question, I hereby declare that such a requirement is not 
a burden in the slightest.  Thank you.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
