From: sugar <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH 1/2] ASoC: rockchip: i2s: add 8 channels
 capture and lrck-mode support
Date: Thu, 8 Oct 2015 11:59:44 +0800
Message-ID: <5615EA30.8000205@rock-chips.com>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
 <20150923162433.GQ30445@sirena.org.uk> <5608F74C.3000104@rock-chips.com>
 <20150930184655.GX15635@sirena.org.uk> <5614D162.3020500@rock-chips.com>
 <F2F204F7-F5A8-4152-BF1D-454EB3E35F34@crome.org>
 <5615CB39.1060208@rock-chips.com>
 <35DAC0DA-9141-4D6B-A065-4D0FE340E5D0@crome.org>
 <5615D898.1090101@rock-chips.com>
 <59C359E6-1944-4093-B008-1FB9CD695484@crome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F49E26155D
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 05:59:54 +0200 (CEST)
In-Reply-To: <59C359E6-1944-4093-B008-1FB9CD695484@crome.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Only the new design support 8 channels capture now, the others support 2 
channels capture. but all of them support 32bits/sample.

On 10/8/2015 11:19, Caleb Crome wrote:
>   That will work!  Do all your cortex-a parts support that?
>
> Thanks, Caleb
> Sent from my iPhone
