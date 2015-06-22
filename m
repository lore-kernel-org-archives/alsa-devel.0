From: Ben Zhang <benzh@google.com>
Subject: Re: [PATCH 2/2] ASoC: rt5677: Switch to use unified
 device property API
Date: Mon, 22 Jun 2015 16:07:59 -0700
Message-ID: <CAOV7ByKWOtZPpzbyFzNh8fQWiFf3FhsjX9_McoY5YaiATks2FQ@mail.gmail.com>
References: <1434996780-34535-1-git-send-email-benzh@chromium.org>
 <1434996780-34535-2-git-send-email-benzh@chromium.org>
 <558889CE.7010104@linux.intel.com>
 <20150622225031.GW14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f175.google.com (mail-yk0-f175.google.com
 [209.85.160.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 3281A2604E2
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 01:08:00 +0200 (CEST)
Received: by ykfy125 with SMTP id y125so23945013ykf.1
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 16:07:59 -0700 (PDT)
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
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel <alsa-devel@alsa-project.org>, Darren Hart <dvhart@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Anatol Pomozov <anatol@google.com>, Grant Likely <grant.likely@linaro.org>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 22, 2015 at 3:50 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jun 23, 2015 at 12:18:54AM +0200, Pierre-Louis Bossart wrote:
>> On 6/22/15 8:13 PM, Ben Zhang wrote:
>
>> >+    rt5677->pdata.in1_diff = device_property_read_bool(dev,
>> >+                    "realtek,in1-differential");
>
>> Shouldn't it be device_property_present() ?
>
> At least on the DT side they should be equivalent - I don't know if ACPI
> works differently?

I think they are equivalent on the ACPI side as well. device_property_read_bool
is defined as a wrapper of device_property_present in include/linux/property.h.
I tested that the function returns true iff an entry for the property
exists in the _DSD.

For example in1_diff is true when:
Name (_DSD, Package () {
    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
    Package () {
        Package () { "realtek,in1-differential", 1 },
        ....
    }
})

>> thanks for starting this transition, this will be very useful for ACPI-based
>> solutions.
>
> Have the Intel audio people been speaking to the UEFI forum about using
> the new registration process for these properties?  More from interest
> than anything else.
