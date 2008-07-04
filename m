From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec driver
Date: Fri, 4 Jul 2008 17:44:09 -0600
Message-ID: <fa686aa40807041644r2a71181q2bc522ec988820ab@mail.gmail.com>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
	<20080704204927.GC20719@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BFE71037FD
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Jul 2008 01:44:11 +0200 (CEST)
Received: by ag-out-0708.google.com with SMTP id 22so8040631agd.8
	for <alsa-devel@alsa-project.org>; Fri, 04 Jul 2008 16:44:09 -0700 (PDT)
In-Reply-To: <20080704204927.GC20719@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 4, 2008 at 2:49 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 01, 2008 at 05:53:40PM -0600, Grant Likely wrote:
>> +     /* Tell the of_soc helper about this codec */
>> +     of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai,
>> +                               spi->dev.archdata.of_node);
>
> Does this need to be ifdefed out if of_snd_soc_register_codec() is not
> in use or is the function stubbed out if it's not in use?  Stubbing it
> out would be cleaner.

yeah, probably.  This is a stop-gap measure anyway until ASoC v2 is merged.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
