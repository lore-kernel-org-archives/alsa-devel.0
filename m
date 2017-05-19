From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: Re: [PATCH] ASoC: max98927: Adding support for TDM
 mode and Envelop tracking control
Date: Thu, 18 May 2017 20:12:26 -0700
Message-ID: <CAN4-oj=_M+vBOXF7rmgUXD3eA282FEj_rQn-3OqL3hpe0nRVVg@mail.gmail.com>
References: <1494006135-1178-1-git-send-email-ryans.lee@maximintegrated.com>
 <20170514101115.f53hlcbp7z4muelu@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0132.outbound.protection.outlook.com [104.47.37.132])
 by alsa0.perex.cz (Postfix) with ESMTP id A7920266A0D
 for <alsa-devel@alsa-project.org>; Fri, 19 May 2017 05:12:33 +0200 (CEST)
Received: by mail-oi0-f52.google.com with SMTP id h4so77704451oib.3
 for <alsa-devel@alsa-project.org>; Thu, 18 May 2017 20:12:30 -0700 (PDT)
In-Reply-To: <20170514101115.f53hlcbp7z4muelu@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, May 14, 2017 at 3:11 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, May 05, 2017 at 10:42:15AM -0700, Ryan Lee wrote:
>> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
>> ---
>
> The subject line suggests that this is adding two new features.  Unless
> they are very closely related in the code they should be submitted as
> separate patches as covered in SubmittingPatches.

Thank you for your feedback.
I separated this patch to five separate patches.

>
>>       default:
>> -             dev_err(codec->dev, "DAI clock mode unsupported");
>> +             dev_err(codec->dev, "DAI clock mode unsupported\n");
>>               return -EINVAL;
>>       }
>>
>
> It also seems like there are a number of unrelated stylistic changes in
> this patch.  While it's fine to make such changes they too should be in
> separate patches.

I applied this to separate patch.
