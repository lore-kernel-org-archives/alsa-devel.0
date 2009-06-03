From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [PATCH 1/5] ASoC codec: SSM2602:
 remove	unsupported sample rates
Date: Wed, 03 Jun 2009 14:11:36 +0200
Message-ID: <4A266878.2070206@gmail.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<20090603102605.GB11507@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id A007524335
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 14:11:20 +0200 (CEST)
Received: by ewy23 with SMTP id 23so9855301ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 05:11:20 -0700 (PDT)
In-Reply-To: <20090603102605.GB11507@sirena.org.uk>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Jun 02, 2009 at 12:18:53AM -0400, Mike Frysinger wrote:
>> From: Cliff Cai <cliff.cai@analog.com>
>>
>> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
>> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> 
> Applied, thanks.

These samples rates are supported by the codec, updating coeff_div would be a better move.

-- 
Karl
