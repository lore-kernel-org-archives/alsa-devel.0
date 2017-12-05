From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 09/19] ASoC: tlv320aic31xx: Remove
	platform data
Date: Tue, 5 Dec 2017 15:20:19 -0600
Message-ID: <4fee76ef-e518-69b6-3bcc-f65b0a31cacc@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-10-afd@ti.com>
 <20171201132606.vyw7wthmql5trkwq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F894266AE1
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 22:20:22 +0100 (CET)
In-Reply-To: <20171201132606.vyw7wthmql5trkwq@sirena.org.uk>
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

On 12/01/2017 07:26 AM, Mark Brown wrote:
> On Wed, Nov 29, 2017 at 03:32:50PM -0600, Andrew F. Davis wrote:
>> Platform data is not used by anyone (at least in upstream) so
>> drop this data and switch to using fwnode(DT/ACPI) only.
> 
> The advantage being...?  Not all architectures use DT or ACPI so it's
> not clear that this is a step forwards in itself.
> 

Simplifies the code in several places, and you don't need to use DT or
ACPI, it probes just fine anyway you normally add an I2C device.

All we are dropping here is the platform_data way of specifying mic-bias
voltage, which if you are wanting to do that in an out-of-tree board
file, then I'm sure you can locally modify this driver to use your
wanted voltage setting by default.
