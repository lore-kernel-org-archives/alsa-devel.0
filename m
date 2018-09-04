From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off
	setting
Date: Tue, 4 Sep 2018 08:55:06 -0500
Message-ID: <701a066c-33e1-4476-7403-fdb9a3c366d8@ti.com>
References: <20180831180507.28867-1-afd@ti.com>
 <20180903112656.GF10302@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 by alsa0.perex.cz (Postfix) with ESMTP id 796482678DD
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 15:55:09 +0200 (CEST)
In-Reply-To: <20180903112656.GF10302@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 09/03/2018 06:26 AM, Mark Brown wrote:
> On Fri, Aug 31, 2018 at 01:05:07PM -0500, Andrew F. Davis wrote:
>> Leaving microphone bias off is a valid setting and even used in the DT
>> binding document example. Add this setting here and document the same.
>> Although it may not make much sense to enable a microphone here without
>> any bias, it is a valid setting that can be chosen by DT and may be
>> needed for some boards.
> 
> If we really want to pay attention to something setting this up we'd
> need to completely remove the widget - what the code is doing at the
> minute is setting the voltage that the bias will go to when enabled,
> there's still a widget for turning it on and off.  There's some chance
> that this will break existing boards.
> 

Turning on bias is controlled separately, automatically in user-space in
many cases, not based on the board. The DT needs to have a way to state
that 0v is the needed bias on this board, without this you can not set
0v bias and 2v is chosen by default (which is IMHO should be 0v but that
would change existing behavior so I won't touch that).
