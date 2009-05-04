From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [ASoC PATCH 1/1] IMote 2 ASoC Support
Date: Mon, 04 May 2009 14:42:27 +0000
Message-ID: <49FEFED3.7090104@cam.ac.uk>
References: <49FEFDC8.2090103@cam.ac.uk> <20090504144119.GO6975@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-1.csi.cam.ac.uk (ppsw-1.csi.cam.ac.uk [131.111.8.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 44A4B103821
	for <alsa-devel@alsa-project.org>;
	Mon,  4 May 2009 16:42:58 +0200 (CEST)
In-Reply-To: <20090504144119.GO6975@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, May 04, 2009 at 02:38:00PM +0000, Jonathan Cameron wrote:
> 
>> +	/* Disable the PLL */
>> +	ret = snd_soc_dai_set_pll(codec_dai, 0, 0, 0);
>> +	if (ret < 0)
> 
> This seems very odd - the PLL is never enabled by your driver but you go
> through and explicitly disable it every time the driver is configured.
Fair point. It's a legacy from trying to test with it set up differently.
I'll clear that out as it's only going to cause confusion.
 
> Other than that this looks fine; you're including more headers than you
> really need but that shouldn't do any harm.
Oops, will clean them up.

Thanks,

Jonathan
