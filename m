From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: add RT5639 CODEC driver
Date: Tue, 25 Mar 2014 09:33:42 -0600
Message-ID: <5331A1D6.2070109@wwwdotorg.org>
References: <1395627397-6580-1-git-send-email-oder_chiou@realtek.com>
 <20140325133017.GY2269@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A721264F0D
 for <alsa-devel@alsa-project.org>; Tue, 25 Mar 2014 16:33:47 +0100 (CET)
In-Reply-To: <20140325133017.GY2269@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 03/25/2014 07:30 AM, Mark Brown wrote:
> On Mon, Mar 24, 2014 at 10:16:37AM +0800, oder_chiou@realtek.com wrote:
>> From: Oder Chiou <oder_chiou@realtek.com>
>>
>> This patch adds the RT5639 codec driver.
> 
> Looking at the level of code similiarity between this and the rt5640
> driver I can't help but think that these should be supported from a
> single driver - a few quick spot checks of the register map suggests
> that there's at least some overlap.  There will need to be some device
> specific handling but it looks like there's more shared than not shared.
> What are the issues that prevent the code being shared, there may be
> something I've missed?

FWIW, I was informed internally (although this certainly isn't
normative) that RT5639 is RT5640 plus a DSP, and otherwise compatible.
Related, I have a board that has a RT5639 and I'm running the RT5640
driver on it for at least a simple use-case, without issue.
