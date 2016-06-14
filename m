From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [RESEND PATCH v2 1/2] device property: Add
 function to search for named child of device
Date: Tue, 14 Jun 2016 08:39:01 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D4642976@SW-EX-MBX01.diasemi.com>
References: <cover.1464802265.git.Adam.Thomson.Opensource@diasemi.com>
 <7105258db927c65dfa41a8abeef4b9735871d023.1464802265.git.Adam.Thomson.Opensource@diasemi.com>
 <97f80018-7cc4-0a50-498d-89d27dfa2fd1@intel.com>
 <2E89032DDAA8B9408CB92943514A0337D46421B6@SW-EX-MBX01.diasemi.com>
 <575F0A50.1090107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 546DA266267
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2016 10:39:04 +0200 (CEST)
In-Reply-To: <575F0A50.1090107@gmail.com>
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
To: Frank Rowand <frowand.list@gmail.com>, "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jaroslav Kysela <perex@perex.cz>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Rob Herring <rob.herring@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Hanjun Guo <hanjun.guo@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Robert Moore <robert.moore@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 13 June 2016 20:33, Frank Rowand wrote:

> > DT node names are case insensitive. The of.h header does provide a helper macro
> > which is equivalent to this, but that macro is part of the '#ifdef CONFIG_OF'
> > block. If I were to use it then it would cause non-DT builds to fail. I opted
> > for strcasecmp() directly as I didn't think for just this one scenario it made
> > sense to reorganise the of.h header with regards to the helper macros. Of course
> > if there are other opinions on this then am happy to listen.
>
> DT node names are not always case insensitive.  Please us of_node_cmp().
>
> -Frank

Ok, fair enough. I'll have to move those definitions in the of.h header out of
the CONFIG_OF block then.
