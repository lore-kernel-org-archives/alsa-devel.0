From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH v4 4/4] ASoC: SAMSUNG: Add I2S0 internal
 dma driver
Date: Tue, 05 Jul 2011 11:43:12 +0900
Message-ID: <036701cc3abd$48665e00$d9331a00$@com>
References: <1309484927-3950-1-git-send-email-sbkim73@samsung.com>
	<1309484927-3950-2-git-send-email-sbkim73@samsung.com>
	<4E0DDEBB.1090805@ti.com>
	<20110701161201.GB23784@opensource.wolfsonmicro.com>
	<4E118B91.70702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 95173244F4
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 04:43:18 +0200 (CEST)
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LNU0020AA7STAH0@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 05 Jul 2011 11:43:12 +0900 (KST)
Received: from DOSBKIM7301 ([12.23.119.77])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0LNU00MTJA806B@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 05 Jul 2011 11:43:12 +0900 (KST)
In-reply-to: <4E118B91.70702@ti.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Liam Girdwood' <lrg@ti.com>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, jassisinghbrar@gmail.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi,
On Monday, July 04, 2011 6:45 PM, Liam Girdwood :
> On 01/07/11 17:12, Mark Brown wrote:
> > On Fri, Jul 01, 2011 at 03:50:35PM +0100, Liam Girdwood wrote:
> >> On 01/07/11 02:48, Sangbeom Kim wrote:
> >
> >>> +       if (res >= snd_pcm_lib_buffer_bytes(substream))
> >>> +               res = 0;
> >
> >> Is it likely that your DMA pointer will go beyond the buffer size ?
> >> If this happens then I suspect you have something wrong in your DMA
> config ?
> >
> > This is actually quite common - the normal case where it happens is that
> > the DMA controller reports one location beyond the last location it read
> > so when it hits the end of the buffer you see it report just beyond the
> > end of the buffer (which is hit quite often since this tends to also
> > generate an interrupt which causes a pointer() query).  Replacing the
> > check with an == should be enough for that, though.
> 
> I agree, but I think he should really also have a comment here stating
> this condition if it exists.

You are right. DMA pointer can not be beyond buffer size.
But This condition is just added for handling end of buffer.
As mark said, an == condition seems more preferable.

Thanks 
SB Kim
