From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Question about your DSP topic branch
Date: Thu, 17 Mar 2011 00:29:18 -0700
Message-ID: <4D81B84E.1060607@codeaurora.org>
References: <4D2652C8.7030701@codeaurora.org> <4D3E7536.9070906@codeaurora.org>
	<20110125115113.GB13051@sirena.org.uk>
	<4D3FBDB1.90804@codeaurora.org>
	<20110126112004.GA5476@opensource.wolfsonmicro.com>
	<4D41E8FE.4070206@codeaurora.org>
	<20110131133015.GI5123@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id BC1861038C4
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 08:28:51 +0100 (CET)
In-Reply-To: <20110131133015.GI5123@opensource.wolfsonmicro.com>
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

On 1/31/2011 5:30 AM, Mark Brown wrote:
> On Thu, Jan 27, 2011 at 01:51:58PM -0800, Patrick Lai wrote:
>> On 1/26/2011 3:20 AM, Mark Brown wrote:
>
>>> Yup, but it's not really a big cost - they're all so trivial.
>
>> Currently, I already have few dummy codec drivers in mind for the
>> project I am working on. I am not worried about the size of these
>> files. Beside having tons of dummy codec drivers in the source tree,
>> I am also looking at the value and effort to upstream these trivial
>> drivers.
>
> Like I say, it's utterly trivial.

I see a flag "no_codec" defined in struct snd_soc_dai_link. Is that
flag going to stay or just a temporary workaround?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
