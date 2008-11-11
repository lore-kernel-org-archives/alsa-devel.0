From: chri <chripell@gmail.com>
Subject: Re: [PATCH] ALSA SOC driver for s3c24xx with uda1341
Date: Tue, 11 Nov 2008 15:14:04 +0100
Message-ID: <cabda6420811110614k73d97d4are33f5471044e86a4@mail.gmail.com>
References: <12261302352402-git-send-email-chripell@gmail.com>
	<20081110220959.GH22835@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 935AE24149
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 15:14:05 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 21so1101502eyc.56
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 06:14:04 -0800 (PST)
In-Reply-To: <20081110220959.GH22835@trinity.fluff.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, zdevai@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 10, 2008 at 11:09 PM, Ben Dooks <ben-linux@fluff.org> wrote:

>
> example into a doc file please, or point at an implementation of
> this.
>

ack

>> +#define setdat(adap, val)    (adap->setdat(adap, val))
>> +#define setclk(adap, val)    (adap->setclk(adap, val))
>> +#define setmode(adap, val)   (adap->setmode(adap, val))
>
> inline functions are better than #define.
>

ack

>> +#include "uda1341_platform_data.h"
>
> please find as better name for that file.
>

I always have problems as far as platform data is concerned because it
should be separated from the private data structures of the driver; so
it's rather common to just have a small ad-hoc file for them. In
socketcan a decision was made to put all the platform data in a
subdirectory so the name can be short and one knows where to look. Do
you have any suggestion where is the best place to put this file and
for a consistent naming convention?

>> +}
>
> do you really want to be busy-waiting the cpu for that long? how
> about msleep?
>

ack, I'll use msleep

>> +     void (*setmode) (struct uda1341_platform_data *, int);
> no spaces              ^
>

ack. It's strange that checkpatch.pl didn't catch this

>
> find somewhere for these to live that can be included without
> resorting to knowing the directory layout.
>

ack, I'll try include/sound

>> +}
>
> please use the generic gpio layer, the s3c24xx functions are going
> to be deprecated and removed as soon as possible, probably after
> 2.6.28.
>

ack.

>> +     pclk = clk_get(NULL, "pclk");
>
> check for errors. really you should be passing a device for pclk.
>

ack

Thanks,


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
