From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 03/17] ASoC: tlv320aic31xx: Fix GPIO1
	register definition
Date: Thu, 9 Nov 2017 08:32:34 -0600
Message-ID: <2a4b7d9c-e0b1-a15c-f03a-0872f8ea312f@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
 <20171109002741.10897-4-afd@ti.com>
 <20171109124528.nadkkb76clg5lw2g@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 25E26266B80
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 15:32:35 +0100 (CET)
In-Reply-To: <20171109124528.nadkkb76clg5lw2g@sirena.co.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On 11/09/2017 06:45 AM, Mark Brown wrote:
> On Wed, Nov 08, 2017 at 06:27:27PM -0600, Andrew F. Davis wrote:
>> GPIO1 control register is number 51, fix this here.
>>
>> Fixes: bafcbfe429eb ("ASoC: tlv320aic31xx: Make the register values human readable")
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
> 
> We should send this as a bug fix to stable but this depends on your
> reformatting :(
> 

I put it after the reformatting as an example of its value, now that you
have seen it, I'll move it before the reformatting so it can be taken
independently.
