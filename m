From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 1/3] ASoC: cs35l35: Improve power down time
Date: Thu, 6 Apr 2017 09:12:18 -0500
Message-ID: <737e98d4-2937-4a92-a967-aff80a4ba71b@EX3.ad.cirrus.com>
References: <1491483134-28079-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id A40BB267283
 for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2017 16:07:52 +0200 (CEST)
In-Reply-To: <1491483134-28079-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

On Thu, 6 Apr 2017, Charles Keepax wrote:

> Shorten the time it takes to power down the amp by disabling the volume
> ramp whilst doing the final shutdown. The driver has already muted the
> amplifier at this stage so doing the volume ramp serves no purpose.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
For the series

Acked-by: Brian Austin <brian.austin@cirrus.com>
