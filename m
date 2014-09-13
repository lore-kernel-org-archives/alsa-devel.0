From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: The best practice to tie platform DAPM widget and
 codec pin
Date: Sat, 13 Sep 2014 01:12:14 -0700
Message-ID: <CAOMFOmWomQaJzcM8PVALQw7cY0QhvDzksd0KR1xNOGSJvDy4LQ@mail.gmail.com>
References: <CAOMFOmX5FCsxXpoboDLKpnZrBQ52v3jRZQHbJAk2st0gXYrVKg@mail.gmail.com>
 <541309E6.9020809@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com
 [209.85.220.175])
 by alsa0.perex.cz (Postfix) with ESMTP id E16132658F3
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 10:12:15 +0200 (CEST)
Received: by mail-vc0-f175.google.com with SMTP id hq11so1655248vcb.6
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 01:12:14 -0700 (PDT)
In-Reply-To: <541309E6.9020809@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

On Fri, Sep 12, 2014 at 7:57 AM, Mike Looijmans <mike.looijmans@topic.nl> wrote:
> On 09/12/2014 06:04 AM, Anatol Pomozov wrote:
>>
>> Hi
>>
>> I bringing up a board that has Realtek 5677 codec. The codec has 6
>> gpios and two of them are used by the board. pin3 is used to enable
>> headphones amplifier. pin2 is used to gate DMIC clock for 3 of 4 DMICs
>> - it allows to leave only one DMIC working in low-power mode.
>>
>> Now I need to configure the codec that when "Headphones" audio path is
>> enabled then pin3 should go high. The same true for DMIC/pin2. I was
>> looking for existing similar solutions but cannot find one.
>>
>> I need something similar to SND_SOC_DAPM_REGULATOR_SUPPLY that allows
>> to turn on/off part of the system. But instead of manipulating a
>> voltage regulator I just need to set/unset codec's gpio. What would be
>> the best way to achieve it?
>
>
> You can "convert" gpios to supply regulators using a "fixed" regulator
> driver (instantiated in the devicetree, or platform code on older kernels).

In my case it is not a system gpio, it is an audio codec pin. To
configure these pins I need to program codec (rt5677) registers. Pins
drive devices like headphones amp.

To convert the pins to gpio devicetree object I need to implement a
driver similar to gpio-tegra.c. The driver will expose rt5677 pins as
gpio. And then use fixed-regulator. Do I understand your proposal
correctly?

Is there an easier way?
