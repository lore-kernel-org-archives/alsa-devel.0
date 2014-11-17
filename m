From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 3/3] ASoC: rt5670: add codec irq support
Date: Mon, 17 Nov 2014 09:22:34 +0100
Message-ID: <5469B04A.8070305@metafoo.de>
References: <1416209243-4879-1-git-send-email-bardliao@realtek.com>
 <1416209243-4879-3-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AE402614E2
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 09:26:37 +0100 (CET)
In-Reply-To: <1416209243-4879-3-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, mengdong.lin@intel.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 11/17/2014 08:27 AM, Bard Liao wrote:
> This patch provide the jack function of rt5670. We use a irq pin to notice the jack event. rt5670_irq_detection will determine which status should be reported.
> We can get gpio information from gpio number or gpiod_dev. That's why we define both on platform data.

New code should only use the descriptor GPIO API. The old way of passing 
GPIO numbers as platform data is considered deprecated and will be removed 
once there are no drivers left using it.

- Lars
