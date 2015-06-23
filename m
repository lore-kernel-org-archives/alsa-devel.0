From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: rt5677: Switch to use unified
 device property API
Date: Mon, 22 Jun 2015 17:05:37 -0700
Message-ID: <D1ADF0B6.D4C8F%dvhart@linux.intel.com>
References: <1434996780-34535-1-git-send-email-benzh@chromium.org>
 <1434996780-34535-2-git-send-email-benzh@chromium.org>
 <558889CE.7010104@linux.intel.com>
 <20150622225031.GW14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A7207261546
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 02:05:46 +0200 (CEST)
In-Reply-To: <20150622225031.GW14071@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, Anatol Pomozov <anatol@google.com>, Grant Likely <grant.likely@linaro.org>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 6/22/15, 3:50 PM, "Mark Brown" <broonie@kernel.org> wrote:

>On Tue, Jun 23, 2015 at 12:18:54AM +0200, Pierre-Louis Bossart wrote:
>> On 6/22/15 8:13 PM, Ben Zhang wrote:
>
>> >+	rt5677->pdata.in1_diff = device_property_read_bool(dev,
>> >+			"realtek,in1-differential");
>
>> Shouldn't it be device_property_present() ?
>
>At least on the DT side they should be equivalent - I don't know if ACPI
>works differently?
>
>> thanks for starting this transition, this will be very useful for
>>ACPI-based
>> solutions.
>
>Have the Intel audio people been speaking to the UEFI forum about using
>the new registration process for these properties?  More from interest
>than anything else.

Yes (although "audio people" is a rather broad term at Intel :-)


-- 
Darren Hart
Intel Open Source Technology Center
