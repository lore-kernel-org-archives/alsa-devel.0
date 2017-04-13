From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l35: Allow user to configure
	IMON SCALE
Date: Thu, 13 Apr 2017 11:03:48 -0500
Message-ID: <82e5e3ff-a3e0-4b3f-8d7f-fad76e034586@EX3.ad.cirrus.com>
References: <1492098729-30491-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DE392670A1
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 17:59:11 +0200 (CEST)
In-Reply-To: <1492098729-30491-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, brian.austin@cirrus.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, robh+dt@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 13 Apr 2017, Charles Keepax wrote:

> On the chip the IMON signal is a full 24-bits however normally only
> some of the bits will be sent over the bus. The chip provides a field
> to select which bits of the IMON will be sent back, this is the only
> feedback signal that has this feature.
> 
> Add an additional entry to the cirrus,imon device tree property to
> allow the IMON scale parameter to be passed.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
