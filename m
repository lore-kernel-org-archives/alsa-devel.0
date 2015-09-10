From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm8960: correct gain value for
 input PGA and add microphone PGA
Date: Thu, 10 Sep 2015 09:21:22 +0100
Message-ID: <20150910082122.GB3483@edi-sw-dsktp001.ad.cirrus.com>
References: <22ae1784eb84bf45b23bb7095b7dea8a116c0c2c.1441798038.git.zidan.wang@freescale.com>
 <4aff33dcdc441f7c7a2612fef80c099aafec1e1d.1441798038.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AC2F265864
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2015 10:21:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4aff33dcdc441f7c7a2612fef80c099aafec1e1d.1441798038.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 09, 2015 at 07:29:11PM +0800, Zidan Wang wrote:
> The input PGAs have a gain range from -17.25dB to +30dB in 0.75dB steps.
> 
> The boost stage can provide additional gain. For line inputs, -12dB to
> +6dB gain is available on the boost mixer. For micphone inputs, it can
> provide up to +29dB additional gain from the microphone PGA.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
