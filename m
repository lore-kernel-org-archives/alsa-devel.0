From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] ALSA: mips/hal2: Remove redundant
	platform_set_drvdata()
Date: Mon, 6 May 2013 14:18:43 +0530
Message-ID: <CAK9yfHyDyqGGO5ADX+xqnDJMZE9CAaZxD9h06SY7QbY_LkkE0g@mail.gmail.com>
References: <1367815576-11875-1-git-send-email-sachin.kamat@linaro.org>
 <s5h7gjc4hse.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f48.google.com (mail-oa0-f48.google.com
 [209.85.219.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 30C09261A90
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2013 10:48:45 +0200 (CEST)
Received: by mail-oa0-f48.google.com with SMTP id i4so910977oah.21
 for <alsa-devel@alsa-project.org>; Mon, 06 May 2013 01:48:44 -0700 (PDT)
In-Reply-To: <s5h7gjc4hse.wl%tiwai@suse.de>
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

On 6 May 2013 14:16, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon,  6 May 2013 10:16:15 +0530,
> Sachin Kamat wrote:
>>
>> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
>> driver is bound) removes the need to set driver data field to
>> NULL.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Thomas Bogendoerfer <tsbogend@alpha.fanken.de>
>
> Thanks, applied both patches (with the subject fix for the second
> patch).

Thanks. I had already resent the second patch with subject fix. Thanks anyway.

-- 
With warm regards,
Sachin
