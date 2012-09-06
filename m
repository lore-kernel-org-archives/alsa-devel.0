From: Daniel Mack <zonque@gmail.com>
Subject: Re: (no subject)
Date: Thu, 06 Sep 2012 08:33:30 +0200
Message-ID: <504843BA.2040808@gmail.com>
References: <s5hmx1526mg.wl%tiwai@suse.de> <20120906060220.GA252@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id EBB2926537D
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 08:33:39 +0200 (CEST)
Received: by bkuw5 with SMTP id w5so494918bku.38
 for <alsa-devel@alsa-project.org>; Wed, 05 Sep 2012 23:33:39 -0700 (PDT)
In-Reply-To: <20120906060220.GA252@x4>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 06.09.2012 08:02, Markus Trippelsdorf wrote:
> On 2012.09.04 at 16:40 +0200, Takashi Iwai wrote:
>> ----------------------------------------------------------------
>> Sound fixes for 3.6-rc5
>>
>> There are nothing scaring, contains only small fixes for HD-audio and
>> USB-audio:
>> - EPSS regression fix and GPIO fix for HD-audio IDT codecs
>> - A series of USB-audio regression fixes that are found since 3.5 kernel
>>
>> ----------------------------------------------------------------
>> Daniel Mack (4):
>>       ALSA: snd-usb: Fix URB cancellation at stream start
>>       ALSA: snd-usb: restore delay information
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
> The commit fbcfbf5f above causes the following lines to be printed
> whenever I start a new song:

Copied Pierre-Louis Bossart - he wrote the code in 294c4fb8 which this
patch (fbcfbf5f) brings back now.

> delay: estimated 0, actual 352
> delay: estimated 353, actual 705
> 
> (44.1 * 8 = 352.8)
> 
> This happens with an USB-DAC that identifies itself as "C-Media USB
> Headphone Set".

And you didn't you see these lines with 3.4?


Daniel
