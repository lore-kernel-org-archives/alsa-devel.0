From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 1/4] ASoC: DaVinci: i2s,
 reduce underruns by combining	into 1 element
Date: Thu, 19 Nov 2009 12:12:15 -0700
Message-ID: <4B05988F.4000804@boundarydevices.com>
References: <1258591794-18416-1-git-send-email-troy.kisky@boundarydevices.com>
	<20091119105054.GD15460@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth01.csee.onr.siteprotect.com
	(smtpauth01.csee.onr.siteprotect.com [64.26.60.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 7650F24149
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 20:12:25 +0100 (CET)
In-Reply-To: <20091119105054.GD15460@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Wed, Nov 18, 2009 at 05:49:51PM -0700, Troy Kisky wrote:
>> Allow the left and right 16 bit samples to be shifted out as 1
>> 32 bit sample.
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> 
> Applied all four (finally!), thanks.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
Thanks for all your help/review with this. I feel much
relief also that it is finally merged. Now, just the
little davinci patches to turn things on remain. That
can wait till this hits Kevin's tree though.


Troy
