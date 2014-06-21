From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH] ASoC: Fix SOC_DOUBLE_R_SX_TLV volume mixer
	arguments
Date: Sat, 21 Jun 2014 11:58:17 +0000
Message-ID: <EFACFFC4-D1CC-4B63-816F-A0C95ED2CA69@cirrus.com>
References: <1403294418-6743-1-git-send-email-ryan.harvey@cirrus.com>
 <alpine.DEB.2.02.1406201503070.25941@heelrod>,
 <20140621102444.GP5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
 by alsa0.perex.cz (Postfix) with ESMTP id 19374265141
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 13:58:34 +0200 (CEST)
In-Reply-To: <20140621102444.GP5099@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Harvey, Ryan" <Ryan.Harvey@cirrus.com>
List-Id: alsa-devel@alsa-project.org



> On Jun 21, 2014, at 5:25, "Mark Brown" <broonie@kernel.org> wrote:
> 
>> On Fri, Jun 20, 2014 at 03:03:58PM -0500, Brian Austin wrote:
>>> On Fri, 20 Jun 2014, Ryan Harvey wrote:
>>> 
>>> Remove unnecessary bit shifts. Correct min value to match datasheet. #Steps equals number of steps between min and max.
>>> 
>>> This patch depends on 8f0367b53d887726b1f4b0b39e0f09b7cca2f79f
>>> ASoC: cs42l56: Fix stereo channel register assignment for Headphone and
>>> LineOut volume mixers.
>>> 
>>> Signed-off-by: Ryan Harvey <ryan.harvey@cirrus.com>
>>> ---
>> Acked-by: Brian Austin <brian.austin@cirrus.com>
> 
> I don't seem to have any of these patches from Ryan - don't know what's
> going on there, the message looks like it should be going to me, but
> without the patches I can't apply them (and they typos in the list
> address means I couldn't pick up the list copy).

I have an idea what's wrong.. IT
I'll get him to resend after weekend.

-Brian 
