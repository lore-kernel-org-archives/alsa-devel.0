From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Wed, 20 Apr 2016 11:14:40 -0700
Message-ID: <CABCoZhAXqXTdMebSHLXTMbAUYCR-8H320F_0EOViYcGqMwisWQ@mail.gmail.com>
References: <1460578847-8712-1-git-send-email-yesanishhere@gmail.com>
 <20160418164727.GI3217@sirena.org.uk>
 <CABCoZhDLyT_2xMhOqkiw5+9rOtA9FUqcvxy+1Pz=2QohAZEcHA@mail.gmail.com>
 <20160419094629.GP3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f67.google.com (mail-vk0-f67.google.com
 [209.85.213.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D02B265074
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 20:14:42 +0200 (CEST)
Received: by mail-vk0-f67.google.com with SMTP id a6so7617234vkh.1
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 11:14:41 -0700 (PDT)
In-Reply-To: <20160419094629.GP3217@sirena.org.uk>
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

On Tue, Apr 19, 2016 at 2:46 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Apr 18, 2016 at 01:20:35PM -0700, anish kumar wrote:
>> On Mon, Apr 18, 2016 at 9:47 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > As I said last time I would expect this to be a TLV control.  As far as
>> > I can tell this is basically functioning as a maximum volume.  Otherwise
>> > this looks good.
>
>> I responded to your comment earlier but there was no reply so I thought
>> it is accepted this way. Excuse my understanding. It is not actually a volume
>> but described as such.
>
> If it's measured in dB I'd still expect a TLV control.
>
>> It is "Speaker No-Load Output Voltage Maximum". It is
>> described here on page 50.
>> https://datasheets.maximintegrated.com/en/ds/MAX98371.pdf
>
> Hrm, that looks like the driver may be able to set it automatically
> using the regulator API and just have a switch for the guaranteed.

Should i pass it via device tree then? I didn't get your statement about
"switch".
