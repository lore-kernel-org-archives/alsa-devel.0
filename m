From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: Re: [PATCH 1/5] ALSA: hda: Remove unused variable
Date: Tue, 1 Jul 2014 17:33:25 +0530
Message-ID: <CAK5sBcG2jEmcaAv-TpoDihspiCimW04xyryW_OgD_13PXUD9pg@mail.gmail.com>
References: <1404214378-24669-1-git-send-email-sachin.kamat@samsung.com>
 <s5h4mz18f7e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id E2F8B264F53
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 14:03:25 +0200 (CEST)
Received: by mail-la0-f46.google.com with SMTP id el20so5869397lab.33
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 05:03:25 -0700 (PDT)
In-Reply-To: <s5h4mz18f7e.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 1, 2014 at 5:26 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Tue,  1 Jul 2014 17:02:54 +0530,
> Sachin Kamat wrote:
>>
>> 'status' is not used in the function. Remove it.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> ---
>> All patches in this series only compile tested.
>
> Removing such a line is unsafe, thus it must be tested.  It changes
> the hardware access pattern and sometimes the read is intentionally
> there although the value isn't used.
>
> That said, without testing, I won't apply such patches.

Right. I understand. That is the reason I explicitly mentioned that patches
are untested.
However, in the above cases how about removing the local variable (return value)
and just keeping the read/write calls?

Regards,
Sachin.
