From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [Resend PATCH v6 1/4] pinctrl: atmel-ssc: add
	pinctrl support
Date: Mon, 03 Dec 2012 13:56:42 +0800
Message-ID: <50BC3F1A.1030808@atmel.com>
References: <1353464229-20846-1-git-send-email-voice.shen@atmel.com>
 <20121121022441.GJ4673@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id A49532615D1
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2012 06:57:50 +0100 (CET)
In-Reply-To: <20121121022441.GJ4673@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: plagnioj@jcrosoft.com
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi J,

On 11/21/2012 10:24, Mark Brown wrote:
> On Wed, Nov 21, 2012 at 10:17:09AM +0800, Bo Shen wrote:
>> Add pinctrl support for atmel ssc peripheral
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>

Ping?
Will you pick up this patch, if not, the linux-next (20121130) build 
will report following error:
---<8---
ERROR (phandle_references): Reference to non-existent node or label 
"pinctrl_ssc0_tx
--->8---

Best Regards,
Bo Shen
