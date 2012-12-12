From: MR Swami Reddy <MR.Swami.Reddy@ti.com>
Subject: Re: [PATCH v2] ASoC: lm49453: Fix adc,
 mic and sidetone volume ranges
Date: Wed, 12 Dec 2012 12:06:29 +0530
Message-ID: <50C825ED.2010903@ti.com>
References: <1354879810-6452-1-git-send-email-MR.Swami.Reddy@ti.com>	
 <1355254851.7077.97.camel@vkoul-udesk3>
 <1355264914.7077.100.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id B597B2617AF
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 07:18:46 +0100 (CET)
In-Reply-To: <1355264914.7077.100.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: "Deshpande A, Vishwas" <Vishwas.A.Deshpande@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Girdwood, Liam" <lrg@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 12 December 2012 03:58 AM, Vinod Koul wrote:
> On Tue, 2012-12-11 at 11:40 -0800, Vinod Koul wrote:
>>> +static const DECLARE_TLV_DB_SCALE(mic_tlv, 0, 200, 1);
>> step is NOT 2dB but 10dB, and where do we have mute here
> Sorry I mis read data sheet, this is fine. We have 2dB steps
>
> I have tested both of these so:
> Tested-by: Vinod Koul <vinod.koul@intel.com>

Thanks for validation.

> Only mute bits need to be fixed here and we should be good
>

LM49453 codec has a separate bit for MUTE operation.

Thanks
Swami
