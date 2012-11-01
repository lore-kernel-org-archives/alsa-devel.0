From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: limitations on number of alsa controls for a card
Date: Thu, 1 Nov 2012 18:42:01 +0100
Message-ID: <CAFz=ag7hzZmdhS2d0-0GsbPECUQbOzOz2G4b+FSh=3f__6FtSw@mail.gmail.com>
References: <1351692451.7077.40.camel@vkoul-udesk3>
 <20121101142558.GF4413@opensource.wolfsonmicro.com>
 <1351781211.7077.44.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C1C22625ED
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 18:42:02 +0100 (CET)
Received: by mail-oa0-f51.google.com with SMTP id n12so2588991oag.38
 for <alsa-devel@alsa-project.org>; Thu, 01 Nov 2012 10:42:01 -0700 (PDT)
In-Reply-To: <1351781211.7077.44.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

2012/11/1 Vinod Koul <vinod.koul@linux.intel.com>:
> On Thu, 2012-11-01 at 14:25 +0000, Mark Brown wrote:
>> On Wed, Oct 31, 2012 at 07:37:31PM +0530, Vinod Koul wrote:
>>
>> > Is there any limitation on maximum number of controls we can have.
>>
>>
>> Not that I'm aware of beyond sizeof() type stuff which you're probably
>> still a way away from.

At least, for USB devices there's a maximum for logical mixer channels
(currently, MAX_CHANNELS = 16).  This might feel like a limit for the
number of mixer controls depending on the respective mixer topoplogy.
MAX_CHANNELS can't be raised deliberately in the current code since it
is used for some bitshifting. I don't know if something similar exists
for PCI devices
