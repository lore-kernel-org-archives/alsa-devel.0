From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] ASoC: rt5645: Introduce mapping for
	ACPI-defined GPIO
Date: Thu, 15 Feb 2018 10:17:45 +0100
Message-ID: <cb4736e2-bcc0-c8da-efd9-7d5ea7f23d25@redhat.com>
References: <20180209142318.14451-1-carlo@caione.org>
 <CAOQ7t2ZHisZRPq6tKL3QNuKWQFNpVpJ-DoPdM80jMx8u7J=fBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id E042B267B47
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 10:17:47 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id z81so1334344wmb.4
 for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2018 01:17:47 -0800 (PST)
In-Reply-To: <CAOQ7t2ZHisZRPq6tKL3QNuKWQFNpVpJ-DoPdM80jMx8u7J=fBg@mail.gmail.com>
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
To: Carlo Caione <carlo@caione.org>, open list <linux-kernel@vger.kernel.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Carlo Caione <carlo@endlessm.com>, bardliao@realtek.com, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 15-02-18 10:11, Carlo Caione wrote:
> On Fri, Feb 9, 2018 at 2:23 PM, Carlo Caione <carlo@caione.org> wrote:
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> On at least one notebook (ECS EF20EA) the 'hp-detect' GPIO is defined in
>> the DSDT table by the ACPI GpioIo resources in _CRS. Add this mapping to
>> the rt5645 driver to enable the jack detection also on non-DT platforms.
> 
> Please do not merge this yet, I'll submit a V3 soon.
> Hans pointed out that on some BayTrail there is indeed an extra GPIO
> but it is used to enable the external speaker amplifier. Better to
> guard this by a quirk.

Thank you Carlo, note that the tablet I was talking about is a rt5651 based
tablet, but yes you never know for what reasons someone will put an extra
GPIO in the resources table, so guarding this with a quirk seems like a good
idea.

Regards,

Hans
