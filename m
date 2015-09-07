From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: ASoC: please revert "ASoC: db1200: Use static DAI
 format setup"
Date: Mon, 7 Sep 2015 14:10:16 +0200
Message-ID: <CAOLZvyGpQ+p7bYxS3NoryBZ8LptqbeYNb8Aw3OAGwjbvUxbHOw@mail.gmail.com>
References: <CAOLZvyG_tgPoXFJMBkqSeDULBUzgdqnNjQF7eVuzLzU2VtDArg@mail.gmail.com>
 <55ED7AF2.1050800@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f45.google.com (mail-la0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id D9023260532
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2015 14:10:56 +0200 (CEST)
Received: by lagj9 with SMTP id j9so51321471lag.2
 for <alsa-devel@alsa-project.org>; Mon, 07 Sep 2015 05:10:56 -0700 (PDT)
In-Reply-To: <55ED7AF2.1050800@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Servus,

On Mon, Sep 7, 2015 at 1:54 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 09/06/2015 07:32 PM, Manuel Lauss wrote:
>> Hi Lars,
>>
>> commit b4508d0f95fa4aaed889549e31391641d675d4bb
>> ("ASoC: db1200: Use static DAI format setup") breaks I2S in that the
>> set_dai_fmt() callbacks of neither the codec (wm8731) nor the I2S block
>> (psc-i2s) are called.
>>
>> Please revert this change or fix it up so that the set_dai_fmt() callbacks
>> are at least called once. (This was broken since 4.0, but I just now got
>> around to test linux on the hardware again).
>
> Hi,
>
> Can you check whether the attached patch fixes it?


Ja das funktioniert wieder auf dem DB1300.

Danke dir!
     Manuel
