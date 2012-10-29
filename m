From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 5/5] ASoC: sam9g20_wm8731: fix the issue
	for non-DT kernel
Date: Mon, 29 Oct 2012 14:15:55 +0800
Message-ID: <508E1F1B.8040308@atmel.com>
References: <1350901079-18307-1-git-send-email-voice.shen@atmel.com>
 <1350901079-18307-5-git-send-email-voice.shen@atmel.com>
 <20121027221420.GN4564@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 00F142651ED
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 07:16:53 +0100 (CET)
In-Reply-To: <20121027221420.GN4564@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, plagnioj@jcrosoft.com, jm.lin@atmel.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 10/28/2012 6:14, Mark Brown wrote:
> On Mon, Oct 22, 2012 at 06:17:59PM +0800, Bo Shen wrote:
>> When register platform from DAIs, the platform device to PCM no longer
>> needed. So, fix it with this patch
>
> This should be squashed into the change which changes the registeration
> to ensure that we don't get both methods used simultaneously.

OK, I will fix this in next version.

BRs,
Bo Shen
