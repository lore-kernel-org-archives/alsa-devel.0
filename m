From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Store codec capabilites in alsa
Date: Tue, 30 Oct 2012 11:18:57 -0700
Message-ID: <50901A11.80503@codeaurora.org>
References: <000001cdb31e$9a76a530$cf63ef90$@codeaurora.org>
 <508A69DB.7030009@ti.com> <508DD824.3040600@codeaurora.org>
 <20121029170732.GF4511@opensource.wolfsonmicro.com>
 <508F4830.4010600@codeaurora.org>
 <20121030151303.GS4511@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 by alsa0.perex.cz (Postfix) with ESMTP id 23DDB260317
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 19:19:30 +0100 (CET)
In-Reply-To: <20121030151303.GS4511@opensource.wolfsonmicro.com>
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

On 10/30/2012 8:13 AM, Mark Brown wrote:
> On Mon, Oct 29, 2012 at 08:23:28PM -0700, Patrick Lai wrote:
>> On 10/29/2012 10:07 AM, Mark Brown wrote:
>
>>> Unless you tell us something about what's being advertised it's very
>>> hard to comment;
>
>> CODEC has filters for noise cancellation purpose. CPU will need to
>> know given CODEC has noise cancellation support. Also, CPU needs to
>> know the CODEC registers to program the filters and which digital
>> audio interface would have noise reference.
>
> Why is this all not just normal configuration done from the application
> layer?  Especially the noise reference configuration just looks like
> totally normal routing configuration.
>
Agree that for noise reference can be done through normal routing
configuration. However, CPU driver does not normally manage CODEC
register. In my case, CPU algorithm module needs to know what CODEC
registers to program in order to update the filters.
So far, ASoC model has partitioned roles of CPU and CODEC to be managed
by CPU driver and CODEC driver. Both drivers talk on common interface
to allow easy swap out of CPU hardware or CODEC hardware. In our case,
the requirement described so far requires tight coupling of CPU and
CODEC. We are looking to maintain clean partition while meeting the
requirement through ASoc framework.

>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
