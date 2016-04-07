From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Thu, 7 Apr 2016 12:34:51 -0700
Message-ID: <CABCoZhA6gXd2cCu4j7ZXG7Y8yiakO04k5_eob7YbP56aP20waQ@mail.gmail.com>
References: <1458629605-6225-1-git-send-email-yesanishhere@gmail.com>
 <20160328191304.GF2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f67.google.com (mail-vk0-f67.google.com
 [209.85.213.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BFF42650DB
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 21:34:52 +0200 (CEST)
Received: by mail-vk0-f67.google.com with SMTP id a6so2977098vkh.1
 for <alsa-devel@alsa-project.org>; Thu, 07 Apr 2016 12:34:52 -0700 (PDT)
In-Reply-To: <20160328191304.GF2350@sirena.org.uk>
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

On Mon, Mar 28, 2016 at 12:13 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Mar 21, 2016 at 11:53:25PM -0700, anish kumar wrote:
>
>> +static const char *const voltage_level_text[] = {
>> +     "9.5dB", "10.5dB", "11.5dB", "11.5dB", "12.5dB",
>> +     "13.5dB", "14.5dB", "15.5dB", "16.5dB", "17.5dB",
>> +     "18.5dB", "19.5dB", "20.5dB"
>> +};
>
> These look like this control is a gain and so I'd expect it to be a
> normal TLV control.  What does this control do exactly?

It is "Speaker No-Load Output Voltage Maximum". It is
described here on page 50.
https://datasheets.maximintegrated.com/en/ds/MAX98371.pdf
