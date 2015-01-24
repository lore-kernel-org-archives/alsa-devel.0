From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 0/2] ASoC: Fix wm97xx touchscreen driver
Date: Sat, 24 Jan 2015 14:15:37 +0100
Message-ID: <54C39AF9.2030206@metafoo.de>
References: <1422026497-23180-1-git-send-email-lars@metafoo.de>
 <CAOLZvyHdhOusK1GNrEmThqetzqC=qV4XpLP7BT7CE3641fKEnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-238.synserver.de (smtp-out-238.synserver.de
 [212.40.185.238])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C3AF2605AA
 for <alsa-devel@alsa-project.org>; Sat, 24 Jan 2015 14:15:37 +0100 (CET)
In-Reply-To: <CAOLZvyHdhOusK1GNrEmThqetzqC=qV4XpLP7BT7CE3641fKEnQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 01/23/2015 08:09 PM, Manuel Lauss wrote:
> On Fri, Jan 23, 2015 at 4:21 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> The wm97xx touchscreen driver will bind itself to the snd_ac97 device
>> registered by CODEC drivers and expects that the device has already been
>> reset by the CODEC driver. Previous to commit 6794f709b712 ("ASoC: ac97:
>> Drop delayed device registration") the snd_ac97 device was only registered
>> after the CODEC driver probe function had finished running, but starting
>> with the commit it is registered within snd_soc_new_ac97_codec(). This
>> breaks the touchscreen driver as the reset is no longer performed before the
>> touchscreen driver probe function runs. This patch series introduces a new
>> function snd_soc_alloc_ac97_codec() which allocates the snd_ac97 device, but
>> does not yet register it yet. This allows the CODEC drivers to perform the
>> reset before the device is registered.
>>
>> The series is meant to perform a minimum amount of changes while fixing the
>> issue to prevent introducing other regressions. I have a few more patches
>> that consolidate the reset handling in the drivers and puts it into the core
>> in snd_soc_new_ac97_codec() which makes the split in the drivers
>> unnecessary, but that's something for next and not for stable.
>>
>> Manuel can you give this another round of testing?
>
> Works very well.
>
> Tested-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks.

Just noticed I forgot to add the Wolfson guys to Cc, done now.

- Lars
