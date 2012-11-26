From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 3/3] ASoC: atmel-pcm: add dma support
Date: Mon, 26 Nov 2012 10:04:28 +0800
Message-ID: <50B2CE2C.4080700@atmel.com>
References: <1353651257-2476-1-git-send-email-voice.shen@atmel.com>
 <1353651257-2476-4-git-send-email-voice.shen@atmel.com>
 <20121123142747.GP4529@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ABC42615EB
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:05:33 +0100 (CET)
In-Reply-To: <20121123142747.GP4529@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, linux-sound@vger.kernel.org, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 11/23/2012 22:27, Mark Brown wrote:
> On Fri, Nov 23, 2012 at 02:14:17PM +0800, Bo Shen wrote:
>> Add dmaengine specific routines and replace PDC ones in
>> pcm_ops if appropriate.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> [voice.shen@atmel.com: adapt to soc dmaengine framework]
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>
> Why is this not just two separate drivers?

I am not sure I got your means.
As I understand, I should keep the driver using pdc and won't touch it.
And create new a new driver using dma, am I right?

or else, ...?

Best Regards
Bo Shen
