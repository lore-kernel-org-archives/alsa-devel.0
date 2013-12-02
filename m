From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap: n810: Convert to
	clk_prepare_enable/clk_disable_unprepare
Date: Mon, 02 Dec 2013 20:12:49 +0000
Message-ID: <529CE9C1.4080907@bitmer.com>
References: <1385827528-32149-1-git-send-email-jarkko.nikula@bitmer.com>
 <20131202111615.GL27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A49E265068
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 19:12:50 +0100 (CET)
In-Reply-To: <20131202111615.GL27568@sirena.org.uk>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/02/2013 11:16 AM, Mark Brown wrote:
>> I'm not queueing this to linux-stable since OMAP2 common clock framework
>> conversion in commit ed1ebc4948fd ("ARM: OMAP2: clock: Convert to common clk")
>> happened before N810 was really usable in mainline and user base for N810 is
>> anyway small. Potential linux-stable candidates are only those after
>> commit 3d3a6d18abc6 ("watchdog: introduce retu_wdt driver").
> 
> That looks like it still means v3.10 and up could use the fix?
> 
Well I kind of fear linux-stable user base for N810 is next to zero. I'd
even insist this forward if just one shows up :-)

-- 
Jarkko
