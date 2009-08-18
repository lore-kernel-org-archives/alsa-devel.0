From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix data format configuration for
 S3C64XX IISv2
Date: Tue, 18 Aug 2009 15:23:27 +0100
Message-ID: <20090818142327.GA29377@rakim.wolfsonmicro.main>
References: <4A8AA4F3.3010907@samsung.com>
	<20090818130524.GA24620@sirena.org.uk>
	<4A8AB7E5.8090008@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 952B02470C
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 16:23:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A8AB7E5.8090008@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: ben@simtec.co.uk, alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 18, 2009 at 11:17:09PM +0900, Joonyoung Shim wrote:
> On 8/18/2009 10:05 PM, Mark Brown wrote:

> > Can you confirm if you've got the device DMAing usable audio (and if so
> > in what configuration)?

> Do you mean which target board i use?

That's useful, yes, but I was more wondering about the configuration of
the DAI - mostly what's master.
