From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm8741: Fix setting BCLK and LRCLK
 polarity
Date: Fri, 3 Nov 2017 11:18:31 +0000
Message-ID: <20171103111831.eemy5bsocllkd4kt@localhost.localdomain>
References: <1509628982-9767-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 852C1266A0C
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 12:18:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1509628982-9767-1-git-send-email-sergej@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 02, 2017 at 02:23:02PM +0100, Sergej Sawazki wrote:
> After checking the code and the datasheet, it seems like we are handling
> the clock inversion (SND_SOC_DAIFMT_NB_IF and SND_SOC_DAIFMT_IB_IF) not
> correctly.
> 
> >From the datasheet (Table 58):
> R5 Format Control, BITS[5:4], [BCP:LRP]:
>   (0) 00 =  normal   BCLK, normal   LRCLK
>   (1) 01 =  normal   BCLK, inverted LRCLK <-- Fix this
>   (2) 10 =  inverted BCLK, normal   LRCLK
>   (3) 11 =  inverted BCLK, inverted LRCLK <-- Fix this
> 
> Signed-off-by: Sergej Sawazki <sergej@taudac.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charle
