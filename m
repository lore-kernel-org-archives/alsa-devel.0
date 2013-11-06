From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Make sure mute LEDs stay on
 during runtime suspend (Realtek)
Date: Wed, 06 Nov 2013 11:17:23 +0100
Message-ID: <527A1733.2080907@canonical.com>
References: <1383731444-6487-1-git-send-email-david.henningsson@canonical.com>
 <s5hr4atet6f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E1CB0261740
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2013 11:17:24 +0100 (CET)
In-Reply-To: <s5hr4atet6f.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, 1248465@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 11/06/2013 11:11 AM, Takashi Iwai wrote:
> At Wed,  6 Nov 2013 10:50:44 +0100,
> David Henningsson wrote:
>>
>> Some HP machines with Realtek codecs have mute LEDs connected to VREF pins.
>> However when these go into runtime suspend, the pin powers down and its
>> pin control is disabled, thus disabling the LED too.
>>
>> This patch fixes that issue by making sure that the pin stays in D0 with
>> correct pin control.
>>
>> Cc: stable@kernel.org
>> BugLink: https://bugs.launchpad.net/bugs/1248465
>> Tested-by: Franz Hsieh <franz.hsieh@canonical.com>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> 
> Thanks, applied.
> 
> I do wonder, though, whether the LED survives even after turning AFG
> to D3.  With IDT codecs, we had to keep AFG D0 just for keeping this
> VREF stuff.  Maybe Realtek codecs behave differently.

Well, the patch was tested by Franz and found working, so it seems
indeed that AFG can be in D3 and the LED still works.

(Actually it could even be the other way around - maybe even the pin can
remain in D3 and still have vref output, as long as the pin ctl is set.
I never tested that explicitly.)

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
