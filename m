From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 2/3] ASoC: DaVinci: pcm,
 rename variables in prep for ping/pong
Date: Wed, 02 Sep 2009 17:15:08 -0700
Message-ID: <4A9F0A8C.1040509@boundarydevices.com>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>
	<20090902220152.GB4495@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth02.csee.onr.siteprotect.com
	(smtpauth02.csee.onr.siteprotect.com [64.26.60.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 594BA24437
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Sep 2009 02:15:16 +0200 (CEST)
In-Reply-To: <20090902220152.GB4495@sirena.org.uk>
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
Cc: avm@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Aug 31, 2009 at 04:31:44PM -0700, Troy Kisky wrote:
>> Rename variable master_lch to asp_master_lch
>> Rename variable slave_lch to asp_link_lch[0]
>> Rename local variables:
>> 	count to asp_count
>> 	src to asp_src
>> 	dst to asp_dst
> 
> These other two patches are OK but I'll wait for after the merge window
> to apply them partly due to the dependency on the merged tree and also
> since it's very near to the merge window opening and there's already
> been a fair bit of churn and testing with the DaVinci drivers for
> 2.6.32.
> 
> I'll probably also apply the first patch since nobody else seems to care
> one way or another, but I would urge you to look at changing the default
> for the platform data to at most select the workaround only on CPUs that
> have problems with channel swapping - it's going to cause confusion for
> people to have it on by default.
> 
I think the ones without a problem use davinci-mcasp instead of davinci-i2s
but share davinci-pcm. So, I don't know of any machines to exclude in davinci-i2s.
But if someone else knows, speak up.

Thanks
Troy
