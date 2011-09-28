From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Signaling user-space through kcontrol
Date: Wed, 28 Sep 2011 00:26:43 -0700
Message-ID: <4E82CC33.7060608@codeaurora.org>
References: <4E82BB4C.1030801@codeaurora.org>
	<1317190544.1573.1646.camel@vkoul-udesk3>
	<4E82C307.30407@codeaurora.org>
	<1317193412.1573.1647.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 30D28103884
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 09:26:46 +0200 (CEST)
In-Reply-To: <1317193412.1573.1647.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 9/28/2011 12:03 AM, Vinod Koul wrote:
>> Main one is detection of short circuiting headphone For this case,
>> there is no need for extra payload. In case of there is need to pass
>> back some payload, I presume user-space application can simply call the
>> get function upon receiving notification.
> And what would userspace do with that information? Apart from logging
> this, is there anything useful we can do with such info
>
Well, it's up to user-space application to decide. I suppose
application would not allow audio route to headphone/headset at this
point.

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
