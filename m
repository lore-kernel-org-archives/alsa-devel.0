From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] ALSA: use ktime_get_raw_ts64() instead
	of getrawmonotonic64()
Date: Mon, 18 Jun 2018 17:52:43 +0200
Message-ID: <CAK8P3a13rsTxinJ5m6-VOZJx6pXeWav41AQNtS7dSMahYzqXaw@mail.gmail.com>
References: <20180618154108.2227779-1-arnd@arndb.de>
 <s5htvq0w12d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id ADDF0266E77
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 17:52:45 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id u5-v6so4199455lff.13
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 08:52:45 -0700 (PDT)
In-Reply-To: <s5htvq0w12d.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 18, 2018 at 5:45 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 18 Jun 2018 17:41:00 +0200,
> Arnd Bergmann wrote:
>>
>> The API got renamed for consistency and the old name will
>> be removed once the last users are gone.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> These two fixes can be postponed for 4.19, or urgently needed for
> 4.18?  I suppose the former, but just to be sure.

Not urgent at all. I also noticed (slightly too late) that the first one doesn't
even apply,
I had written it on top of my tree that contained the previously discussed
API conversion, which Baolin and I still need to follow up on. I'll fold
the first patch into that series, please apply just the seconds patch
for 4.19 for now.

        Arnd
