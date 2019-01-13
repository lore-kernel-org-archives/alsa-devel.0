From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFT][PATCH v1] gpiolib: acpi: Introduce
 ACPI_GPIO_QUIRK_ONLY_GPIOIO
Date: Sun, 13 Jan 2019 08:50:27 +0100
Message-ID: <fbb55ce7-0ca3-a1ad-249e-764840c46804@redhat.com>
References: <20190108180205.55109-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdYgBsvNR1PFuzmMegpjraWRi58ACb-=mBrUDvLoi_5J_g@mail.gmail.com>
 <20190111194929.GW9170@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 473EC26687D
 for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2019 08:50:30 +0100 (CET)
Received: by mail-ed1-f67.google.com with SMTP id x30so16316188edx.2
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2019 23:50:30 -0800 (PST)
In-Reply-To: <20190111194929.GW9170@smile.fi.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jie Yang <yang.jie@linux.intel.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Mark Brown <broonie@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 11-01-19 20:49, Andy Shevchenko wrote:
> On Fri, Jan 11, 2019 at 03:21:39PM +0100, Linus Walleij wrote:
>> On Tue, Jan 8, 2019 at 7:02 PM Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>
>>> New quirk enforces search for GPIO based on its type.
>>> Note, supplied index in the mapping table must be 0.
>>>
>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> (...)
>>
>>>   sound/soc/intel/boards/bytcr_rt5651.c | 74 ++++-----------------------
>>
>> Do we have an ACK from the maintainer of this file?
>> It's Hans I think. Ideally also from Mark Brown.
> 
> I hope to get Hans' Tested-by on this.

Yes I've testing this on my TODO.

Regards,

Hans
