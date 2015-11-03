From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8960: Fix the Input PGA Mute switch
Date: Tue, 3 Nov 2015 09:44:01 +0000
Message-ID: <20151103094401.GA2549@ck-lbox>
References: <1446516392-68653-1-git-send-email-furmuwon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A913226055C
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 10:59:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1446516392-68653-1-git-send-email-furmuwon@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: JongHo Kim <furmuwon@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 03, 2015 at 11:06:32AM +0900, JongHo Kim wrote:
> Change the xinvert value from 0 to 1 on the "Capture Switch" control
> WM8960 datasheet is shown as follows:
> Bit 7 at 00h and 01h register address
> 1 : Enable Mute, 0 : Disable Mute
> 
> Signed-off-by: JongHo Kim <furmuwon@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
