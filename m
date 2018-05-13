From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] ALSA: hda: Add Lenovo C50 All in one to
 the power_save blacklist
Date: Sun, 13 May 2018 09:20:10 +0200
Message-ID: <867f071a-2616-b0e6-baed-b7eff69a76c9@redhat.com>
References: <20180508072746.10798-1-hdegoede@redhat.com>
 <s5htvrc8219.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 5161526765C
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 09:20:14 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id a67-v6so8436622wmf.3
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 00:20:14 -0700 (PDT)
In-Reply-To: <s5htvrc8219.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 05/13/2018 09:09 AM, Takashi Iwai wrote:
> On Tue, 08 May 2018 09:27:46 +0200,
> Hans de Goede wrote:
>>
>> Power-saving is causing loud plops on the Lenovo C50 All in one, add it
>> to the blacklist.
>>
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1572975
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Before adding to blacklist, could you try some usual suspects?
> For Lenovo, you can try at first to pass
>    model=,tpt440
> to snd-hda-intel module.
> 
> (the first comma is no typo but to pass the model name to the second
>   controller for Realtek.)
> 
> The above will add some bogus dock jacks, so it's no solution but to
> just to test whether it avoids the clicking noise.

Sure, note I'm just forwarding these bugs from Fedora reporters,
more often then not I don't have access to the hardware myself.

I always add a BugLink tag to the bug, so perhaps next time you
can reach out to the reporter directly ? I've forwarded your
request this time.

I also always ask for alsa-info.sh output, so following the BugLink
will also give you access to that.

Regards,

Hans
