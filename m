From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/3] ACPI / utils: Introduce
	acpi_dev_get_dev_name()
Date: Fri, 5 Jan 2018 13:34:07 +0100
Message-ID: <CAJZ5v0hYYPXT=Z8qnAV3mniF1hJ8Vu9t+MzUPX7o6Wg4zaUHwQ@mail.gmail.com>
References: <20180104164709.64387-1-andriy.shevchenko@linux.intel.com>
 <20180104164709.64387-2-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0ih7RCPCdmVyn-RV39pUmZvodZs9S9-Av_ucY4mZ7vTrA@mail.gmail.com>
 <1515154920.7000.732.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com
 [209.85.218.50])
 by alsa0.perex.cz (Postfix) with ESMTP id D9D83267A16
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 13:34:08 +0100 (CET)
Received: by mail-oi0-f50.google.com with SMTP id g6so2996247oib.11
 for <alsa-devel@alsa-project.org>; Fri, 05 Jan 2018 04:34:08 -0800 (PST)
In-Reply-To: <1515154920.7000.732.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 5, 2018 at 1:22 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, 2018-01-05 at 13:06 +0100, Rafael J. Wysocki wrote:
>> On Thu, Jan 4, 2018 at 5:47 PM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> > Sometimes the user want to have device name of the match rather than
>> > just checking if device present or not.
>>
>> I would give an example here.
>
> You mean to mention what is in patch 2?
> I can do that.
>
> "Subset of Intel ASoC drivers is an existing user of this API when they
> need to find an actual instance of the codec device based on its ACPI
> HID."

And why do they need the name (and not something else)?

>> > To make life easier for such
>> > users introduce acpi_dev_get_dev_name()
>>
>> What about acpi_dev_get_match_name() or just acpi_dev_match_name()?
>
> It's "get", not "match".

OK

> So, acpi_dev_get_name() then?

It would be somewhat clearer to call it acpi_dev_get_first_match_name() IMO.

Otherwise it may not be clear what name this is going to return.
