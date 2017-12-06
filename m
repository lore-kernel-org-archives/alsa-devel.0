From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 18/19] ASoC: tlv320aic31xx: Add
 headphone/headset detection
Date: Wed, 6 Dec 2017 11:47:14 -0600
Message-ID: <8e52d973-2335-e3c5-5e57-15621819cf45@ti.com>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-19-afd@ti.com>
 <20171201134127.2msgmjrfj47ypl3w@sirena.org.uk>
 <b2d9ffa9-3923-cb86-f0ad-cf4f37e56334@ti.com>
 <20171206173215.bitae546h2ibedhz@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx210.ext.ti.com (fllnx210.ext.ti.com [198.47.19.17])
 by alsa0.perex.cz (Postfix) with ESMTP id DFBFA2679FF
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:47:16 +0100 (CET)
In-Reply-To: <20171206173215.bitae546h2ibedhz@sirena.org.uk>
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

On 12/06/2017 11:32 AM, Mark Brown wrote:
> On Wed, Dec 06, 2017 at 11:25:15AM -0600, Andrew F. Davis wrote:
>> On 12/01/2017 07:41 AM, Mark Brown wrote:
> 
>>> This only does half the job, there's no way for anything to specify a
>>> jack here.
> 
>> Other CODECs drivers expose some kind of platform/machine specific
>> function(s) to send the jack definition to the CODEC, we seem to be
> 
> Your driver doesn't do that.
> 

Right, I don't have a specific machine in mind so didn't wan to do it
that way.

>> missing a generic way to report jack information up to the machine layer
>> driver.
> 
> snd_soc_codec_set_jack()
> 

Hmm, this looks close to what I was thinking (I was wanting to go the
other direction and have the codec report what jacks it supports, this
could allow for more than one jack), I'll see if I can make it work.
