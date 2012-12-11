From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: lm49453: Fix adc,
 mic and sidetone volume ranges
Date: Tue, 11 Dec 2012 14:28:34 -0800
Message-ID: <1355264914.7077.100.camel@vkoul-udesk3>
References: <1354879810-6452-1-git-send-email-MR.Swami.Reddy@ti.com>
 <1355254851.7077.97.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A244261622
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2012 23:49:42 +0100 (CET)
In-Reply-To: <1355254851.7077.97.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: MR.Swami.Reddy@ti.com
Cc: vishwas.a.deshpande@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-12-11 at 11:40 -0800, Vinod Koul wrote:
> You have confused the meanings of TLV
> #define DECLARE_TLV_DB_SCALE(name, min, step, mute)
> 
> > -static const DECLARE_TLV_DB_SCALE(digital_tlv, -7650, 150, 1);
> > -static const DECLARE_TLV_DB_SCALE(port_tlv, 0, 600, 0);
> > +static const DECLARE_TLV_DB_SCALE(adc_dac_tlv, -7650, 150, 1);
> step is right here, but MAX shows up as 63 and not 18dB and where is
> mute here. You have separate bit for mute!
> > +static const DECLARE_TLV_DB_SCALE(mic_tlv, 0, 200, 1);
> step is NOT 2dB but 10dB, and where do we have mute here
Sorry I mis read data sheet, this is fine. We have 2dB steps

I have tested both of these so:
Tested-by: Vinod Koul <vinod.koul@intel.com>

Only mute bits need to be fixed here and we should be good

-- 
~Vinod
