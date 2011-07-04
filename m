From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH] ASoC: Ensure we delay long
 enough	for	WM8994 FLL to lock when starting
Date: Mon, 04 Jul 2011 10:13:56 +0900
Message-ID: <032b01cc39e7$a5888d00$f099a700$@com>
References: <1309566922-3177-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<032501cc39dd$489c24d0$d9d46e70$@com>
	<20110704004453.GA1178@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id C6D0424BB0
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 03:14:02 +0200 (CEST)
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
	by mailout3.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LNS00JIZBEPBM30@mailout3.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 04 Jul 2011 10:13:56 +0900 (KST)
Received: from DOSBKIM7301 ([12.23.119.77])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0LNS00HKYBF83V@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 04 Jul 2011 10:13:56 +0900 (KST)
In-reply-to: <20110704004453.GA1178@opensource.wolfsonmicro.com>
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
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, 'Liam Girdwood' <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 04, 2011 at 09:45 AM +0900, Mark Brown wrote:
> > > This delay is very conservative.
> 
> > What's the meaning of conservative?
> 
> In this context it means safe.
> 
> > It means 5ms delay long enough?
> > or at least, FLL lock time should be ensured 5ms?
> 
> Yes, the 5ms should be more than enough time for the FLL to lock - in
> most situations the time taken to do the register writes surrounding
> enabling and then using the FLL are sufficient to cover the startup
> time.

OK, 
I have a one more question.
Is there any checking method for locking FLL?
(ex. Checking register bit for FLL lock)
Just using msleep looks not enough to ensure FLL lock.

Thanks,
SB Kim
