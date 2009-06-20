From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: submitting patches to ALSA
Date: Sat, 20 Jun 2009 08:37:03 +0530
Message-ID: <98769532B4BB14429434178695419EAE5B7F85FD@bgsmsx501.gar.corp.intel.com>
References: <BAY119-W8E3C7EC7BE9C8606E2D28B0480@phx.gbl>
	<98769532B4BB14429434178695419EAE5B719DC3@bgsmsx501.gar.corp.intel.com>
	<s5hws78emcn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 73CA524452
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Jun 2009 05:07:09 +0200 (CEST)
In-Reply-To: <s5hws78emcn.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thanks Takashi.

I have tested it already with aplay, papaly and firefox flash, etc,.

Regarding the firmware binary, need I send it as a part of the patch in the email or can I be upload it in a common location where anyone can access it?

Also, I am waiting for few dependant drivers to be submitted for upstream before I can submit my patches otherwise it would break.

Thanks,
Harsha



-----Original Message-----
From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
Sent: Friday, June 19, 2009 12:34 PM
To: Harsha, Priya
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] submitting patches to ALSA

At Thu, 18 Jun 2009 21:33:54 +0530,
Harsha, Priya wrote:
> 
> Hi,
> 
> This is the first time I am planning to submit patches to ALSA. Are
> there any tips/rules I need to follow?

In general, the rule for LKML is applied here, too.

> I have followed the general guidelines like checkpatch, testing with
> different debug configs etc.

Great.

> I have a few questions;
> 1. Against which kernel tree should I create patches to submit to
> ALSA devel mailing list?

Try to apply always to the latest tree, e.g. sound git tree below
	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

> 2. I have to download firmware as a part of my driver. This firmware
> file is freely distributable. How should I share the firmware binary
> file when I send the patches? The firmware binary file would reside
> in /lib/firmware

The firmware file would be either in alsa-firmware package or in
linux-firmware package.  First you can put it to alsa-firmware
package, and we can push them to the upstream linux-firmware package
once after your driver gets merged.

> 3. Is there anything else I need to send to the mailing list in
> addition to the patches?

A good series of patches is self-explanatory :)

> 4. Are there any test suits that I can use to test the driver?

It's a timely question.  We want to discuss this, especially per
request from LSB.  In short answer: no test suits for the time being.
Most people tested with aplay and speaker-test as standard test
programs.


thanks,

Takashi
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
