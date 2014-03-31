From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: rt5640: Use the platform data for
 DMIC settings
Date: Mon, 31 Mar 2014 10:37:39 -0600
Message-ID: <533999D3.1060905@wwwdotorg.org>
References: <1395974778-4217-1-git-send-email-oder_chiou@realtek.com>
 <53359DDD.7090900@wwwdotorg.org> <20140328234659.GA21628@sirena.org.uk>
 <53398D7D.3010507@wwwdotorg.org> <20140331160508.GU2269@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B2F0265171
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 18:45:17 +0200 (CEST)
In-Reply-To: <20140331160508.GU2269@sirena.org.uk>
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

On 03/31/2014 10:05 AM, Mark Brown wrote:
> On Mon, Mar 31, 2014 at 09:45:01AM -0600, Stephen Warren wrote:
>> On 03/28/2014 05:46 PM, Mark Brown wrote:
> 
>>> The driver has no DT support at all at the minute but if it's being used
>>> on platforms using DT (which of course it is now I think about it - I
>>> just looked for the DT support when reviewing) then yes it should.
> 
>> The driver doesn't have an OF match table (I'll send a patch to fix that
>> soon), but certainly does support DT; see rt5640_parse_dt().
> 
> Oh, dear.  That's not clever and we do need the IDs adding, that's the
> baseline thing needed for DT support.

I really wish we would make up our minds about this.

For I2C (and SPI and perhaps others) the I2C match table works fine as a
replacement for the of_match table. The only issue might be different
manufacturers with the same chip names. If this is a problem, why is
fallback to the I2C match table even allowed any more; we should mandate
that OF matching only works via the OF match table.

When DT was young, Grant tried to require of_match for everything for
completeness, and then I tried enforcing that for reviews, and then
Grant said not to bother with that, so I stopped, and now you're saying
it's required again. I really wish I could get consistency in how this
kind of thing is supposed to work. It's difficult for contributors to
know what to do if reviewers keep flip-flopping over time.
