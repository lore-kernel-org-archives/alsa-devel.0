From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8960: add DAC mono mix kcontrol
Date: Fri, 8 Jan 2016 11:57:11 +0000
Message-ID: <20160108115711.GD1490@localhost.localdomain>
References: <3d52a0f560ed565ca81da1d041744e1814d7b561.1452243300.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 9682026040E
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 12:57:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3d52a0f560ed565ca81da1d041744e1814d7b561.1452243300.git.zidan.wang@freescale.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 08, 2016 at 04:57:01PM +0800, Zidan Wang wrote:
> In normal operation, the left and right channel digital audio data is
> converted to analogue in two separate DACs. There is a mono-mix mode
> where the two audio channels are mixed together digitally and then
> converted to analogue using only one DAC, while the other DAC is
> switched off. The mono-mix signal can be selected to appear on both
> analogue output channels. The mono mix is automatically attenuated by
> 6dB to prevent clipping.
> 
> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
