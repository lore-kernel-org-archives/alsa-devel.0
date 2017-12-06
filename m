From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 18/19] ASoC: tlv320aic31xx: Add
 headphone/headset detection
Date: Wed, 6 Dec 2017 11:25:15 -0600
Message-ID: <b2d9ffa9-3923-cb86-f0ad-cf4f37e56334@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-19-afd@ti.com>
 <20171201134127.2msgmjrfj47ypl3w@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ADE72679C7
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:25:16 +0100 (CET)
In-Reply-To: <20171201134127.2msgmjrfj47ypl3w@sirena.org.uk>
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

On 12/01/2017 07:41 AM, Mark Brown wrote:
> On Wed, Nov 29, 2017 at 03:32:59PM -0600, Andrew F. Davis wrote:
>> This device can detect the insertion/removal of headphones and headsets.
>> Enable reporting this status by enabling this interrupt and forwarding
>> this to upper-layers if a jack has been defined.
>>
>> This jack definition and the resulting operation from a jack detection
>> event must currently be defined by sound card platform code until CODEC
>> outputs to jack mappings can be defined generically.
> 
> This only does half the job, there's no way for anything to specify a
> jack here.
> 

Other CODECs drivers expose some kind of platform/machine specific
function(s) to send the jack definition to the CODEC, we seem to be
missing a generic way to report jack information up to the machine layer
driver.

Perhaps a struct with a jack enable/disable and call-back functions
could be created when registering the codec/platform component driver?
Then machines can hook to this as they need?
