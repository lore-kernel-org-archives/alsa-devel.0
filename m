From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 09/19] ASoC: tlv320aic31xx: Remove
	platform data
Date: Wed, 6 Dec 2017 11:48:43 -0600
Message-ID: <b6f581be-6d3a-6fc3-036f-9efc1bfc2429@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-10-afd@ti.com>
 <20171201132606.vyw7wthmql5trkwq@sirena.org.uk>
 <4fee76ef-e518-69b6-3bcc-f65b0a31cacc@ti.com>
 <20171206124540.GC1827@finisterre>
 <10f1b19b-4a0a-e336-b757-933d46b5c8e9@ti.com>
 <20171206173059.qw4tt7nizmyo6xbl@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C046267A19
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:49:05 +0100 (CET)
In-Reply-To: <20171206173059.qw4tt7nizmyo6xbl@sirena.org.uk>
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

On 12/06/2017 11:30 AM, Mark Brown wrote:
> On Wed, Dec 06, 2017 at 10:19:28AM -0600, Andrew F. Davis wrote:
>> On 12/06/2017 06:45 AM, Mark Brown wrote:
> 
>>> Then if you want to upstream the driver you'll have to add the platform
>>> data support again.  Like I say not all architectures have anything
>>> other than board files.
> 
>> Then they can try, but they will rightfully get nack'd and told to stop
>> using board files and use DT/ACPI. Most upstream architectures don't use
>> board files anymore anyway, so I doubt this will ever happen.
> 
> No.  To repeat, not all architectures use DT or ACPI.  Expecting someone
> to impelement DT or ACPI support for an entire architecture and try to
> bring the ecosystem for that architecture along in order to add machine
> support is obviously totally unreasonable.
> 

That would be unreasonable I agree, but it's also completely
hypothetical, as again, there are no in-tree users and most platforms
are DT/ACPI, so the odds of anyone needing it are next to nothing.
