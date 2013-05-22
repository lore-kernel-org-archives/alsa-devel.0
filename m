From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: add codec driver for TI TAS5086
Date: Wed, 22 May 2013 20:25:38 +0200
Message-ID: <519D0DA2.3050508@gmail.com>
References: <1362740833-15704-1-git-send-email-zonque@gmail.com>
 <CAKON4OyqoUTsYHqv3kW3jN9Za=-Z866rcjPiANL8t5uyraK=6w@mail.gmail.com>
 <519D068A.8030003@gmail.com>
 <CAKON4OyX+xSR8A-J9RM=tE5PowQyqzZC8TA8J7f+pn5SRkE--g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f50.google.com (mail-bk0-f50.google.com
 [209.85.214.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F21D2610BA
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 20:25:17 +0200 (CEST)
Received: by mail-bk0-f50.google.com with SMTP id ik8so344949bkc.23
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2013 11:25:16 -0700 (PDT)
In-Reply-To: <CAKON4OyX+xSR8A-J9RM=tE5PowQyqzZC8TA8J7f+pn5SRkE--g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 22.05.2013 20:01, jonsmirl@gmail.com wrote:
> On Wed, May 22, 2013 at 1:55 PM, Daniel Mack <zonque@gmail.com> wrote:
>> On 22.05.2013 19:50, jonsmirl@gmail.com wrote:
>>> On Fri, Mar 8, 2013 at 6:07 AM, Daniel Mack <zonque@gmail.com> wrote:
>>>> This patch adds a driver for TI's TA5086 6-channel PWM processor.
>>>>
>>>> This chip has a very unusual register layout, specifically because the
>>>> registers are of unequal size, and multi-byte registers require bulk
>>>> writes to take effect. Regmap does not support these kind of mappings.
>>>>
>>>> Currently, the driver does not touch any of the registers >= 0x20, so
>>>> it doesn't matter, because the register map is mapped to an 8-bit array.
>>>> In case more features will be added in the future that require access
>>>> to higher registers, the entire regmap H/W I/O routines have to be
>>>> open-coded.
>>>
>>> Check out my tas5504 driver from a long time ago. It dealt with those registers.
>>>
>>> https://github.com/jonsmirl/mpc5200/blob/master/sound/soc/codecs/tas5504.c
>>> https://github.com/jonsmirl/mpc5200/blob/master/sound/soc/codecs/tas5504.h
>>
>> Sure, without any regmap abstractions, things are somehow manageable.
>> Though you lose all the nice things that regmap gives you, such as
>> hardware independence and caching. I might have a different solution,
>> but I need to get my hands on one of these devices to test.
>>
>> On a slightly different note: why isn't your driver in the mainline kernel?
> 
> TI doesn't make the chip any more.

That might be, but we have tons of drivers for devices in the mainline
kernel which aren't in production anymore.


Daniel
