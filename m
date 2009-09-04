From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: AK4671: add ak4671 codec driver
Date: Fri, 4 Sep 2009 16:40:19 +0100
Message-ID: <20090904154019.GD1576@sirena.org.uk>
References: <4A9FB5C7.5060607@samsung.com>
	<20090903140236.GB1406@rakim.wolfsonmicro.main>
	<4AA06DB5.6060107@samsung.com>
	<20090904101859.GA17522@rakim.wolfsonmicro.main>
	<4e1455be0909040837i3f8906c9w8d1d4436dee46897@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B6928244F2
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Sep 2009 17:40:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4e1455be0909040837i3f8906c9w8d1d4436dee46897@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <dofmind@gmail.com>
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 05, 2009 at 12:37:47AM +0900, Joonyoung Shim wrote:

> Right, so i will use SND_SOC_DAPM_DAC_E and SND_SOC_DAPM_ADC_E.
> This event handler desides the setting of PLL, then PLL can be
> configured regardless the bypass path.

That sounds good - a supply might be even easier (since the core will
then reference count all the DACs and ADCs) but either is fine.
