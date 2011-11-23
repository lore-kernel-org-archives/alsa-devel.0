From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Constify snd_soc_dai_ops structs
Date: Wed, 23 Nov 2011 14:01:38 +0100
Message-ID: <4ECCEEB2.6050407@metafoo.de>
References: <1322044840-32709-1-git-send-email-lars@metafoo.de>
	<20111123104728.GL4332@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-166.synserver.de
	[212.40.185.166])
	by alsa0.perex.cz (Postfix) with ESMTP id E41CB103B08
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 14:00:47 +0100 (CET)
In-Reply-To: <20111123104728.GL4332@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 11/23/2011 11:47 AM, Mark Brown wrote:
> On Wed, Nov 23, 2011 at 11:40:40AM +0100, Lars-Peter Clausen wrote:
>> Commit 1ee46ebd("ASoC: Make the DAI ops constant in the DAI structure")
>> introduced the possibility to have constant DAI ops structures, yet this is
>> barley used in both existing drivers and also new drivers being submitted,
>> although none of them modifies its DAI ops structure. The later is not
>> surprising since existing drivers are often used as templates for new drivers.
>> So this patch just constifies all existing snd_soc_dai_ops structs to eliminate
>> the issue altogether.
> 
> Applied, thanks.

Argh, looks like I have to work a bit more on my coccinelle skills, I
introduced a few 'const const struct snd_soc_dai_ops' in this patch, which I
overlooked, since this seems to be legal C. Will send a followup cleanup patch.
