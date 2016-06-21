From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [RESEND PATCH v3 1/2] device property: Add
 function to search for named child of device
Date: Tue, 21 Jun 2016 10:39:38 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D4644241@SW-EX-MBX01.diasemi.com>
References: <cover.1466421714.git.Adam.Thomson.Opensource@diasemi.com>
 <866c9edccdd89805f6a0c0aa92f8a78ae616ed61.1466421714.git.Adam.Thomson.Opensource@diasemi.com>
 <2E89032DDAA8B9408CB92943514A0337D464422E@SW-EX-MBX01.diasemi.com>
 <1466504574.30123.196.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FDAA260592
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 12:39:49 +0200 (CEST)
In-Reply-To: <1466504574.30123.196.camel@linux.intel.com>
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
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Opensource [Adam
 Thomson]" <Adam.Thomson.Opensource@diasemi.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J.Wysocki" <rafael.j.wysocki@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org

On 21 June 2016 11:23, Andy Shevchenko wrote:

> > There still seems to be an issue with this patch set reaching the
> > linux-acpi mailing list (as well as the other vger.kernel.org lists).
> > Have
> > spent some time looking into it but so far can't see anything
> > obviously wrong
> > with the mail format. Also tried to reduce down the number of people
> > on the
> > To/Cc list
> 
> There is still _a lot_ of addresses in the Cc and To fields.

There are a reasonable number, but the patch set does cross ALSA, DT and ACPI,
and those addresses are retrieved from the getmaintainer.pl script as
maintainers/supporters of those subsystems. I've also seen e-mails with larger
To and Cc fields appear on the various mailing lists without issue, so am
struggling to figure out why my initial patches aren't making it.

I can of course try again with a further reduced number of To/Cc, but I don't
want to miss off important reviewers, and I really don't want to spam the lists
unnecessarily.
