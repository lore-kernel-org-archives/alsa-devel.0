From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Store codec capabilites in alsa
Date: Mon, 29 Oct 2012 20:23:28 -0700
Message-ID: <508F4830.4010600@codeaurora.org>
References: <000001cdb31e$9a76a530$cf63ef90$@codeaurora.org>
 <508A69DB.7030009@ti.com> <508DD824.3040600@codeaurora.org>
 <20121029170732.GF4511@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 by alsa0.perex.cz (Postfix) with ESMTP id CCA11265D64
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 04:23:30 +0100 (CET)
In-Reply-To: <20121029170732.GF4511@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 10/29/2012 10:07 AM, Mark Brown wrote:
> On Sun, Oct 28, 2012 at 06:13:08PM -0700, Patrick Lai wrote:
>
>> I doubt that ASoC has mechanism for vendor's own CODEC driver to
>> advertise CODEC specific information. However, we would like to
>> check ahead of time before coming up with something on our own.
>
> Unless you tell us something about what's being advertised it's very
> hard to comment;

CODEC has filters for noise cancellation purpose. CPU will need to know 
given CODEC has noise cancellation support. Also, CPU needs to know the 
CODEC registers to program the filters and which digital audio interface 
would have noise reference.

Thanks
Patrick

it's often the case that things are just new rather
> than device specific.
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
