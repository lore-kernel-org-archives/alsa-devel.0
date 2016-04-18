From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Mon, 18 Apr 2016 13:20:35 -0700
Message-ID: <CABCoZhDLyT_2xMhOqkiw5+9rOtA9FUqcvxy+1Pz=2QohAZEcHA@mail.gmail.com>
References: <1460578847-8712-1-git-send-email-yesanishhere@gmail.com>
 <20160418164727.GI3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f67.google.com (mail-vk0-f67.google.com
 [209.85.213.67])
 by alsa0.perex.cz (Postfix) with ESMTP id E20BF265173
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 22:20:38 +0200 (CEST)
Received: by mail-vk0-f67.google.com with SMTP id a6so24328357vkh.1
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 13:20:38 -0700 (PDT)
In-Reply-To: <20160418164727.GI3217@sirena.org.uk>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 18, 2016 at 9:47 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Apr 13, 2016 at 01:20:47PM -0700, anish kumar wrote:
>
>> +static const char *const voltage_level_text[] = {
>> +     "9.5dB", "10.5dB", "11.5dB", "11.5dB", "12.5dB",
>> +     "13.5dB", "14.5dB", "15.5dB", "16.5dB", "17.5dB",
>> +     "18.5dB", "19.5dB", "20.5dB"
>> +};
>
> As I said last time I would expect this to be a TLV control.  As far as
> I can tell this is basically functioning as a maximum volume.  Otherwise
> this looks good.

I responded to your comment earlier but there was no reply so I thought
it is accepted this way. Excuse my understanding. It is not actually a volume
but described as such.

It is "Speaker No-Load Output Voltage Maximum". It is
described here on page 50.
https://datasheets.maximintegrated.com/en/ds/MAX98371.pdf
