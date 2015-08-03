From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 00/42] ASoC: Replace users of
	TLV_DB_RANGE_HEAD
Date: Mon, 3 Aug 2015 07:03:26 -0500
Message-ID: <alpine.DEB.2.10.1508030702330.27423@heelroid>
References: <1438528810-23498-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077474.ppops.net (mx0b-001ae601.pphosted.com [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id CFD36260612
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 14:02:51 +0200 (CEST)
In-Reply-To: <1438528810-23498-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, Anish Kumar <yesanishhere@gmail.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 2 Aug 2015, Lars-Peter Clausen wrote:

> Usage of TLV_DB_RANGE_HEAD() is deprecated in favor of
> DECLARE_TLV_DB_RANGE(). The reason for this is that the former requires to
> specify the number of items inside the range container while the later is
> able to calculate this automatically and hence leaves less room for error.
> 
> While non of the current users of TLV_DB_RANGE_HEAD() gets it wrong it
> still makes sense to clean this up since existing drivers are often used as
> templates for new drivers. As an added bonus the code is also slightly
> shorter.
> 
> There are also a few drivers which use TLV_DB_RANGE_HEAD() with only a
> single sub-item. Those are updated to not use a range container at all
> since it is not necessary.
For the Cirrus CODECS

Thanks,
Acked-by: Brian Austin <brian.austin@cirrus.com>
