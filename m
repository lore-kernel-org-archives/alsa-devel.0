From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Question about your DSP topic branch
Date: Tue, 25 Jan 2011 22:22:41 -0800
Message-ID: <4D3FBDB1.90804@codeaurora.org>
References: <4D2652C8.7030701@codeaurora.org> <4D3E7536.9070906@codeaurora.org>
	<20110125115113.GB13051@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id ABFA824437
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 07:22:34 +0100 (CET)
In-Reply-To: <20110125115113.GB13051@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 1/25/2011 3:51 AM, Mark Brown wrote:
> On Mon, Jan 24, 2011 at 11:01:10PM -0800, Patrick Lai wrote:
>
>> 8. I see there is dmic codec(dmic.c) under sound/soc/codec which is
>> pretty much just a dummy codec driver. I supposed the configuration of
>> DMIC is done in other driver. Would it be better if we could have
>
> It's for direct DMIC interfaces in CPUs like OMAP4 has.
>
>> something like fixed voltage regulator? So, there is no need to
>> duplicate the effort.
>
> Yes, that'd be kind of nice but given how tiny these noop drivers are
> and the fact that they do all need to specify their capabilites it's not
> clear that there's much advantage from combining them into a single
> driver - the boiler plate is so small and simple.

Do we consider the case that codec driver is not required such as 
virtual sink or sink is configured outside of ALSA driver? If we create 
dummy codec driver for each use case, wouldn't sound/soc/codecs end up 
littered with bunch of noop drivers? Furthermore, couldn't capabilities
being passed through platform device?

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
