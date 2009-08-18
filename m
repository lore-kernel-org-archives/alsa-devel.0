From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] ASoC: Fix data format configuration for
 S3C64XX IISv2
Date: Tue, 18 Aug 2009 23:54:35 +0900
Message-ID: <4A8AC0AB.9070706@samsung.com>
References: <4A8AA4F3.3010907@samsung.com>
	<20090818130524.GA24620@sirena.org.uk> <4A8AB7E5.8090008@samsung.com>
	<20090818142327.GA29377@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 8531724721
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 16:54:38 +0200 (CEST)
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KOK00C96UQZWH@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 18 Aug 2009 23:54:35 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KOK001CGUQZPK@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 18 Aug 2009 23:54:35 +0900 (KST)
In-reply-to: <20090818142327.GA29377@rakim.wolfsonmicro.main>
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
Cc: ben@simtec.co.uk, alsa-devel@alsa-project.org, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On 8/18/2009 11:23 PM, Mark Brown wrote:
> On Tue, Aug 18, 2009 at 11:17:09PM +0900, Joonyoung Shim wrote:
>> On 8/18/2009 10:05 PM, Mark Brown wrote:
> 
>>> Can you confirm if you've got the device DMAing usable audio (and if so
>>> in what configuration)?
> 
>> Do you mean which target board i use?
> 
> That's useful, yes, but I was more wondering about the configuration of
> the DAI - mostly what's master.
> 

I use the configuration that the DAI of codec is master and the DAI of
cpu is slave.
