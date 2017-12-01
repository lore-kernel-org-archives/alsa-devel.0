From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 14/19] ASoC: tlv320aic31xx: Remove
 regulator notification handling
Date: Fri, 1 Dec 2017 09:01:19 -0600
Message-ID: <216ac36e-772a-0919-67cc-86589d3916fc@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-15-afd@ti.com>
 <20171201133604.6v3ychahwvlaygxi@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 19AC8267029
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 16:01:20 +0100 (CET)
In-Reply-To: <20171201133604.6v3ychahwvlaygxi@sirena.org.uk>
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

On 12/01/2017 07:36 AM, Mark Brown wrote:
> On Wed, Nov 29, 2017 at 03:32:55PM -0600, Andrew F. Davis wrote:
>> A regulator being forcefully disabled is a catastrophic event that
>> should never happen to most devices, especially not sound CODECs.
> 
> That's not what the disable notification handling is for.  It's there so
> that the driver can skip having to reinitialize the device if other
> constraints mean the power doesn't actually get turned off when it
> disables the regualtors.  It's nothing to do with forced disables.
> 

Looking into the call sites, at least in this case the only time this
notification will be called, outside the normal enable/disable paths
(which do the same thing here: turn on regmap cache only mode and mark
it dirty), will be during a force disable scenario.
