From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v5] ASoC: Apply msbits constraint for
 sample size bigger than the msbits
Date: Wed, 18 Jan 2012 17:43:28 +0100
Message-ID: <4F16F6B0.7030707@ti.com>
References: <1326899114-26979-1-git-send-email-peter.ujfalusi@ti.com>
	<20120118152905.GP8732@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75]) by alsa0.perex.cz (Postfix) with ESMTP id E89AC24670
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 17:43:46 +0100 (CET)
Received: by mail-yw0-f54.google.com with SMTP id s35so1572183yhf.27
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 08:43:30 -0800 (PST)
In-Reply-To: <20120118152905.GP8732@opensource.wolfsonmicro.com>
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

On 01/18/2012 04:29 PM, Mark Brown wrote:
> I'm not sure this is actually a legibility improvement, if anything it's
> probably less clear than the original as now the setup of the loop is
> spread even further around the function.

Would it make it clearer if I set i to 0 right before the while?

>> Most of the drivers require 24/32 configuration, so not point of looping
>> for smaller sample sizes.
> =

> Performance isn't really a concern in this path unless we do something
> totally insane.  Thinking time on the part of the reader needs to be
> considered too...

Sure it is not a concern. These small 'Performance isn't really a
concern in this path' at the end ads up that we need faster CPUs to have
the same perceived perfomrance.

-- =

P=E9ter
