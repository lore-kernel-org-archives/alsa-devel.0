From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Question about your DSP topic branch
Date: Thu, 27 Jan 2011 13:51:58 -0800
Message-ID: <4D41E8FE.4070206@codeaurora.org>
References: <4D2652C8.7030701@codeaurora.org> <4D3E7536.9070906@codeaurora.org>
	<20110125115113.GB13051@sirena.org.uk>
	<4D3FBDB1.90804@codeaurora.org>
	<20110126112004.GA5476@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 16FF510380A
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 22:52:07 +0100 (CET)
In-Reply-To: <20110126112004.GA5476@opensource.wolfsonmicro.com>
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

On 1/26/2011 3:20 AM, Mark Brown wrote:
> On Tue, Jan 25, 2011 at 10:22:41PM -0800, Patrick Lai wrote:
>> On 1/25/2011 3:51 AM, Mark Brown wrote:
>
>>> Yes, that'd be kind of nice but given how tiny these noop drivers are
>>> and the fact that they do all need to specify their capabilites it's not
>>> clear that there's much advantage from combining them into a single
>>> driver - the boiler plate is so small and simple.
>
>> Do we consider the case that codec driver is not required such as
>> virtual sink or sink is configured outside of ALSA driver? If we
>> create dummy codec driver for each use case, wouldn't
>> sound/soc/codecs end up littered with bunch of noop drivers?
>
> Yup, but it's not really a big cost - they're all so trivial.

Currently, I already have few dummy codec drivers in mind for the 
project I am working on. I am not worried about the size of these files. 
Beside having tons of dummy codec drivers in the source tree, I am also 
looking at the value and effort to upstream these trivial drivers.
>> Furthermore, couldn't capabilities
>> being passed through platform device?
>
> Right, but of course you probably end up defining a common set of
> platform data for each device so people don't have to cut'n'paste the
> same thing into all the different board files.

Yes, that would be convenient for others. However, I see the effort to 
create multiple platform devices and paste the capabilities in the board 
file far less than upstreamng no-op drivers and making changes in 
Kconfig and Makefile under sound/soc/codecs.

Thanks

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
