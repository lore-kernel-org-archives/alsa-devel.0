From: Dylan Reid <dgreid@google.com>
Subject: Re: [PATCH 1/5] ALSA: hda: Remove unused variable
Date: Tue, 1 Jul 2014 08:47:39 -0700
Message-ID: <CAEUnVG7EF0_wv+FK_ysP4AXqpzE0wXp6K_8vG5S7Nw3O4=qMmQ@mail.gmail.com>
References: <1404214378-24669-1-git-send-email-sachin.kamat@samsung.com>
 <53B2CEA3.1010905@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f175.google.com (mail-qc0-f175.google.com
 [209.85.216.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B7EE2656DD
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 17:48:01 +0200 (CEST)
Received: by mail-qc0-f175.google.com with SMTP id i8so8480223qcq.20
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 08:48:00 -0700 (PDT)
In-Reply-To: <53B2CEA3.1010905@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Sachin Kamat <sachin.kamat@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, spk.linux@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 1, 2014 at 8:07 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 07/01/2014 05:32 AM, Sachin Kamat wrote:
>> 'status' is not used in the function. Remove it.
>
> CCing Dylan Reid for comments/testing since he wrote or upstreamed this
> code.

Thanks, I gave this a try on a couple of systems this morning.  HDMI
audio still works through suspend/resume cycles.

>
>> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
>> Cc: Stephen Warren <swarren@wwwdotorg.org>

Tested-by: Dylan Reid <dgreid@chromium.org>

>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> ---
>> All patches in this series only compile tested.
>> ---
>>  sound/pci/hda/hda_tegra.c |    4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
>> index a366ba9293a8..8cd7b06eecef 100644
>> --- a/sound/pci/hda/hda_tegra.c
>> +++ b/sound/pci/hda/hda_tegra.c
>> @@ -272,13 +272,9 @@ static int hda_tegra_resume(struct device *dev)
>>       struct snd_card *card = dev_get_drvdata(dev);
>>       struct azx *chip = card->private_data;
>>       struct hda_tegra *hda = container_of(chip, struct hda_tegra, chip);
>> -     int status;
>>
>>       hda_tegra_enable_clocks(hda);
>>
>> -     /* Read STATESTS before controller reset */
>> -     status = azx_readw(chip, STATESTS);
>> -
>>       hda_tegra_init(hda);
>>
>>       azx_init_chip(chip, 1);
>>
>
