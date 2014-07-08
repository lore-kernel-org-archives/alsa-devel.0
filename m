From: Sachin Kamat <sachin.kamat@samsung.com>
Subject: Re: [PATCH 1/1] ASoC: core: Fix trivial typo
Date: Tue, 8 Jul 2014 18:14:33 +0530
Message-ID: <CAK5sBcEf7YQhcR=jFZWpQt4sPwLCOTN3imQ=81=SrwXGGaiNmw@mail.gmail.com>
References: <1404809172-12151-1-git-send-email-sachin.kamat@samsung.com>
 <20140708095833.GT30458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 367B526171D
 for <alsa-devel@alsa-project.org>; Tue,  8 Jul 2014 14:44:34 +0200 (CEST)
Received: by mail-lb0-f181.google.com with SMTP id p9so3844647lbv.26
 for <alsa-devel@alsa-project.org>; Tue, 08 Jul 2014 05:44:33 -0700 (PDT)
In-Reply-To: <20140708095833.GT30458@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 8, 2014 at 3:28 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 08, 2014 at 02:16:12PM +0530, Sachin Kamat wrote:
>
>>       /*
>> -      * EINVAL means the property does not exist. This is fine providing
>> +      * EINVAL means the property does not exist. This is fine provided
>>        * card->name was previously set, which is checked later in
>>        * snd_soc_register_card.
>>        */
>
> This isn't actually a typo; both variants are equally good English.

Oh OK. Wasn't sure if it was right usage.

Regards,
Sachin.
