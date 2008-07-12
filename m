From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26 codec driver
Date: Sat, 12 Jul 2008 12:13:51 -0600
Message-ID: <fa686aa40807121113t3e713737v2fab74b066e1a73e@mail.gmail.com>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
	<1214995713.4882.54.camel@localhost.localdomain>
	<20080712060018.GB23213@secretlab.ca>
	<20080712173609.GA6523@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 441F1103812
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Jul 2008 20:13:53 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id d31so776881and.80
	for <alsa-devel@alsa-project.org>; Sat, 12 Jul 2008 11:13:51 -0700 (PDT)
In-Reply-To: <20080712173609.GA6523@sirena.org.uk>
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
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 12, 2008 at 11:36 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> The power configuration should be fixed, though.  Normally drivers
> either fully implement DAPM (including set_bias_level()) or power
> everything in the codec up when the driver is loaded.  At the minute
> what the driver is doing appears to be powering the codec up in both
> _hw_params() and _probe() but never powering anything down - if that is
> the case then probably all you need to do is remove the extra power up
> from hw_params(), giving you the simple option.

Okay, cool.  I'll do this for the time being then.

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
