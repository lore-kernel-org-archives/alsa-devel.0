From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] ASoC: Fix data format configuration for
 S3C64XX IISv2
Date: Tue, 18 Aug 2009 23:17:09 +0900
Message-ID: <4A8AB7E5.8090008@samsung.com>
References: <4A8AA4F3.3010907@samsung.com>
	<20090818130524.GA24620@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id DD88124706
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 16:17:12 +0200 (CEST)
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KOK00DKAT0LI5@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 18 Aug 2009 23:17:09 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KOK00K6BT0LK7@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 18 Aug 2009 23:17:09 +0900 (KST)
In-reply-to: <20090818130524.GA24620@sirena.org.uk>
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

On 8/18/2009 10:05 PM, Mark Brown wrote:
> On Tue, Aug 18, 2009 at 09:56:19PM +0900, Joonyoung Shim wrote:
>> The data format configuration for S3C64xx IISv2 was hardcoded for IISMOD
>> register. This patch changes to the defined values it.
> 
>> And instead of bits 9 and 10 of IISMOD we should clear bits 13 and 14.
> 
> Thanks - there's quite a few problems with this area.
> 
> Can you confirm if you've got the device DMAing usable audio (and if so
> in what configuration)?
> 

Do you mean which target board i use?

I have the NCP target board using S3C6410 arm cpu. The NCP board has the
LM49350 audio codec chip, but this codec driver doesn't make ready to
post yet. The codec chip of the NCP is connected to the I2S0 of platform
for playback and capture.
