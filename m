From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/2]ASoC: multi-component - Fix S5P	compile
 error
Date: Mon, 19 Jul 2010 22:17:58 +0900
Message-ID: <4C445086.3020507@samsung.com>
References: <4C4448FD.5010600@samsung.com>
	<20100719130439.GB7002@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 862EC24487
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 15:18:02 +0200 (CEST)
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L5T007OA3LZV6D0@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 19 Jul 2010 22:17:59 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L5T00EA73LZCE@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 19 Jul 2010 22:17:59 +0900 (KST)
In-reply-to: <20100719130439.GB7002@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Jul 19, 2010 at 09:45:49PM +0900, Chanwoo Choi wrote:
>> This patch fix compile error on using I2S and WM8994 common code.
> 
> This looks to be two completely separate issues and should have been
> sent as two separate patches, especially this one:
> 
Ok, I will do.

>> -#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413)
>> +#if defined(CONFIG_CPU_S3C2412) || defined(CONFIG_CPU_S3C2413) \
>> +	|| defined(CONFIG_CPU_S5PV210)
>>  #define S3C_IIS_V2_SUPPORTED
> 
> This is implmenting support for a new CPU, not fixing compile errors,
> and so the commit message is very misleading.
Ok, I will modify the commit message.

Thank you,
Chanwoo Choi
