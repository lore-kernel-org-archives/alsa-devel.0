From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: ASoC updates for 2.6.33
Date: Wed, 21 Oct 2009 14:20:04 +0900
Message-ID: <4ADE9A04.3080702@samsung.com>
References: <20091015144039.GB24756@rakim.wolfsonmicro.main>
	<3c17e3570910200813v6ed8620je1e16fff306a00a5@mail.gmail.com>
	<20091020151713.GA5945@rakim.wolfsonmicro.main>
	<3c17e3570910202200u7c7d9672s194c6fbf7142effa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id E6E7424388
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Oct 2009 07:20:08 +0200 (CEST)
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KRU001RMMTGSK@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 21 Oct 2009 14:20:04 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KRU002U3MTGBA@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 21 Oct 2009 14:20:04 +0900 (KST)
In-reply-to: <3c17e3570910202200u7c7d9672s194c6fbf7142effa@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 10/21/2009 2:00 PM, Barry Song wrote:
> On Tue, Oct 20, 2009 at 11:17 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> On Tue, Oct 20, 2009 at 11:13:19PM +0800, Barry Song wrote:
>>
>> No new text?
> :-)
> Just feel strange why s3c64xx-i2s.c/.h for s3c64xx soc are placed into
> s3c24xx directory since s3c24xx can't cover s3c64xx.
> There are 3 plat-xx in arch/arm:
> plat-s3c/     plat-s3c24xx/ plat-s3c64xx/
> and several mach-s3cxx in arch/arm:
> mach-s3c2400/ mach-s3c2410/ mach-s3c2412/ mach-s3c2440/ mach-s3c2442/
> mach-s3c6410/...
> All these show those SoCs are equal.
> 
> Is it the time to rename sound/soc/s3c24xx/ to sound/soc/s3c or move
> s3c64xx stuff to sound/soc/s3c64xx/?
> 

I think there is no need to move the directory because it is just the 
naming problem. Also it can be added other the samsung cpus like s5pc1xx 
in s3c24xx directory, so we will need the proper other name instead of
s3c24xx.
