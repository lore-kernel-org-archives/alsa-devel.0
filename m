From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 0/2] ASoC: tfa9879: cleanup bindings and
 claim maintainership
Date: Mon, 11 Dec 2017 17:45:57 +0100
Message-ID: <04c1a8f1-3e0f-090b-ad75-5baa0ac280d5@axentia.se>
References: <20171211142615.11440-1-peda@axentia.se>
 <20171211163548.GE9854@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30093.outbound.protection.outlook.com [40.107.3.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DF9F9266EDD
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 17:46:02 +0100 (CET)
In-Reply-To: <20171211163548.GE9854@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 2017-12-11 17:35, Mark Brown wrote:
> On Mon, Dec 11, 2017 at 03:26:13PM +0100, Peter Rosin wrote:
>> Hi!
>>
>> Device tree bindings where added for the tfa9879 along with improved
>> support for them in the driver some time ago. All behind my back.
>> This cleans things up and properly adds me as maintainer of the new
>> bindings.
>>
>> Cheers,
>> Peter
>>
>> Peter Rosin (2):
>>   ASoC: tfa9879: clean up bindings
>>   ASoC: tfa9879: add DT bindings to MAINTAINERS
> 
> The actual patch series doesn't appear to have arrived in my inbox?

That's weird, because I sent it all with git send-email and the
patches did reach lkml [1] and patchwork has them too [2][3]. I
have also verified that you were indeed on the Cc list, and I have
not seen any errors (yet). I'm not sure if it's going to matter if
I send them again, or if it is fastest/simplest for you to get them
from patchwork?

Cheers,
Peter

[1] https://lkml.org/lkml/2017/12/11/374
[2] https://patchwork.kernel.org/patch/10105305/
[3] https://patchwork.kernel.org/patch/10105307/
