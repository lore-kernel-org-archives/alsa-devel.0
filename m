From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: rt5640: Use the platform data for
 DMIC settings
Date: Mon, 31 Mar 2014 09:45:01 -0600
Message-ID: <53398D7D.3010507@wwwdotorg.org>
References: <1395974778-4217-1-git-send-email-oder_chiou@realtek.com>
 <53359DDD.7090900@wwwdotorg.org> <20140328234659.GA21628@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id B514726517C
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 17:45:06 +0200 (CEST)
In-Reply-To: <20140328234659.GA21628@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 03/28/2014 05:46 PM, Mark Brown wrote:
> On Fri, Mar 28, 2014 at 10:05:49AM -0600, Stephen Warren wrote:
>> On 03/27/2014 08:46 PM, Oder Chiou wrote:
> 
>>> The patch uses the platform data for DMIC settings.
> 
>> Shouldn't this also support parsing the same information from device tree?
> 
> The driver has no DT support at all at the minute but if it's being used
> on platforms using DT (which of course it is now I think about it - I
> just looked for the DT support when reviewing) then yes it should.

The driver doesn't have an OF match table (I'll send a patch to fix that
soon), but certainly does support DT; see rt5640_parse_dt().
