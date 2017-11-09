From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 01/17] ASoC: tlv320aic31xx: General source
 formatting cleanup
Date: Thu, 9 Nov 2017 08:13:17 -0600
Message-ID: <98eaa342-8405-56af-0804-38c7c1e5bc2a@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
 <20171109002741.10897-2-afd@ti.com>
 <20171109124143.mpolqcvsdzj2t6tv@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 52D3C266B80
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 15:13:19 +0100 (CET)
In-Reply-To: <20171109124143.mpolqcvsdzj2t6tv@sirena.co.uk>
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

On 11/09/2017 06:41 AM, Mark Brown wrote:
> On Wed, Nov 08, 2017 at 06:27:25PM -0600, Andrew F. Davis wrote:
>> Simple non-functional changes including:
>>
>>  * Fix header copyright tags
>>  * Fix spelling errors
>>  * Reformat code for easier reading
>>  * Move some code blocks to a more natural ordering
>>  * Remove unneeded code
>>  * Remove assignments that are always overridden
>>  * Normalize function return paths
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
> 
> There's other things in here like adding error reporting...  please
> don't send changes like this, if you want to do cleanups you should
> split them up in the same way you would other changes.  Bigger patches
> are harder to review especially if they're not repetitive examples of
> the same pattern.  
> 

I'm never really sure with these where the split point should be, almost
every change in here could be its own patch if I really wanted to pad my
kernel patch count, but this series is already 17 patches long and I
usually see these all as the same logical action: non-functional cleanups.

I agree the added error message isn't purely non-functional and so
should be broken out, I'll break out a couple other changes for v2.
