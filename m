From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/3] ASoC: alc5632: add an of_match table
Date: Mon, 31 Mar 2014 13:47:04 -0600
Message-ID: <5339C638.5030303@wwwdotorg.org>
References: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
 <20140331192349.GA3431@mithrandir>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 061B5265353
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 21:55:17 +0200 (CEST)
In-Reply-To: <20140331192349.GA3431@mithrandir>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/31/2014 01:23 PM, Thierry Reding wrote:
> On Mon, Mar 31, 2014 at 12:38:16PM -0600, Stephen Warren wrote:
> [...]
>> diff --git a/sound/soc/codecs/alc5632.c b/sound/soc/codecs/alc5632.c
> [...]
>> +static const struct of_device_id alc5632_of_match[] = {
>> +	{ .compatible = "realtek,alc5632", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, alc5632_of_match);
> 
> Doesn't this need #ifdef protection to prevent warnings about this being
> unused for !OF?

What I really meant to do was reference these tables directly rather
than using of_match_ptr().

There seems to be a mix of ifdef'ing the table and using of_match_ptr()
vs. the other way around in ASoC. Mark, do you have a preference which
way to go?
